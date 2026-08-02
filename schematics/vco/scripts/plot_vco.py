import sys
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import glob
import os

SCRIPT_DIR  = os.path.dirname(os.path.abspath(__file__))
DATA_DIR    = os.path.join(SCRIPT_DIR, '../results/data')
RESULTS_DIR = os.path.join(SCRIPT_DIR, '../results')
os.makedirs(RESULTS_DIR, exist_ok=True)

# ── Wczytanie pliku .dat (format ngspice wrdata) ───────────────────────────────
# wrdata zapisuje: t v(out_pb)  t v(out)  t i(V2)  — 6 kolumn
def load_dat(path):
    try:
        data = np.loadtxt(path, skiprows=1)
        if data.ndim < 2 or data.shape[1] < 6:
            print(f"  [WARN] {path}: oczekiwano 6 kolumn, jest {data.shape}")
            return None
        return {
            'time_pb':  data[:, 0],
            'v_out_pb': data[:, 1],
            'time_out': data[:, 2],
            'v_out':    data[:, 3],
            'time_i':   data[:, 4],
            'i_v2':     data[:, 5],
        }
    except Exception as e:
        print(f"  [WARN] Nie mozna odczytac {path}: {e}")
        return None

# ── Analiza sygnalu — ostatnie 30% symulacji ───────────────────────────────────
def analyze_signal(time, voltage, last_fraction=0.3):
    """
    Zwraca (freq_hz, duty_pct, tr_ps, tf_ps) liczone na ostatnich
    last_fraction czasu symulacji. None jesli sygnal plaski / za malo krawedzi.
    """
    vmin, vmax = voltage.min(), voltage.max()
    if (vmax - vmin) < 0.05:
        return None, None, None, None

    v10 = vmin + 0.10 * (vmax - vmin)
    v50 = vmin + 0.50 * (vmax - vmin)
    v90 = vmin + 0.90 * (vmax - vmin)

    t_start = time[-1] * (1.0 - last_fraction)
    mask = time >= t_start
    t = time[mask]
    v = voltage[mask]

    def crossings(t_arr, v_arr, level, direction):
        above = (v_arr >= level).astype(int)
        edges = np.diff(above)
        idxs  = np.where(edges == direction)[0]
        result = []
        for i in idxs:
            t0, t1 = t_arr[i], t_arr[i+1]
            v0, v1 = v_arr[i], v_arr[i+1]
            if v1 != v0:
                result.append(t0 + (level - v0) * (t1 - t0) / (v1 - v0))
        return np.array(result)

    rising_50  = crossings(t, v, v50, +1)
    falling_50 = crossings(t, v, v50, -1)

    if len(rising_50) < 2 or len(falling_50) < 1:
        return None, None, None, None

    t_r0 = rising_50[0]
    f_after = falling_50[falling_50 > t_r0]
    if len(f_after) == 0:
        return None, None, None, None
    t_f0 = f_after[0]
    r_after = rising_50[rising_50 > t_f0]
    if len(r_after) == 0:
        return None, None, None, None
    t_r1 = r_after[0]

    period = t_r1 - t_r0
    if period <= 0:
        return None, None, None, None

    freq_hz    = 1.0 / period
    duty_pct   = 100.0 * (t_f0 - t_r0) / period

    # Czas narastania 10%→90%
    rising_10 = crossings(t, v, v10, +1)
    rising_90 = crossings(t, v, v90, +1)
    r10_before = rising_10[rising_10 <= t_r0]
    r90_after  = rising_90[rising_90 >= t_r0]
    if len(r10_before) > 0 and len(r90_after) > 0:
        dt = r90_after[0] - r10_before[-1]
        tr_ps = dt * 1e12 if 0 < dt < period / 2 else None
    else:
        tr_ps = None

    # Czas opadania 90%→10%
    falling_10 = crossings(t, v, v10, -1)
    falling_90 = crossings(t, v, v90, -1)
    f90_before = falling_90[falling_90 <= t_f0]
    f10_after  = falling_10[falling_10 >= t_f0]
    if len(f90_before) > 0 and len(f10_after) > 0:
        dt = f10_after[0] - f90_before[-1]
        tf_ps = dt * 1e12 if 0 < dt < period / 2 else None
    else:
        tf_ps = None

    return freq_hz, duty_pct, tr_ps, tf_ps

# ── Parsowanie taga ────────────────────────────────────────────────────────────
def parse_tag(tag):
    parts = tag.split('_')
    corner = '_'.join(parts[:2])
    temp = next((p.replace('T','')   for p in parts if p.startswith('T')   and p != parts[0] and p != parts[1]), '?')
    vp   = next((p.replace('Vp','')  for p in parts if p.startswith('Vp')),  '?')
    vin  = next((p.replace('Vin','') for p in parts if p.startswith('Vin')), '?')
    return corner, temp, vp, vin

# ── Generowanie wykresow ───────────────────────────────────────────────────────
def make_plot(d, metrics, tag, out_path):
    corner, temp, vp, vin = parse_tag(tag)

    fig = plt.figure(figsize=(16, 10))
    fig.suptitle(f'VCO Charakterystyka — {tag}', fontsize=13, fontweight='bold')

    def safe(arr):
        a = np.array(arr, dtype=np.float64)
        a[~np.isfinite(a)] = np.nan
        return a

    # Ax1: v(out) — caly czas
    ax1 = fig.add_subplot(2, 3, 1)
    if d is not None:
        ax1.plot(safe(d['time_out'])*1e9, safe(d['v_out']), color='royalblue', linewidth=0.8)
        try:
            ax1.set_ylim(-0.05, float(vp)+0.05)
        except Exception:
            pass
    else:
        ax1.text(0.5, 0.5, 'Brak danych', ha='center', va='center',
                 transform=ax1.transAxes, color='gray')
    ax1.set_xlabel('Czas [ns]')
    ax1.set_ylabel('Napiecie [V]')
    ax1.set_title('Przebieg v(out)')
    ax1.grid(True, alpha=0.3)

    # Ax2: v(out_pb) — caly czas
    ax2 = fig.add_subplot(2, 3, 2)
    if d is not None:
        ax2.plot(safe(d['time_pb'])*1e9, safe(d['v_out_pb']), color='darkorange', linewidth=0.8)
        try:
            ax2.set_ylim(-0.05, float(vp)+0.05)
        except Exception:
            pass
    else:
        ax2.text(0.5, 0.5, 'Brak danych', ha='center', va='center',
                 transform=ax2.transAxes, color='gray')
    ax2.set_xlabel('Czas [ns]')
    ax2.set_ylabel('Napiecie [V]')
    ax2.set_title('Przebieg v(out_pb)')
    ax2.grid(True, alpha=0.3)

    # Ax3: i(V2) — caly czas
    ax3 = fig.add_subplot(2, 3, 3)
    i_avg = metrics.get('i_avg_v2')
    i_max = metrics.get('i_max_v2')
    if d is not None:
        iv = -safe(d['i_v2']) * 1e3  # znak: prad pobierany z VDD > 0
        ax3.plot(safe(d['time_i'])*1e9, iv, color='crimson', linewidth=0.8)
        if i_avg is not None:
            ax3.axhline(i_avg, color='navy', linewidth=1.5, linestyle='--',
                        label=f'Avg={i_avg:.2f} mA')
        if i_max is not None:
            ax3.axhline(i_max, color='green', linewidth=1.5, linestyle=':',
                        label=f'Max={i_max:.2f} mA')
        ax3.legend(fontsize=9)
    else:
        ax3.text(0.5, 0.5, 'Brak danych', ha='center', va='center',
                 transform=ax3.transAxes, color='gray')
    ax3.set_xlabel('Czas [ns]')
    ax3.set_ylabel('Prad [mA]')
    ax3.set_title('Prad zrodla V2 (VDD)')
    ax3.grid(True, alpha=0.3)

    def fmtv(v, scale=1, unit='', dec=3):
        if v is None:
            return 'N/A'
        return f'{v*scale:.{dec}f} {unit}'.strip()

    # Ax4: metryki v(out)
    ax4 = fig.add_subplot(2, 3, 4)
    ax4.axis('off')
    rows4 = [
        ['Czestotliwosc [MHz]', fmtv(metrics.get('freq_out'), 1e-6, '', 3)],
        ['Duty cycle [%]',      fmtv(metrics.get('dc_out'),   1,    '', 1)],
    ]
    t4 = ax4.table(cellText=rows4, colLabels=['Parametr v(out)', 'Wartosc'],
                   cellLoc='center', loc='center', colWidths=[0.65, 0.35])
    t4.auto_set_font_size(False); t4.set_fontsize(10); t4.scale(1, 1.8)
    _color_dc(t4, rows4)
    ax4.set_title('Parametry v(out)', pad=10)

    # Ax5: metryki v(out_pb)
    ax5 = fig.add_subplot(2, 3, 5)
    ax5.axis('off')
    rows5 = [
        ['Czestotliwosc [MHz]',  fmtv(metrics.get('freq_pb'),   1e-6, '', 3)],
        ['Czas narastania [ps]', fmtv(metrics.get('tr_pb'),     1,    '', 1)],
        ['Czas opadania [ps]',   fmtv(metrics.get('tf_pb'),     1,    '', 1)],
        ['Duty cycle [%]',       fmtv(metrics.get('dc_pb'),     1,    '', 1)],
    ]
    t5 = ax5.table(cellText=rows5, colLabels=['Parametr v(out_pb)', 'Wartosc'],
                   cellLoc='center', loc='center', colWidths=[0.65, 0.35])
    t5.auto_set_font_size(False); t5.set_fontsize(10); t5.scale(1, 1.8)
    _color_dc(t5, rows5)
    ax5.set_title('Parametry v(out_pb)', pad=10)

    # Ax6: warunki + prad
    ax6 = fig.add_subplot(2, 3, 6)
    ax6.axis('off')
    pdiss = None
    if i_avg is not None:
        try:
            pdiss = i_avg * float(vp)
        except Exception:
            pass
    rows6 = [
        ['Corner',          corner],
        ['Temperatura [C]', temp],
        ['VDD [V]',         vp],
        ['Vin [V]',         vin],
        ['Avg Ivdd [mA]',   fmtv(i_avg)],
        ['Max Ivdd [mA]',   fmtv(i_max)],
        ['Avg Pdiss [mW]',  fmtv(pdiss)],
    ]
    t6 = ax6.table(cellText=rows6, colLabels=['Parametr', 'Wartosc'],
                   cellLoc='center', loc='center', colWidths=[0.6, 0.4])
    t6.auto_set_font_size(False); t6.set_fontsize(10); t6.scale(1, 1.8)
    ax6.set_title('Warunki symulacji', pad=10)

    plt.tight_layout()
    plt.savefig(out_path, dpi=150)
    plt.close()


def _color_dc(table, rows):
    for i, row in enumerate(rows):
        if 'Duty cycle' in row[0] and row[1] != 'N/A':
            try:
                dc = float(row[1])
                if abs(dc - 50.0) > 10:
                    table[i+1, 1].set_facecolor('#ffcccc')
                elif abs(dc - 50.0) > 5:
                    table[i+1, 1].set_facecolor('#ffe5cc')
            except Exception:
                pass


# ── Glowna petla ───────────────────────────────────────────────────────────────
dat_files = sorted(glob.glob(os.path.join(DATA_DIR, 'vco_*.dat')))
if not dat_files:
    print("Brak plikow .dat w", DATA_DIR)
    exit(1)

summary = []
total_files = len(dat_files)
for idx, filepath in enumerate(dat_files, 1):
    tag = os.path.basename(filepath).replace('vco_', '').replace('.dat', '')
    corner, temp, vp, vin = parse_tag(tag)

    d = load_dat(filepath)
    metrics = {}

    if d is not None:
        freq_out, dc_out, tr_out, tf_out = analyze_signal(d['time_out'], d['v_out'])
        freq_pb,  dc_pb,  tr_pb,  tf_pb  = analyze_signal(d['time_pb'],  d['v_out_pb'])
        i_avg = float(-np.mean(d['i_v2']) * 1e3)
        i_max = float(-np.min(d['i_v2'])  * 1e3)
        metrics = {
            'freq_out': freq_out,
            'dc_out':   dc_out,
            'tr_out':   tr_out,
            'tf_out':   tf_out,
            'freq_pb':  freq_pb,
            'dc_pb':    dc_pb,
            'tr_pb':    tr_pb,
            'tf_pb':    tf_pb,
            'i_avg_v2': i_avg,
            'i_max_v2': i_max,
        }

    out_png = os.path.join(RESULTS_DIR, f'vco_{tag}.png')
    try:
        make_plot(d, metrics, tag, out_png)
    except Exception as e:
        sys.stderr.write(f"  [WARN] Blad wykresu {tag}: {e}\n")
        plt.close('all')

    pct = idx * 100 // total_files
    print(f"\r{pct}% of report done", end='', flush=True)

    summary.append((tag, corner, temp, vp, vin, metrics))

print()  # nowa linia po zakończeniu pętli

corner_order = {'mos_tt': 0, 'mos_ss': 1, 'mos_ff': 2, 'mos_sf': 3, 'mos_fs': 4}
summary.sort(key=lambda x: (corner_order.get(x[1], 99), float(x[4]), float(x[2]), float(x[3])))


# ── HTML ───────────────────────────────────────────────────────────────────────
def fmth(v, scale=1, unit='', dec=3):
    if v is None:
        return 'N/A'
    try:
        return f'{v*scale:.{dec}f} {unit}'.strip()
    except Exception:
        return 'N/A'

def dc_color(dc):
    """dc to surowa wartosc float (nie string)."""
    if dc is None:
        return '#ffffff'
    try:
        v = float(dc)
        if abs(v - 50.0) > 10:
            return '#ffcccc'
        elif abs(v - 50.0) > 5:
            return '#ffe5cc'
    except Exception:
        pass
    return '#ffffff'

# ── Terminal summary ───────────────────────────────────────────────────────────
COL_W = [6, 5, 5, 9, 9, 10, 10, 7, 9, 10, 10]
HEADERS = ['TEMP', 'VDD', 'Vin', 'fout', 'fout_pb', 'trout_pb', 'tfout_pb',
           'DCout', 'DCout_pb', 'iavgVDD', 'imaxVDD']

def _row_str(vals):
    return '  '.join(str(v).rjust(w) for v, w in zip(vals, COL_W))

print()
current_corner_t = None
current_vin_t    = None
for tag, corner, temp, vp, vin, m in summary:
    if corner != current_corner_t:
        current_corner_t = corner
        current_vin_t    = None
        print(f'\n{corner}')
        print('  ' + _row_str(HEADERS))
        print('  ' + '-' * (sum(COL_W) + 2 * len(COL_W)))
    if vin != current_vin_t:
        current_vin_t = vin
        if current_corner_t == corner:
            print(f'  -- Vin = {vin} V --')
    row = [
        f'{temp}°C',
        f'{vp}V',
        f'{vin}V',
        fmth(m.get('freq_out'), 1e-6, 'MHz', 3),
        fmth(m.get('freq_pb'),  1e-6, 'MHz', 3),
        fmth(m.get('tr_pb'),    1,    'ps',  1),
        fmth(m.get('tf_pb'),    1,    'ps',  1),
        fmth(m.get('dc_out'),   1,    '%',   1),
        fmth(m.get('dc_pb'),    1,    '%',   1),
        fmth(m.get('i_avg_v2'), 1,    'mA',  3),
        fmth(m.get('i_max_v2'), 1,    'mA',  3),
    ]
    print('  ' + _row_str(row))
print()

# ── HTML tabs ──────────────────────────────────────────────────────────────────
html_tabs = '<button class="tab active" onclick="showTab(\'summary\', this)">Podsumowanie</button>\n'
for tag, corner, temp, vp, vin, _ in summary:
    label = f'{corner} T{temp} {vp}V Vin{vin}V'
    html_tabs += f'<button class="tab" onclick="showTab(\'{tag}\', this)">{label}</button>\n'

# ── HTML summary table ─────────────────────────────────────────────────────────
summary_rows = ''
current_corner = None
current_vin    = None
for tag, corner, temp, vp, vin, m in summary:
    if corner != current_corner:
        current_corner = corner
        current_vin    = None
        summary_rows += f'<tr class="corner-header"><td colspan="11"><b>{corner}</b></td></tr>\n'
    if vin != current_vin:
        current_vin = vin
        summary_rows += f'<tr class="vin-header"><td colspan="11">Vin = {vin} V</td></tr>\n'
    dc_out = m.get('dc_out')
    dc_pb  = m.get('dc_pb')
    summary_rows += f'''<tr>
        <td>{temp} °C</td><td>{vp} V</td><td>{vin} V</td>
        <td>{fmth(m.get("freq_out"), 1e-6, "MHz", 3)}</td>
        <td>{fmth(m.get("freq_pb"),  1e-6, "MHz", 3)}</td>
        <td>{fmth(m.get("tr_pb"),    1,    "ps",  1)}</td>
        <td>{fmth(m.get("tf_pb"),    1,    "ps",  1)}</td>
        <td style="background:{dc_color(dc_out)} !important">{fmth(dc_out, 1, "%", 1)}</td>
        <td style="background:{dc_color(dc_pb)} !important">{fmth(dc_pb,  1, "%", 1)}</td>
        <td>{fmth(m.get("i_avg_v2"), 1, "mA", 3)}</td>
        <td>{fmth(m.get("i_max_v2"), 1, "mA", 3)}</td>
    </tr>'''

html_summary_panel = f'''
<div id="summary" class="panel active">
    <h2>Podsumowanie — VCO po cornerach</h2>
    <table class="summary">
        <thead><tr>
            <th>TEMP</th><th>VDD</th><th>Vin</th>
            <th>f<sub>out</sub> [MHz]</th><th>f<sub>out_pb</sub> [MHz]</th>
            <th>t<sub>r</sub> out_pb [ps]</th><th>t<sub>f</sub> out_pb [ps]</th>
            <th>DC out [%]</th><th>DC out_pb [%]</th>
            <th>I<sub>avg</sub> VDD [mA]</th><th>I<sub>max</sub> VDD [mA]</th>
        </tr></thead>
        <tbody>{summary_rows}</tbody>
    </table>
    <div class="legend">
        <span class="leg-ok">&#9632; DC OK (&lt;±5% od 50%)</span>
        <span class="leg-warn">&#9632; DC ostrzezenie (&gt;±5%)</span>
        <span class="leg-err">&#9632; DC przekroczenie (&gt;±10%)</span>
    </div>
</div>'''

html_detail_panels = ''
for tag, corner, temp, vp, vin, m in summary:
    png_name = f'vco_{tag}.png'
    freq_out = m.get('freq_out')
    color = '#2a2' if freq_out else 'gray'
    inner = f'''
    <h2>{corner} — T={temp}°C — VDD={vp}V — Vin={vin}V</h2>
    <div class="card">
        <h3>f<sub>out</sub> = <span style="color:{color};font-weight:bold">
        {fmth(freq_out, 1e-6, "MHz", 3)}</span></h3>
        <img src="{png_name}" style="max-width:100%">
    </div>
    <div class="metrics-grid">
        <div class="mcard">
            <div class="mcard-title">v(out)</div>
            <div class="mrow"><span>Czestotliwosc</span><span>{fmth(m.get("freq_out"), 1e-6, "MHz", 3)}</span></div>
            <div class="mrow"><span>Czas narastania</span><span>{fmth(m.get("tr_out"), 1, "ps", 1)}</span></div>
            <div class="mrow"><span>Czas opadania</span><span>{fmth(m.get("tf_out"), 1, "ps", 1)}</span></div>
            <div class="mrow"><span>Duty cycle</span><span>{fmth(m.get("dc_out"), 1, "%", 1)}</span></div>
        </div>
        <div class="mcard">
            <div class="mcard-title">v(out_pb)</div>
            <div class="mrow"><span>Czestotliwosc</span><span>{fmth(m.get("freq_pb"), 1e-6, "MHz", 3)}</span></div>
            <div class="mrow"><span>Czas narastania</span><span>{fmth(m.get("tr_pb"), 1, "ps", 1)}</span></div>
            <div class="mrow"><span>Czas opadania</span><span>{fmth(m.get("tf_pb"), 1, "ps", 1)}</span></div>
            <div class="mrow"><span>Duty cycle</span><span>{fmth(m.get("dc_pb"), 1, "%", 1)}</span></div>
        </div>
        <div class="mcard">
            <div class="mcard-title">Zasilanie V2 (VDD={vp}V)</div>
            <div class="mrow"><span>Avg I<sub>vdd</sub></span><span>{fmth(m.get("i_avg_v2"), 1, "mA", 3)}</span></div>
            <div class="mrow"><span>Max I<sub>vdd</sub></span><span>{fmth(m.get("i_max_v2"), 1, "mA", 3)}</span></div>
            <div class="mrow"><span>Avg P<sub>diss</sub></span><span>{
                fmth(m.get("i_avg_v2") * float(vp) if m.get("i_avg_v2") is not None else None, 1, "mW", 3)
            }</span></div>
        </div>
    </div>'''
    html_detail_panels += f'<div id="{tag}" class="panel">{inner}</div>\n'

html = f'''<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>VCO Sweep Report</title>
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
    tr.vin-header td {{ background: #f0f7ff; font-size: 12px; padding: 5px 10px; text-align: left; color: #555; font-style: italic; }}
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
<h1>VCO Sweep Report</h1>
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

html_path = os.path.join(RESULTS_DIR, 'vco_report.html')
with open(html_path, 'w') as f:
    f.write(html)
print(f"Zapisano raport: {html_path}")
