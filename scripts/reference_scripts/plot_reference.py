"""
==============================================================================
REFERENCE PLOT & REPORT SCRIPT
------------------------------------------------------------------------------
Generic plotting + HTML report generator for ngspice sweep results.
Copy this file into your <block>/scripts/ directory and adapt the sections
marked  # === USER EDIT ===  to fit your simulation.

What this script does (and what stays the same across blocks):
  - scans DATA_DIR for <SIM_NAME>_<tag>.dat files
  - loads each file (ngspice wrdata format: t,sig, t,sig, ... pairs)
  - runs a user-supplied signal-analysis function to extract metrics
  - generates a per-combination PNG (waveform subplots + metric tables)
  - prints a terminal summary table grouped by corner
  - emits an HTML report with tabs (summary + one panel per combination)

What you MUST edit before running:
  1. SIM_NAME          — must match the prefix used by run_sweep_reference.sh
  2. SIGNALS list      — describes the columns in your .dat files
  3. METRICS list      — names, units, formatting, warning thresholds
  4. analyze_signals() — your analysis (frequency, gain, settling time, ...)
  5. Subplot layout in make_plot() if your sim needs more/fewer panels
==============================================================================
"""

import sys
import os
import glob
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt


# ==============================================================================
# === USER EDIT ===  PATHS & NAMING
# ------------------------------------------------------------------------------
# SIM_NAME must match the prefix used by the sweep script (filenames are
# <SIM_NAME>_<tag>.dat). The report filename also derives from this.
# ==============================================================================

SIM_NAME = 'myblock'

SCRIPT_DIR  = os.path.dirname(os.path.abspath(__file__))
DATA_DIR    = os.path.join(SCRIPT_DIR, '../results/data')
RESULTS_DIR = os.path.join(SCRIPT_DIR, '../results')
os.makedirs(RESULTS_DIR, exist_ok=True)


# ==============================================================================
# === USER EDIT ===  SIGNAL CONFIG
# ------------------------------------------------------------------------------
# Describes the column layout of your .dat file. ngspice's wrdata writes one
# time column per signal, so for N signals you get 2N columns in this order:
#   time_1, signal_1, time_2, signal_2, ..., time_N, signal_N
#
# Each entry in SIGNALS must match the order of signals in your `wrdata` line
# in the sweep script. The 'key' is how the signal is referenced in the rest
# of this script (load_dat dict, analyze_signals, make_plot).
#
# Fields:
#   key    — internal name (no spaces)
#   label  — display name on plots
#   unit   — 'V' for voltages, 'A' for currents, etc.
#   color  — matplotlib color for the waveform plot
#   sign   — multiplier applied on load (-1 to flip current direction, etc.)
#   scale  — display scale (1e3 for mA from A, 1e9 for ns from s, ...)
# ==============================================================================

SIGNALS = [
    # TODO: USER — replace with your actual signals (must match wrdata order)
    {'key': 'sig1', 'label': 'v(node1)', 'unit': 'V', 'color': 'royalblue', 'sign': +1, 'scale': 1},
    {'key': 'sig2', 'label': 'v(node2)', 'unit': 'V', 'color': 'darkorange', 'sign': +1, 'scale': 1},
    {'key': 'isup', 'label': 'i(Vsup)',  'unit': 'mA', 'color': 'crimson',   'sign': -1, 'scale': 1e3},
]


# ==============================================================================
# === USER EDIT ===  METRICS CONFIG
# ------------------------------------------------------------------------------
# Describes the metrics produced by analyze_signals() — used for:
#   - the per-combination metric tables in PNG plots
#   - column headers in terminal & HTML summary tables
#   - cell coloring (warn/error thresholds, e.g. duty cycle deviation)
#
# Each metric entry:
#   key            — must match a key returned by analyze_signals()
#   label          — short label for tables (e.g. 'freq', 'DC', 'Avg I')
#   unit           — display unit ('MHz', '%', 'mA', ...)
#   scale          — multiplier applied before display (1e-6 for Hz→MHz, etc.)
#   decimals       — number of decimal places
#   group          — which signal/group this metric belongs to (for grouping
#                    into per-signal cards in plots and HTML detail panels)
#   in_summary     — include in the top-level summary table (True/False)
#   warn_target    — optional float; reference value for warning thresholds
#   warn_tol       — optional [warn_threshold, err_threshold] absolute deviation
#                    from warn_target (e.g. [5, 10] for duty cycle ±5/±10%)
# ==============================================================================

METRICS = [
    # TODO: USER — replace with metrics your analyze_signals() returns
    {'key': 'freq_sig1', 'label': 'f sig1',    'unit': 'MHz', 'scale': 1e-6, 'decimals': 3,
     'group': 'sig1', 'in_summary': True},
    {'key': 'dc_sig1',   'label': 'DC sig1',   'unit': '%',   'scale': 1,    'decimals': 1,
     'group': 'sig1', 'in_summary': True, 'warn_target': 50.0, 'warn_tol': [5, 10]},
    {'key': 'i_avg',     'label': 'Avg I',     'unit': 'mA',  'scale': 1,    'decimals': 3,
     'group': 'isup', 'in_summary': True},
    {'key': 'i_max',     'label': 'Max I',     'unit': 'mA',  'scale': 1,    'decimals': 3,
     'group': 'isup', 'in_summary': True},
]


# ==============================================================================
# === USER EDIT ===  TAG PARSING
# ------------------------------------------------------------------------------
# The sweep script names files <SIM_NAME>_<corner>_T<temp>_Vp<vdd>.dat
# (plus any extra axes you added, like _Vin<vin>).
#
# parse_tag() must return a dict whose keys match the headers used in the
# summary table (CONDITION_COLS below) and the table on each plot.
#
# If you add a sweep axis in run_sweep_reference.sh, you must:
#   1. Extract it here in parse_tag()
#   2. Add its key to CONDITION_COLS
#   3. Add it to the sort key in the summary sort (search "summary.sort")
# ==============================================================================

CONDITION_COLS = ['corner', 'temp', 'vdd']  # add 'vin' etc. if you have extra axes

def parse_tag(tag):
    """Parse a filename tag like 'mos_tt_T27_Vp1.2' into a dict of conditions."""
    parts = tag.split('_')
    # Corner is typically 'mos_tt' (two underscore-separated parts).
    # Adjust if your corner naming differs.
    corner = '_'.join(parts[:2])
    temp = next((p[1:]  for p in parts if p.startswith('T')  and len(p) > 1 and p[1].lstrip('-').replace('.','').isdigit()), '?')
    vdd  = next((p[2:]  for p in parts if p.startswith('Vp')), '?')
    return {'corner': corner, 'temp': temp, 'vdd': vdd}
    # === USER EDIT === for extra axes add e.g.:
    # vin = next((p[3:] for p in parts if p.startswith('Vin')), '?')
    # return {'corner': corner, 'temp': temp, 'vdd': vdd, 'vin': vin}


# ==============================================================================
# DATA LOADING  (generic, driven by SIGNALS config — no edit needed)
# ==============================================================================

def load_dat(path):
    """
    Load an ngspice wrdata .dat file. Returns a dict with time_<key> and
    <key> arrays for each signal in SIGNALS, or None if the file is malformed.
    """
    expected_cols = 2 * len(SIGNALS)
    try:
        data = np.loadtxt(path, skiprows=1)
        if data.ndim < 2 or data.shape[1] < expected_cols:
            print(f"  [WARN] {path}: expected {expected_cols} columns, got {data.shape}")
            return None
        out = {}
        for i, sig in enumerate(SIGNALS):
            out[f"time_{sig['key']}"] = data[:, 2*i]
            out[sig['key']]           = data[:, 2*i + 1] * sig['sign'] * sig['scale']
        return out
    except Exception as e:
        print(f"  [WARN] Cannot read {path}: {e}")
        return None


# ==============================================================================
# === USER EDIT ===  SIGNAL ANALYSIS
# ------------------------------------------------------------------------------
# Compute the metrics declared in METRICS from the loaded data.
# Must return a dict whose keys match the 'key' field of each METRICS entry.
# Return None for any metric that couldn't be computed (e.g. flat signal).
#
# `d` is the dict returned by load_dat(): for each signal `key` it has
#     d['time_<key>']  — time vector
#     d['<key>']       — signal vector (already sign-flipped & scaled)
#
# Typical patterns:
#   - frequency / duty / rise / fall: find zero-crossings on last fraction of t
#   - settling time: find last excursion outside ±tol around final value
#   - gain: ratio of output to input amplitude
#   - average / max / RMS: numpy reductions on the signal vector
# ==============================================================================

def analyze_signals(d):
    """
    Compute metrics from loaded waveform dict.
    Returns dict with one entry per METRICS key, or None for failed metrics.
    """
    metrics = {}

    # TODO: USER — implement your analysis here.
    # Below is a stub that returns None for every declared metric so the
    # plotting & report scaffolding can still run end-to-end.
    for m in METRICS:
        metrics[m['key']] = None

    # Example sketches (uncomment & adapt):
    #
    # # Average / max of a current signal (already sign-flipped via SIGNALS)
    # if 'isup' in d:
    #     metrics['i_avg'] = float(np.mean(d['isup']))
    #     metrics['i_max'] = float(np.max(d['isup']))
    #
    # # Frequency from zero-crossings on the last 30% of the signal
    # t, v = d['time_sig1'], d['sig1']
    # vmin, vmax = v.min(), v.max()
    # if (vmax - vmin) > 0.05:
    #     v50 = vmin + 0.5 * (vmax - vmin)
    #     mask = t >= t[-1] * 0.7
    #     tt, vv = t[mask], v[mask]
    #     above = (vv >= v50).astype(int)
    #     rising_idx = np.where(np.diff(above) == 1)[0]
    #     if len(rising_idx) >= 2:
    #         # linear-interpolate the two crossings
    #         def cross(i):
    #             return tt[i] + (v50 - vv[i]) * (tt[i+1]-tt[i]) / (vv[i+1]-vv[i])
    #         period = cross(rising_idx[1]) - cross(rising_idx[0])
    #         metrics['freq_sig1'] = 1.0 / period if period > 0 else None

    return metrics


# ==============================================================================
# FORMATTING HELPERS  (generic — no edit needed)
# ==============================================================================

def fmt_metric(value, metric_cfg, include_unit=True):
    """Format a metric value according to its METRICS config entry."""
    if value is None:
        return 'N/A'
    try:
        s = f"{value * metric_cfg['scale']:.{metric_cfg['decimals']}f}"
        if include_unit and metric_cfg.get('unit'):
            s += f" {metric_cfg['unit']}"
        return s
    except Exception:
        return 'N/A'

def warn_color(value, metric_cfg):
    """Return a background color string for a metric cell based on warn_tol."""
    if value is None or 'warn_target' not in metric_cfg or 'warn_tol' not in metric_cfg:
        return '#ffffff'
    try:
        v = float(value) * metric_cfg['scale']
        warn_thr, err_thr = metric_cfg['warn_tol']
        dev = abs(v - metric_cfg['warn_target'])
        if dev > err_thr:
            return '#ffcccc'   # red — error
        elif dev > warn_thr:
            return '#ffe5cc'   # orange — warning
    except Exception:
        pass
    return '#ffffff'


# ==============================================================================
# === USER EDIT ===  PLOT LAYOUT
# ------------------------------------------------------------------------------
# Builds the per-combination PNG. The default layout is a 2×3 grid:
#     row 1: one waveform subplot per signal (up to 3)
#     row 2: one metric table per signal group + a conditions table
#
# If you have more/fewer signals or want a different layout, edit the grid
# dimensions and the loop below. The metric-table logic uses METRICS groupings
# automatically, so adding a metric to METRICS will make it appear here too.
# ==============================================================================

def make_plot(d, metrics, tag, conditions, out_path):
    n_signals = len(SIGNALS)
    fig = plt.figure(figsize=(16, 10))
    fig.suptitle(f'{SIM_NAME.upper()} — {tag}', fontsize=13, fontweight='bold')

    def safe(arr):
        a = np.array(arr, dtype=np.float64)
        a[~np.isfinite(a)] = np.nan
        return a

    # --- Row 1: waveform subplots, one per signal -----------------------------
    for i, sig in enumerate(SIGNALS):
        ax = fig.add_subplot(2, max(n_signals, 3), i + 1)
        if d is not None:
            ax.plot(safe(d[f"time_{sig['key']}"]) * 1e9,
                    safe(d[sig['key']]),
                    color=sig['color'], linewidth=0.8)
        else:
            ax.text(0.5, 0.5, 'No data', ha='center', va='center',
                    transform=ax.transAxes, color='gray')
        ax.set_xlabel('Time [ns]')
        ax.set_ylabel(f"{sig['label']} [{sig['unit']}]")
        ax.set_title(sig['label'])
        ax.grid(True, alpha=0.3)

    # --- Row 2: metric tables grouped by signal + conditions table ------------
    # Group metrics by their 'group' field
    groups = {}
    for m in METRICS:
        groups.setdefault(m['group'], []).append(m)

    n_cells_row2 = max(len(groups) + 1, 3)
    slot = n_signals + 1   # subplot indices start after row 1

    for grp_name, grp_metrics in groups.items():
        ax = fig.add_subplot(2, n_cells_row2, slot)
        ax.axis('off')
        rows = [[m['label'], fmt_metric(metrics.get(m['key']), m, include_unit=False)
                 + (f" {m['unit']}" if m.get('unit') else '')]
                for m in grp_metrics]
        if rows:
            t = ax.table(cellText=rows, colLabels=[f'{grp_name}', 'Value'],
                         cellLoc='center', loc='center', colWidths=[0.65, 0.35])
            t.auto_set_font_size(False); t.set_fontsize(10); t.scale(1, 1.8)
            # Color warning cells
            for ridx, m in enumerate(grp_metrics):
                color = warn_color(metrics.get(m['key']), m)
                if color != '#ffffff':
                    t[ridx + 1, 1].set_facecolor(color)
        ax.set_title(f'Metrics: {grp_name}', pad=10)
        slot += 1

    # Conditions table (corner / temp / vdd / extra axes)
    ax = fig.add_subplot(2, n_cells_row2, slot)
    ax.axis('off')
    cond_rows = [[c, conditions.get(c, '?')] for c in CONDITION_COLS]
    t = ax.table(cellText=cond_rows, colLabels=['Parameter', 'Value'],
                 cellLoc='center', loc='center', colWidths=[0.6, 0.4])
    t.auto_set_font_size(False); t.set_fontsize(10); t.scale(1, 1.8)
    ax.set_title('Conditions', pad=10)

    plt.tight_layout()
    plt.savefig(out_path, dpi=150)
    plt.close()


# ==============================================================================
# MAIN LOOP — load, analyze, plot  (generic — no edit needed)
# ==============================================================================

dat_files = sorted(glob.glob(os.path.join(DATA_DIR, f'{SIM_NAME}_*.dat')))
if not dat_files:
    print(f"No .dat files in {DATA_DIR}")
    sys.exit(1)

summary = []
total_files = len(dat_files)

for idx, filepath in enumerate(dat_files, 1):
    tag = os.path.basename(filepath).replace(f'{SIM_NAME}_', '').replace('.dat', '')
    conditions = parse_tag(tag)

    d = load_dat(filepath)
    metrics = analyze_signals(d) if d is not None else {m['key']: None for m in METRICS}

    out_png = os.path.join(RESULTS_DIR, f'{SIM_NAME}_{tag}.png')
    try:
        make_plot(d, metrics, tag, conditions, out_png)
    except Exception as e:
        sys.stderr.write(f"  [WARN] Plot error for {tag}: {e}\n")
        plt.close('all')

    pct = idx * 100 // total_files
    print(f"\r{pct}% of report done", end='', flush=True)

    summary.append((tag, conditions, metrics))

print()  # newline after progress


# ==============================================================================
# === USER EDIT ===  SUMMARY SORTING
# ------------------------------------------------------------------------------
# Controls the row order in summary tables. Default: by corner (with mos_tt
# first), then by numeric value of any extra axes, then temperature, then vdd.
# Add/remove keys in the lambda to match your sweep axes.
# ==============================================================================

corner_order = {'mos_tt': 0, 'mos_ss': 1, 'mos_ff': 2, 'mos_sf': 3, 'mos_fs': 4}

def _num(s):
    try: return float(s)
    except (ValueError, TypeError): return 0.0

summary.sort(key=lambda x: (
    corner_order.get(x[1].get('corner'), 99),
    _num(x[1].get('temp')),
    _num(x[1].get('vdd')),
    # === USER EDIT === add extra axes here, e.g. _num(x[1].get('vin'))
))


# ==============================================================================
# TERMINAL SUMMARY TABLE  (generic — driven by METRICS in_summary=True)
# ==============================================================================

summary_metrics = [m for m in METRICS if m.get('in_summary')]

HEADERS = CONDITION_COLS + [m['label'] for m in summary_metrics]
COL_W   = [max(8, len(h) + 2) for h in HEADERS]

def _row_str(vals):
    return '  '.join(str(v).rjust(w) for v, w in zip(vals, COL_W))

print()
current_corner = None
for tag, conds, m in summary:
    if conds.get('corner') != current_corner:
        current_corner = conds.get('corner')
        print(f'\n{current_corner}')
        print('  ' + _row_str(HEADERS))
        print('  ' + '-' * (sum(COL_W) + 2 * len(COL_W)))
    cond_vals  = [conds.get(c, '?') for c in CONDITION_COLS]
    metric_vals = [fmt_metric(m.get(mc['key']), mc) for mc in summary_metrics]
    print('  ' + _row_str(cond_vals + metric_vals))
print()


# ==============================================================================
# HTML REPORT  (generic — tabs, summary panel, detail panels)
# ------------------------------------------------------------------------------
# The HTML layout itself is sim-agnostic. Customize CSS or panel structure
# below if you want a different visual style.
# ==============================================================================

# --- Tabs ---
html_tabs = '<button class="tab active" onclick="showTab(\'summary\', this)">Summary</button>\n'
for tag, conds, _ in summary:
    label = ' '.join(f"{k}={conds.get(k, '?')}" for k in CONDITION_COLS)
    html_tabs += f'<button class="tab" onclick="showTab(\'{tag}\', this)">{label}</button>\n'

# --- Summary table ---
n_cols = len(CONDITION_COLS) + len(summary_metrics)
summary_rows = ''
current_corner = None
for tag, conds, m in summary:
    if conds.get('corner') != current_corner:
        current_corner = conds.get('corner')
        summary_rows += f'<tr class="corner-header"><td colspan="{n_cols}"><b>{current_corner}</b></td></tr>\n'
    cells = ''
    for c in CONDITION_COLS:
        cells += f'<td>{conds.get(c, "?")}</td>'
    for mc in summary_metrics:
        val   = m.get(mc['key'])
        color = warn_color(val, mc)
        bg    = f' style="background:{color} !important"' if color != '#ffffff' else ''
        cells += f'<td{bg}>{fmt_metric(val, mc)}</td>'
    summary_rows += f'<tr>{cells}</tr>\n'

th_cells = ''.join(f'<th>{c}</th>' for c in CONDITION_COLS)
th_cells += ''.join(f'<th>{m["label"]} [{m.get("unit", "")}]</th>' for m in summary_metrics)

html_summary_panel = f'''
<div id="summary" class="panel active">
    <h2>Summary — {SIM_NAME} across corners</h2>
    <table class="summary">
        <thead><tr>{th_cells}</tr></thead>
        <tbody>{summary_rows}</tbody>
    </table>
    <div class="legend">
        <span class="leg-ok">&#9632; OK</span>
        <span class="leg-warn">&#9632; warning (within tolerance)</span>
        <span class="leg-err">&#9632; error (out of tolerance)</span>
    </div>
</div>'''

# --- Detail panels (one per sweep point) ---
groups = {}
for mc in METRICS:
    groups.setdefault(mc['group'], []).append(mc)

html_detail_panels = ''
for tag, conds, m in summary:
    png_name = f'{SIM_NAME}_{tag}.png'
    header_cells = ' — '.join(f"{k}={conds.get(k, '?')}" for k in CONDITION_COLS)

    # Per-group metric cards
    group_cards = ''
    for grp_name, grp_metrics in groups.items():
        rows = ''
        for mc in grp_metrics:
            val   = m.get(mc['key'])
            color = warn_color(val, mc)
            bg    = f' style="background:{color}"' if color != '#ffffff' else ''
            rows += f'<div class="mrow"{bg}><span>{mc["label"]}</span><span>{fmt_metric(val, mc)}</span></div>'
        group_cards += f'''
        <div class="mcard">
            <div class="mcard-title">{grp_name}</div>
            {rows}
        </div>'''

    inner = f'''
    <h2>{header_cells}</h2>
    <div class="card">
        <img src="{png_name}" style="max-width:100%">
    </div>
    <div class="metrics-grid">{group_cards}</div>'''
    html_detail_panels += f'<div id="{tag}" class="panel">{inner}</div>\n'

# --- Full HTML document ---
html = f'''<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>{SIM_NAME} Sweep Report</title>
<style>
    body {{ font-family: Arial, sans-serif; margin: 20px; background: #f0f2f5; }}
    h1 {{ color: #222; }}
    h2 {{ color: #333; border-bottom: 2px solid #27ae60; padding-bottom: 6px; }}
    h3 {{ color: #555; margin: 8px 0; }}
    .tabs {{ display: flex; flex-wrap: wrap; gap: 4px; margin-bottom: 16px; }}
    .tab {{ padding: 8px 14px; background: #ddd; border: none; cursor: pointer;
            border-radius: 4px; font-size: 12px; }}
    .tab:hover {{ background: #bbb; }}
    .tab.active {{ background: #27ae60; color: white; }}
    .panel {{ display: none; background: white; padding: 20px; border-radius: 8px;
              box-shadow: 0 2px 6px rgba(0,0,0,0.1); }}
    .panel.active {{ display: block; }}
    .card {{ margin-bottom: 20px; border: 1px solid #ddd; border-radius: 6px; padding: 12px; }}
    table.summary {{ border-collapse: collapse; width: 100%; font-size: 13px; }}
    table.summary th {{ background: #27ae60; color: white; padding: 8px; text-align: center; }}
    table.summary td {{ padding: 6px 10px; border: 1px solid #ddd; text-align: center; }}
    tr.corner-header td {{ background: #e8f5e9; font-size: 14px; padding: 8px; text-align: left; }}
    .legend {{ margin-top: 12px; display: flex; gap: 20px; font-size: 13px; }}
    .leg-ok   {{ color: #2a2; }}
    .leg-warn {{ color: #e80; }}
    .leg-err  {{ color: #d00; }}
    .metrics-grid {{ display: flex; gap: 16px; flex-wrap: wrap; margin-top: 16px; }}
    .mcard {{ flex: 1; min-width: 200px; border: 1px solid #ddd; border-radius: 6px;
              padding: 12px; background: #fafafa; }}
    .mcard-title {{ font-weight: bold; color: #27ae60; margin-bottom: 8px;
                    font-size: 14px; border-bottom: 1px solid #ddd; padding-bottom: 4px; }}
    .mrow {{ display: flex; justify-content: space-between; padding: 4px 0;
             font-size: 13px; border-bottom: 1px solid #f0f0f0; }}
    .mrow span:last-child {{ font-weight: bold; color: #333; }}
</style>
</head>
<body>
<h1>{SIM_NAME} Sweep Report</h1>
<div class="tabs">
{html_tabs}
</div>
{html_summary_panel}
{html_detail_panels}
<script>
function showTab(id, btn) {{
    document.querySelectorAll('.panel').forEach(p => p.classList.remove('active'));
    document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
    document.getElementById(id).classList.add('active');
    if (btn) btn.classList.add('active');
}}
</script>
</body>
</html>'''

html_path = os.path.join(RESULTS_DIR, f'{SIM_NAME}_report.html')
with open(html_path, 'w') as f:
    f.write(html)
print(f"Report saved: {html_path}")
