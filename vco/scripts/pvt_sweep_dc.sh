#!/bin/bash
SPICE="/foss/designs/CHIP-PLL/simulations/vco_tb&buf.spice"
SPICE_CLEAN="/foss/designs/CHIP-PLL/simulations/pvt_tmp/vco_tb_clean.spice"
MODELS="/foss/pdks/ihp-sg13g2/libs.tech/ngspice/models/cornerMOSlv.lib"
OUTDIR="/foss/designs/CHIP-PLL/simulations/pvt_results"
TMPDIR="/foss/designs/CHIP-PLL/simulations/pvt_tmp"
PLOTSCRIPT="/foss/designs/CHIP-PLL/simulations/plot_pvt.py"
CSVFILE="${OUTDIR}/pvt_summary.csv"

mkdir -p "$OUTDIR"
mkdir -p "$TMPDIR"

# strip .control ... .endc from xschem netlist
# also strip any hardcoded .param vdd= so our sweep value takes effect
sed '/^\.control/,/^\.endc/d' "$SPICE" | \
sed '/^\.param[[:space:]]\+vdd[[:space:]]*=/d' > "$SPICE_CLEAN"

# init CSV
echo "tag,corner,vdd_v,temp_c,duty_cycle_out_pb_pct,freq_out_pb_ghz,duty_cycle_out_pct,freq_out_ghz" > "$CSVFILE"

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
  wrdata ${DAT} v(out_pb) v(out)
  exit
.endc
NGEOF

      ngspice -b -o "$LOG" "$TMP"

      if grep -q "Error\|ERROR" "$LOG"; then
        echo "FAIL  (see $LOG)"
        FAIL=$((FAIL + 1))
        echo "${TAG},${corner},${vdd},${temp},NaN,NaN,NaN,NaN" >> "$CSVFILE"
      else
        echo "ok"
        PASS=$((PASS + 1))
        echo "${TAG},${corner},${vdd},${temp},pending,pending,pending,pending" >> "$CSVFILE"
      fi

    done
  done
done

echo ""
echo "=== Done: $PASS passed, $FAIL failed ==="

# --- generate plot + duty cycle + frequency script ---
cat > "$PLOTSCRIPT" << 'PYEOF'
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
from matplotlib.widgets import CheckButtons
import glob, os, csv

RESULTS_DIR = "/foss/designs/CHIP-PLL/simulations/pvt_results"
CSV_PATH    = os.path.join(RESULTS_DIR, "pvt_summary.csv")

# ── combined duty cycle + frequency helper ───────────────────────────────────
def analyze_first_stable_cycle(time, voltage, last_fraction=0.3):
    """
    Finds the first complete cycle in the last `last_fraction` of the
    simulation window using 50% threshold crossings with linear interpolation.

    Returns (duty_cycle_pct, frequency_ghz), or (None, None) if no complete
    cycle is found.
    """
    vmin, vmax = voltage.min(), voltage.max()
    if (vmax - vmin) < 0.05:           # flat / no oscillation
        return None, None
    threshold = (vmin + vmax) / 2.0

    t_start = time[-1] * (1.0 - last_fraction)
    mask    = time >= t_start
    t_win   = time[mask]
    v_win   = voltage[mask]

    above  = (v_win >= threshold).astype(int)
    edges  = np.diff(above)
    rising  = np.where(edges ==  1)[0]
    falling = np.where(edges == -1)[0]

    if len(rising) < 1 or len(falling) < 1:
        return None, None

    r0 = rising[0]
    f_after = falling[falling > r0]
    if len(f_after) == 0:
        return None, None
    f0 = f_after[0]
    r_after = rising[rising > f0]
    if len(r_after) == 0:
        return None, None
    r1 = r_after[0]

    def interp_crossing(idx):
        t0, t1 = t_win[idx], t_win[idx + 1]
        v0, v1 = v_win[idx], v_win[idx + 1]
        return t0 + (threshold - v0) * (t1 - t0) / (v1 - v0)

    t_rise0  = interp_crossing(r0)
    t_fall0  = interp_crossing(f0)
    t_rise1  = interp_crossing(r1)

    period    = t_rise1 - t_rise0
    high_time = t_fall0 - t_rise0
    if period <= 0:
        return None, None

    duty_cycle_pct = 100.0 * high_time / period
    freq_ghz       = 1.0 / period / 1e9   # period is in seconds

    return duty_cycle_pct, freq_ghz


# ── load waveforms & compute metrics ────────────────────────────────────────
files  = sorted(glob.glob(os.path.join(RESULTS_DIR, "*.dat")))
colors = {"tt": "black", "ff": "red", "ss": "blue", "fs": "green", "sf": "orange"}

duty_map_pb  = {}
freq_map_pb  = {}
duty_map_out = {}
freq_map_out = {}

lines_pb  = {}
lines_out = {}
labels    = []

# ── figure layout ─────────────────────────────────────────────────────────────
# Columns: [checkboxes | waveforms (2 rows) | duty cycle bars (2 rows) | freq bars (2 rows)]
fig = plt.figure(figsize=(21, 10))
gs  = gridspec.GridSpec(
    2, 4,
    width_ratios=[0.22, 1.3, 0.45, 0.45],
    height_ratios=[1, 1],
    wspace=0.38,
    hspace=0.45,
)

ax_check    = fig.add_subplot(gs[:, 0])      # checkboxes — span both rows
ax_wave_pb  = fig.add_subplot(gs[0, 1])      # v(out_pb) waveform
ax_wave_out = fig.add_subplot(gs[1, 1])      # v(out)    waveform
ax_dc_pb    = fig.add_subplot(gs[0, 2])      # duty cycle — out_pb
ax_dc_out   = fig.add_subplot(gs[1, 2])      # duty cycle — out
ax_fr_pb    = fig.add_subplot(gs[0, 3])      # frequency  — out_pb
ax_fr_out   = fig.add_subplot(gs[1, 3])      # frequency  — out

for f in files:
    label  = os.path.basename(f).replace(".dat", "")
    corner = label.split("_")[0]
    color  = colors.get(corner, "gray")
    try:
        data = np.loadtxt(f, skiprows=1)
        # ngspice wrdata repeats time column per vector:
        # col 0: time, col 1: v(out_pb), col 2: time, col 3: v(out)
        if data.ndim < 2 or data.shape[1] < 4:
            print(f"skip {label} — expected 4 columns, got {data.shape}")
            continue

        t_pb,  v_pb  = data[:, 0], data[:, 1]
        t_out, v_out = data[:, 2], data[:, 3]

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

        dc_pb,  fr_pb  = analyze_first_stable_cycle(t_pb,  v_pb)
        dc_out, fr_out = analyze_first_stable_cycle(t_out, v_out)

        duty_map_pb[label]  = dc_pb
        freq_map_pb[label]  = fr_pb
        duty_map_out[label] = dc_out
        freq_map_out[label] = fr_out

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
        rows.append(row)

with open(CSV_PATH, "w", newline="") as fh:
    writer = csv.DictWriter(
        fh,
        fieldnames=["tag","corner","vdd_v","temp_c",
                    "duty_cycle_out_pb_pct","freq_out_pb_ghz",
                    "duty_cycle_out_pct","freq_out_ghz"],
    )
    writer.writeheader()
    writer.writerows(rows)

print(f"Summary written to {CSV_PATH}")

# ── generic bar chart helper ─────────────────────────────────────────────────
def draw_bar_chart(ax, metric_map, title, xlabel, ref_line=None):
    valid  = [l for l in labels if metric_map.get(l) is not None]
    values = [metric_map[l] for l in valid]
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

draw_bar_chart(ax_dc_pb,  duty_map_pb,  "Duty Cycle — v(out_pb)\n(first stable, last 30%)",
               "Duty Cycle (%)", ref_line=50)
draw_bar_chart(ax_dc_out, duty_map_out, "Duty Cycle — v(out)\n(first stable, last 30%)",
               "Duty Cycle (%)", ref_line=50)
draw_bar_chart(ax_fr_pb,  freq_map_pb,  "Frequency — v(out_pb)\n(first stable, last 30%)",
               "Frequency (GHz)")
draw_bar_chart(ax_fr_out, freq_map_out, "Frequency — v(out)\n(first stable, last 30%)",
               "Frequency (GHz)")

# fix x-axis limits for bar charts after drawing so text offset is correct
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

# ── checkbuttons ──────────────────────────────────────────────────────────────
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

plt.show()
PYEOF

echo ""
echo "=== Launching plot ==="
python3 "$PLOTSCRIPT"
