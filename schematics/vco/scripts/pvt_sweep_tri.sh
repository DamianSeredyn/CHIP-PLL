#!/bin/bash
SPICE="/foss/designs/CHIP-PLL/simulations/vco_triangular_in_tb.spice"
SPICE_CLEAN="/foss/designs/CHIP-PLL/simulations/pvt_tri_tmp/vco_triangular_in_tb.spice"
MODELS="/foss/pdks/ihp-sg13g2/libs.tech/ngspice/models/cornerMOSlv.lib"
OUTDIR="/foss/designs/CHIP-PLL/simulations/pvt_tri_results"
TMPDIR="/foss/designs/CHIP-PLL/simulations/pvt_tri_tmp"
PLOTSCRIPT="/foss/designs/CHIP-PLL/simulations/plot_pvt_tri.py"
CSVFILE="${OUTDIR}/pvt_tri_summary.csv"

mkdir -p "$OUTDIR"
mkdir -p "$TMPDIR"

sed '/^[[:space:]]*\.control/,/^[[:space:]]*\.endc/d' "$SPICE" | \
sed '/^[[:space:]]*\.param[[:space:]]\+vdd[[:space:]]*=/d' | \
sed '/^[[:space:]]*\.param[[:space:]]\+temp[[:space:]]*=/d' | \
sed '/^[[:space:]]*\.[Ll][Ii][Bb][[:space:]]/d' > "$SPICE_CLEAN"

echo "tag,corner,vdd_v,temp_c,duty_cycle_out_pb_pct,freq_out_pb_ghz,duty_cycle_out_pct,freq_out_ghz,idd_avg_ma,idd_max_ma,rise_out_pb_ps,fall_out_pb_ps" > "$CSVFILE"

PASS=0
FAIL=0

for corner in tt ss ff fs sf; do
  for vdd in 1.08 1.2 1.32; do
    for temp in -40 27 125; do
      TAG="${corner}_${vdd}V_${temp}C"
      LOG="${OUTDIR}/${TAG}.log"
      DAT="${OUTDIR}/${TAG}.dat"
      TMP="${TMPDIR}/${TAG}.spice"

      echo -n "Running $TAG ... "

      cat > "$TMP" << NGEOF
.lib ${MODELS} mos_${corner}
.param vdd=${vdd}
.temp ${temp}
.include ${SPICE_CLEAN}
.control
  tran 20p 20n
  wrdata ${DAT} v(out_pb) v(out) i(V2)
  exit
.endc
NGEOF

      ngspice -b -o "$LOG" "$TMP"

      if grep -q "Error\|ERROR" "$LOG"; then
        echo "FAIL  (see $LOG)"
        FAIL=$((FAIL + 1))
        echo "${TAG},${corner},${vdd},${temp},NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN" >> "$CSVFILE"
      else
        echo "ok"
        PASS=$((PASS + 1))
        echo "${TAG},${corner},${vdd},${temp},pending,pending,pending,pending,pending,pending,pending,pending" >> "$CSVFILE"
      fi

    done
  done
done

echo ""
echo "=== Done: $PASS passed, $FAIL failed ==="

cat > "$PLOTSCRIPT" << 'PYEOF'
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
from matplotlib.widgets import CheckButtons, Button
import glob, os, csv

RESULTS_DIR = "/foss/designs/CHIP-PLL/simulations/pvt_tri_results"
CSV_PATH    = os.path.join(RESULTS_DIR, "pvt_tri_summary.csv")

def analyze_first_stable_cycle(time, voltage, last_fraction=0.3):
    """
    Finds the first full rising-edge cycle in the last `last_fraction` of the
    simulation and returns:
      duty_cycle_pct, freq_ghz,
      rise_time_ps  (10 % → 90 % on the first rising edge),
      fall_time_ps  (90 % → 10 % on the first falling edge)
    All four are measured on exactly the same cycle.
    Returns (None, None, None, None) if the signal looks flat or has too few edges.
    """
    vmin, vmax = voltage.min(), voltage.max()
    if (vmax - vmin) < 0.05:
        return None, None, None, None

    v10 = vmin + 0.10 * (vmax - vmin)
    v50 = vmin + 0.50 * (vmax - vmin)
    v90 = vmin + 0.90 * (vmax - vmin)

    t_start = time[-1] * (1.0 - last_fraction)
    mask    = time >= t_start
    t_win   = time[mask]
    v_win   = voltage[mask]

    def interp_crossing(t_arr, v_arr, idx, level):
        """Linear interpolation of exact crossing time at `level`."""
        t0, t1 = t_arr[idx], t_arr[idx + 1]
        v0, v1 = v_arr[idx], v_arr[idx + 1]
        return t0 + (level - v0) * (t1 - t0) / (v1 - v0)

    def find_crossings(t_arr, v_arr, level, direction):
        """
        Returns array of crossing times at `level`.
        direction: +1 → rising, -1 → falling
        """
        above = (v_arr >= level).astype(int)
        edges = np.diff(above)
        if direction == 1:
            idxs = np.where(edges == 1)[0]
        else:
            idxs = np.where(edges == -1)[0]
        return np.array([interp_crossing(t_arr, v_arr, i, level) for i in idxs])

    # 50 % crossings for period / duty-cycle
    rising_50  = find_crossings(t_win, v_win, v50, +1)
    falling_50 = find_crossings(t_win, v_win, v50, -1)

    if len(rising_50) < 2 or len(falling_50) < 1:
        return None, None, None, None

    # first rising edge at 50 %
    t_rise0_50 = rising_50[0]
    # first falling edge after that
    f_after = falling_50[falling_50 > t_rise0_50]
    if len(f_after) == 0:
        return None, None, None, None
    t_fall0_50 = f_after[0]
    # second rising edge for period
    r_after = rising_50[rising_50 > t_fall0_50]
    if len(r_after) == 0:
        return None, None, None, None
    t_rise1_50 = r_after[0]

    period    = t_rise1_50 - t_rise0_50
    high_time = t_fall0_50 - t_rise0_50
    if period <= 0:
        return None, None, None, None

    duty_cycle_pct = 100.0 * high_time / period
    freq_ghz       = 1.0 / period / 1e9

    # ── rise time: 10 % → 90 % on the SAME rising edge ──────────────────────
    # Look for the 10 % crossing just before t_rise0_50
    rising_10 = find_crossings(t_win, v_win, v10, +1)
    rising_90 = find_crossings(t_win, v_win, v90, +1)

    # last 10 % crossing before t_rise0_50 (= start of our chosen edge)
    r10_before = rising_10[rising_10 <= t_rise0_50]
    r90_after  = rising_90[rising_90 >= t_rise0_50]

    if len(r10_before) > 0 and len(r90_after) > 0:
        t_r10 = r10_before[-1]
        t_r90 = r90_after[0]
        # sanity: must be within half a period
        rise_time_ps = (t_r90 - t_r10) * 1e12 if (t_r90 - t_r10) < period / 2 else None
    else:
        rise_time_ps = None

    # ── fall time: 90 % → 10 % on the SAME falling edge ─────────────────────
    falling_10 = find_crossings(t_win, v_win, v10, -1)
    falling_90 = find_crossings(t_win, v_win, v90, -1)

    # last 90 % falling crossing before t_fall0_50
    f90_before = falling_90[falling_90 <= t_fall0_50]
    f10_after  = falling_10[falling_10 >= t_fall0_50]

    if len(f90_before) > 0 and len(f10_after) > 0:
        t_f90 = f90_before[-1]
        t_f10 = f10_after[0]
        fall_time_ps = (t_f10 - t_f90) * 1e12 if (t_f10 - t_f90) < period / 2 else None
    else:
        fall_time_ps = None

    return duty_cycle_pct, freq_ghz, rise_time_ps, fall_time_ps


# ── load waveforms & compute metrics ────────────────────────────────────────
files  = sorted(glob.glob(os.path.join(RESULTS_DIR, "*.dat")))
colors = {"tt": "black", "ff": "red", "ss": "blue", "fs": "green", "sf": "orange"}

duty_map_pb  = {}
freq_map_pb  = {}
duty_map_out = {}
freq_map_out = {}
idd_avg_map  = {}
idd_max_map  = {}
rise_map_pb  = {}
fall_map_pb  = {}

lines_pb  = {}
lines_out = {}
labels    = []

# ── figure layout ─────────────────────────────────────────────────────────────
# Extra one column for rise/fall charts (out_pb only)
fig = plt.figure(figsize=(34, 10))
gs  = gridspec.GridSpec(
    2, 7,
    width_ratios=[0.22, 1.3, 0.45, 0.45, 0.45, 0.45, 0.45],
    height_ratios=[1, 1],
    wspace=0.42,
    hspace=0.45,
)

ax_check    = fig.add_subplot(gs[:, 0])
ax_wave_pb  = fig.add_subplot(gs[0, 1])
ax_wave_out = fig.add_subplot(gs[1, 1])
ax_dc_pb    = fig.add_subplot(gs[0, 2])
ax_dc_out   = fig.add_subplot(gs[1, 2])
ax_fr_pb    = fig.add_subplot(gs[0, 3])
ax_fr_out   = fig.add_subplot(gs[1, 3])
ax_idd_avg  = fig.add_subplot(gs[0, 4])
ax_idd_max  = fig.add_subplot(gs[1, 4])
ax_rise_pb  = fig.add_subplot(gs[0, 5])
ax_fall_pb  = fig.add_subplot(gs[1, 5])

for f in files:
    label  = os.path.basename(f).replace(".dat", "")
    corner = label.split("_")[0]
    color  = colors.get(corner, "gray")
    try:
        data = np.loadtxt(f, skiprows=1)
        if data.ndim < 2 or data.shape[1] < 6:
            print(f"skip {label} — expected 6 columns, got {data.shape}")
            continue

        t_pb,  v_pb  = data[:, 0], data[:, 1]
        t_out, v_out = data[:, 2], data[:, 3]
        t_i2,  i_v2  = data[:, 4], data[:, 5]

        line_pb, = ax_wave_pb.plot(
            t_pb * 1e9, v_pb,
            label=label, color=color, linewidth=0.8, alpha=0.8, visible=True,
        )
        line_out, = ax_wave_out.plot(
            t_out * 1e9, v_out,
            label=label, color=color, linewidth=0.8, alpha=0.8, visible=True,
        )

        lines_pb[label]  = line_pb
        lines_out[label] = line_out
        labels.append(label)

        dc_pb,  fr_pb,  rt_pb,  ft_pb  = analyze_first_stable_cycle(t_pb,  v_pb)
        dc_out, fr_out, _, _           = analyze_first_stable_cycle(t_out, v_out)

        duty_map_pb[label]  = dc_pb
        freq_map_pb[label]  = fr_pb
        duty_map_out[label] = dc_out
        freq_map_out[label] = fr_out
        rise_map_pb[label]  = rt_pb
        fall_map_pb[label]  = ft_pb

        idd_avg_map[label] = -np.mean(i_v2) * 1e3
        idd_max_map[label] = -np.min(i_v2) * 1e3

    except Exception as e:
        print(f"skip {label}: {e}")

# ── update CSV ───────────────────────────────────────────────────────────────
rows = []
with open(CSV_PATH, newline="") as fh:
    reader = csv.DictReader(fh)
    for row in reader:
        tag = row["tag"]
        if tag in labels:
            def fmt(v): return f"{v:.4f}" if v is not None else "NaN"
            row["duty_cycle_out_pb_pct"] = fmt(duty_map_pb.get(tag))
            row["freq_out_pb_ghz"]       = fmt(freq_map_pb.get(tag))
            row["duty_cycle_out_pct"]    = fmt(duty_map_out.get(tag))
            row["freq_out_ghz"]          = fmt(freq_map_out.get(tag))
            row["idd_avg_ma"]            = fmt(idd_avg_map.get(tag))
            row["idd_max_ma"]            = fmt(idd_max_map.get(tag))
            row["rise_out_pb_ps"]        = fmt(rise_map_pb.get(tag))
            row["fall_out_pb_ps"]        = fmt(fall_map_pb.get(tag))
        rows.append(row)

with open(CSV_PATH, "w", newline="") as fh:
    writer = csv.DictWriter(
        fh,
        fieldnames=["tag","corner","vdd_v","temp_c",
                    "duty_cycle_out_pb_pct","freq_out_pb_ghz",
                    "duty_cycle_out_pct","freq_out_ghz",
                    "idd_avg_ma","idd_max_ma",
                    "rise_out_pb_ps","fall_out_pb_ps"],
    )
    writer.writeheader()
    writer.writerows(rows)

print(f"Summary written to {CSV_PATH}")

# ── generic bar chart helper ─────────────────────────────────────────────────
def draw_bar_chart(ax, metric_map, title, xlabel, ref_line=None):
    valid   = [l for l in labels if metric_map.get(l) is not None]
    values  = [metric_map[l] for l in valid]
    bcolors = [colors.get(l.split("_")[0], "gray") for l in valid]
    bars = ax.barh(valid, values, color=bcolors, alpha=0.75, height=0.6)
    if ref_line is not None:
        ax.axvline(ref_line, color="black", linewidth=0.8, linestyle="--")
    ax.set_xlabel(xlabel)
    ax.set_title(title)
    for bar, val in zip(bars, values):
        ax.text(val + ax.get_xlim()[1] * 0.01,
                bar.get_y() + bar.get_height() / 2,
                f"{val:.2f}", va="center", fontsize=5.5)
    ax.tick_params(axis="y", labelsize=5.5)
    ax.grid(axis="x", linewidth=0.3, alpha=0.5)

draw_bar_chart(ax_dc_pb,   duty_map_pb,  "Duty Cycle — v(out_pb)\n(first stable, last 30%)",
               "Duty Cycle (%)", ref_line=50)
draw_bar_chart(ax_dc_out,  duty_map_out, "Duty Cycle — v(out)\n(first stable, last 30%)",
               "Duty Cycle (%)", ref_line=50)
draw_bar_chart(ax_fr_pb,   freq_map_pb,  "Frequency — v(out_pb)\n(first stable, last 30%)",
               "Frequency (GHz)")
draw_bar_chart(ax_fr_out,  freq_map_out, "Frequency — v(out)\n(first stable, last 30%)",
               "Frequency (GHz)")
draw_bar_chart(ax_idd_avg, idd_avg_map,  "Avg Idd — I(V2)\n(full sim, sign-corrected)",
               "Current (mA)")
draw_bar_chart(ax_idd_max, idd_max_map,  "Peak Idd — I(V2)\n(full sim, sign-corrected)",
               "Current (mA)")
draw_bar_chart(ax_rise_pb,  rise_map_pb,  "Rise Time — v(out_pb)\n(10%→90%, same cycle)",
               "Rise Time (ps)")
draw_bar_chart(ax_fall_pb,  fall_map_pb,  "Fall Time — v(out_pb)\n(90%→10%, same cycle)",
               "Fall Time (ps)")

for ax in (ax_dc_pb, ax_dc_out):
    ax.set_xlim(0, 100)

# ── waveform axes ─────────────────────────────────────────────────────────────
for ax, title, ylabel in [
    (ax_wave_pb,  "VCO PVT — v(out_pb)", "v(out_pb) [V]"),
    (ax_wave_out, "VCO PVT — v(out)",    "v(out) [V]"),
]:
    ax.set_xlabel("Time (ns)")
    ax.set_ylabel(ylabel)
    ax.set_title(title)
    ax.grid(True, linewidth=0.3, alpha=0.5)

# ── checkbuttons + Select All / Deselect All buttons ─────────────────────────
plt.sca(ax_check)
ax_check.set_title("Toggle traces", fontsize=7, pad=2)

check = CheckButtons(ax_check, labels, [True] * len(labels))
for lab, txt in zip(labels, check.labels):
    txt.set_color(colors.get(lab.split("_")[0], "gray"))
    txt.set_fontsize(5.5)

def toggle(label):
    for d in (lines_pb, lines_out):
        if label in d:
            d[label].set_visible(not d[label].get_visible())
    fig.canvas.draw_idle()

check.on_clicked(toggle)

# ── buttons ──────────────────────────────────────────────────────────────────
check_pos = ax_check.get_position()

btn_ax_select = fig.add_axes([
    check_pos.x0,
    check_pos.y0 - 0.045,
    check_pos.width,
    0.035,
])

btn_ax_deselect = fig.add_axes([
    check_pos.x0,
    check_pos.y0 - 0.085,
    check_pos.width,
    0.035,
])

btn_select_all   = Button(btn_ax_select,   "Select All",   color="0.85", hovercolor="0.75")
btn_deselect_all = Button(btn_ax_deselect, "Deselect All", color="0.85", hovercolor="0.75")


def set_all(state):
    for d in (lines_pb, lines_out):
        for line in d.values():
            line.set_visible(state)
    check.eventson = False
    for i, status in enumerate(check.get_status()):
        if status != state:
            check.set_active(i)
    check.eventson = True
    fig.canvas.draw_idle()


def on_select_all(event):
    set_all(True)


def on_deselect_all(event):
    set_all(False)


btn_select_all.on_clicked(on_select_all)
btn_deselect_all.on_clicked(on_deselect_all)

# ── summary table in separate window ─────────────────────────────────────────
def build_summary_table():
    if not labels:
        return

    col_keys = [
        "dc_out_pb", "dc_out",
        "freq_out_pb", "freq_out",
        "idd_avg", "idd_max",
        "rise_out_pb", "fall_out_pb",
    ]
    col_labels = [
        "DC out_pb\n(%)", "DC out\n(%)",
        "Freq out_pb\n(GHz)", "Freq out\n(GHz)",
        "Idd avg\n(mA)", "Idd peak\n(mA)",
        "Rise out_pb\n(ps)", "Fall out_pb\n(ps)",
    ]

    maps = [duty_map_pb, duty_map_out,
            freq_map_pb, freq_map_out,
            idd_avg_map, idd_max_map,
            rise_map_pb, fall_map_pb]

    def fv(v):
        return f"{v:.3f}" if v is not None else "—"

    cell_text  = []
    row_colors = []
    corner_color_map = {
        "tt": "#d0d0d0",
        "ff": "#ffcccc",
        "ss": "#ccd6ff",
        "fs": "#ccffcc",
        "sf": "#ffe8cc",
    }
    for lbl in labels:
        row = [fv(m.get(lbl)) for m in maps]
        cell_text.append(row)
        c = corner_color_map.get(lbl.split("_")[0], "#ffffff")
        row_colors.append([c] * len(col_keys))

    def col_stats(m):
        vals = [m[l] for l in labels if m.get(l) is not None]
        if not vals:
            return "—", "—", None, None
        return fv(min(vals)), fv(max(vals)), min(vals), max(vals)

    min_row, max_row = [], []
    min_vals, max_vals = [], []
    for m in maps:
        lo_str, hi_str, lo_val, hi_val = col_stats(m)
        min_row.append(lo_str)
        max_row.append(hi_str)
        min_vals.append(lo_val)
        max_vals.append(hi_val)

    COL_MIN_BG  = "#b7f0b7"
    COL_MAX_BG  = "#f0b7b7"
    COL_MIN_TXT = "#1a5c1a"
    COL_MAX_TXT = "#5c1a1a"

    for row_idx, lbl in enumerate(labels):
        for col_idx, m in enumerate(maps):
            val = m.get(lbl)
            if val is None:
                continue
            lo = min_vals[col_idx]
            hi = max_vals[col_idx]
            if lo is not None and abs(val - lo) < 1e-9:
                row_colors[row_idx][col_idx] = COL_MIN_BG
            elif hi is not None and abs(val - hi) < 1e-9:
                row_colors[row_idx][col_idx] = COL_MAX_BG

    fig_t = plt.figure(figsize=(14, max(4, len(labels) * 0.35 + 2.5)))
    fig_t.patch.set_facecolor("#f7f7f7")
    ax_t = fig_t.add_subplot(111)
    ax_t.axis("off")
    fig_t.suptitle("PVT Summary Table", fontsize=11, fontweight="bold", y=0.98)

    n_data = len(labels)
    all_rows    = cell_text  + [[""] * len(col_keys), min_row, max_row]
    all_rcolors = row_colors + [
        ["#ffffff"] * len(col_keys),
        [COL_MIN_BG] * len(col_keys),
        [COL_MAX_BG] * len(col_keys),
    ]
    all_rlabels = labels + ["", "MIN", "MAX"]

    tbl = ax_t.table(
        cellText=all_rows,
        rowLabels=all_rlabels,
        colLabels=col_labels,
        cellColours=all_rcolors,
        rowColours=[corner_color_map.get(l.split("_")[0], "#ffffff")
                    if l not in ("", "MIN", "MAX") else "#ffffff"
                    for l in all_rlabels],
        loc="center",
        cellLoc="center",
    )
    tbl.auto_set_font_size(False)
    tbl.set_fontsize(7.5)
    tbl.auto_set_column_width(list(range(len(col_keys))))

    cells = tbl.get_celld()
    for (r, c), cell in cells.items():
        if r == 0:
            cell.set_text_props(fontweight="bold")
        if r == n_data + 2:
            cell.set_text_props(fontweight="bold", color=COL_MIN_TXT)
        if r == n_data + 3:
            cell.set_text_props(fontweight="bold", color=COL_MAX_TXT)
        if 1 <= r <= n_data and c >= 0:
            bg = row_colors[r - 1][c] if c < len(col_keys) else None
            if bg == COL_MIN_BG:
                cell.set_text_props(fontweight="bold", color=COL_MIN_TXT)
            elif bg == COL_MAX_BG:
                cell.set_text_props(fontweight="bold", color=COL_MAX_TXT)
        cell.set_edgecolor("#cccccc")

    plt.tight_layout(rect=[0, 0, 1, 0.96])
    fig_t.show()

build_summary_table()
plt.show()
PYEOF

echo ""
echo "=== Launching plot ==="
python3 "$PLOTSCRIPT"
