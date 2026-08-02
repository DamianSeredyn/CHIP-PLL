#!/bin/bash
# ─────────────────────────────────────────────────────────────────────────────
# run_single.sh  –  Uruchamia jeden przebieg ngspice na oryginalnym netliście
#                   i oblicza wszystkie metryki (duty cycle, freq, Idd, rise/fall).
# ─────────────────────────────────────────────────────────────────────────────

SPICE="/foss/designs/CHIP-PLL/simulations/vco_dcin_tb.spice"
OUTDIR="/foss/designs/CHIP-PLL/simulations/single_result"
PLOTSCRIPT="${OUTDIR}/plot_single.py"
LOGFILE="${OUTDIR}/run.log"
DATFILE="${OUTDIR}/run.dat"
CSVFILE="${OUTDIR}/summary.csv"

mkdir -p "$OUTDIR"

echo "=== Uruchamianie ngspice na oryginalnym netliście ==="
echo "    Netlist : $SPICE"
echo "    Log     : $LOGFILE"
echo "    Dane    : $DATFILE"
echo ""

# ── Uruchomienie ngspice ─────────────────────────────────────────────────────
# Oryginalny netlist musi zawierać blok .control z wrdata, który zapisze dane
# do DATFILE.  Jeśli Twój .control zapisuje do innej ścieżki, zmień DATFILE
# poniżej lub ustaw ją bezpośrednio w netliście.
#
# Jeśli chcesz nadpisać ścieżkę zapisu bez edycji netlistu, odkomentuj sekcję
# WRAPPER i użyj jej zamiast bezpośredniego wywołania ngspice.

# --- bezpośrednie wywołanie (używa .control z netlistu) ----------------------
ngspice -b -o "$LOGFILE" "$SPICE"
STATUS=$?

# --- WRAPPER (odkomentuj, jeśli chcesz kontrolować ścieżkę zapisu danych) ---
# TMPSPICE="${OUTDIR}/wrapper.spice"
# cat > "$TMPSPICE" << NGEOF
# .include ${SPICE}
# .control
#   tran 20p 20n
#   wrdata ${DATFILE} v(out_pb) v(out) i(V2)
#   exit
# .endc
# NGEOF
# ngspice -b -o "$LOGFILE" "$TMPSPICE"
# STATUS=$?
# -----------------------------------------------------------------------------

if [ $STATUS -ne 0 ] || grep -q "Error\|ERROR" "$LOGFILE"; then
    echo "BŁĄD: ngspice zakończył się błędem – sprawdź $LOGFILE"
    exit 1
fi

echo "ngspice OK – uruchamianie analizy i wykresów..."

# ── Skrypt Python: analiza + wykresy ─────────────────────────────────────────
cat > "$PLOTSCRIPT" << 'PYEOF'
import sys, os, csv
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec

OUTDIR  = os.path.dirname(os.path.abspath(__file__))
DATFILE = os.path.join(OUTDIR, "run.dat")
CSVFILE = os.path.join(OUTDIR, "summary.csv")
LOGFILE = os.path.join(OUTDIR, "run.log")

# ─── pomocnicze ──────────────────────────────────────────────────────────────
def interp_crossing(t, v, idx, level):
    t0, t1, v0, v1 = t[idx], t[idx+1], v[idx], v[idx+1]
    return t0 + (level - v0) * (t1 - t0) / (v1 - v0)

def find_crossings(t, v, level, direction):
    above = (v >= level).astype(int)
    edges = np.diff(above)
    idxs  = np.where(edges == (1 if direction > 0 else -1))[0]
    return np.array([interp_crossing(t, v, i, level) for i in idxs])

def analyze_signal(time, voltage, label="signal", last_fraction=0.3):
    """
    Zwraca słownik z metrykami sygnału cyfrowego:
      duty_cycle_pct, freq_ghz,
      rise_time_ps (10%→90%), fall_time_ps (90%→10%),
      period_ps, high_time_ps
    Na podstawie pierwszego pełnego cyklu w ostatnich `last_fraction` symulacji.
    """
    result = dict(
        duty_cycle_pct=None, freq_ghz=None,
        rise_time_ps=None,   fall_time_ps=None,
        period_ps=None,      high_time_ps=None,
    )
    vmin, vmax = voltage.min(), voltage.max()
    swing = vmax - vmin
    if swing < 0.05:
        print(f"  [{label}] Uwaga: amplituda {swing:.3f} V – sygnał płaski?")
        return result

    v10 = vmin + 0.10 * swing
    v50 = vmin + 0.50 * swing
    v90 = vmin + 0.90 * swing

    t_start = time[-1] * (1.0 - last_fraction)
    mask    = time >= t_start
    tw, vw  = time[mask], voltage[mask]

    rising_50  = find_crossings(tw, vw, v50, +1)
    falling_50 = find_crossings(tw, vw, v50, -1)

    if len(rising_50) < 2 or len(falling_50) < 1:
        print(f"  [{label}] Zbyt mało przejść przy 50 % – sprawdź sygnał.")
        return result

    t_r0 = rising_50[0]
    f_after = falling_50[falling_50 > t_r0]
    if len(f_after) == 0:
        return result
    t_f0 = f_after[0]
    r_after = rising_50[rising_50 > t_f0]
    if len(r_after) == 0:
        return result
    t_r1 = r_after[0]

    period    = t_r1 - t_r0
    high_time = t_f0 - t_r0
    if period <= 0:
        return result

    result["period_ps"]      = period * 1e12
    result["high_time_ps"]   = high_time * 1e12
    result["duty_cycle_pct"] = 100.0 * high_time / period
    result["freq_ghz"]       = 1.0 / period / 1e9

    # rise time: 10 % → 90 %
    r10 = find_crossings(tw, vw, v10, +1)
    r90 = find_crossings(tw, vw, v90, +1)
    r10b = r10[r10 <= t_r0]
    r90a = r90[r90 >= t_r0]
    if len(r10b) > 0 and len(r90a) > 0:
        dt = r90a[0] - r10b[-1]
        result["rise_time_ps"] = dt * 1e12 if dt < period / 2 else None

    # fall time: 90 % → 10 %
    f90 = find_crossings(tw, vw, v90, -1)
    f10 = find_crossings(tw, vw, v10, -1)
    f90b = f90[f90 <= t_f0]
    f10a = f10[f10 >= t_f0]
    if len(f90b) > 0 and len(f10a) > 0:
        dt = f10a[0] - f90b[-1]
        result["fall_time_ps"] = dt * 1e12 if dt < period / 2 else None

    return result

# ─── wczytanie danych ─────────────────────────────────────────────────────────
if not os.path.isfile(DATFILE):
    sys.exit(f"Brak pliku danych: {DATFILE}\n"
             f"Sprawdź czy ngspice zapisał wyniki (wrdata w .control).")

try:
    data = np.loadtxt(DATFILE, skiprows=1)
except Exception as e:
    sys.exit(f"Błąd odczytu {DATFILE}: {e}")

if data.ndim < 2 or data.shape[1] < 6:
    sys.exit(f"Oczekiwano 6 kolumn (t_pb v_pb t_out v_out t_i v_i), "
             f"znaleziono {data.shape[1]}.\n"
             f"Dostosuj kolumny w 'wrdata' w bloku .control.")

t_pb,  v_pb  = data[:, 0], data[:, 1]
t_out, v_out = data[:, 2], data[:, 3]
t_i2,  i_v2  = data[:, 4], data[:, 5]

print(f"Wczytano {len(t_pb)} próbek, t_end = {t_pb[-1]*1e9:.2f} ns")

# ─── metryki ─────────────────────────────────────────────────────────────────
m_pb  = analyze_signal(t_pb,  v_pb,  label="out_pb")
m_out = analyze_signal(t_out, v_out, label="out")

idd_avg_ma = -np.mean(i_v2) * 1e3
idd_max_ma = -np.min(i_v2)  * 1e3
idd_min_ma = -np.max(i_v2)  * 1e3

def fmt(v, decimals=4):
    return f"{v:.{decimals}f}" if v is not None else "NaN"

print("")
print("┌─────────────────────────────────────────────┐")
print("│           WYNIKI SYMULACJI VCO               │")
print("├──────────────────┬──────────────┬────────────┤")
print("│ Metryka          │   v(out_pb)  │   v(out)   │")
print("├──────────────────┼──────────────┼────────────┤")
print(f"│ Częstotliwość    │ {fmt(m_pb['freq_ghz'],3):>10} GHz │ {fmt(m_out['freq_ghz'],3):>8} GHz │")
print(f"│ Duty cycle       │ {fmt(m_pb['duty_cycle_pct'],2):>9} %   │ {fmt(m_out['duty_cycle_pct'],2):>7} %   │")
print(f"│ Okres            │ {fmt(m_pb['period_ps'],1):>9} ps  │ {fmt(m_out['period_ps'],1):>7} ps  │")
print(f"│ Czas narastania  │ {fmt(m_pb['rise_time_ps'],1):>9} ps  │        —   │")
print(f"│ Czas opadania    │ {fmt(m_pb['fall_time_ps'],1):>9} ps  │        —   │")
print("├──────────────────┴──────────────┴────────────┤")
print(f"│ Idd śr.    = {idd_avg_ma:8.3f} mA                     │")
print(f"│ Idd szczyt = {idd_max_ma:8.3f} mA                     │")
print(f"│ Idd min    = {idd_min_ma:8.3f} mA                     │")
print("└─────────────────────────────────────────────┘")

# ─── CSV ─────────────────────────────────────────────────────────────────────
with open(CSVFILE, "w", newline="") as fh:
    w = csv.writer(fh)
    w.writerow([
        "signal", "freq_ghz", "duty_cycle_pct", "period_ps", "high_time_ps",
        "rise_time_ps", "fall_time_ps",
    ])
    for sig, m in [("out_pb", m_pb), ("out", m_out)]:
        w.writerow([
            sig,
            fmt(m["freq_ghz"]), fmt(m["duty_cycle_pct"]),
            fmt(m["period_ps"]), fmt(m["high_time_ps"]),
            fmt(m.get("rise_time_ps")), fmt(m.get("fall_time_ps")),
        ])
    w.writerow([
        "supply", "—", "—", "—", "—",
        fmt(idd_avg_ma) + " (avg_mA)",
        fmt(idd_max_ma) + " (peak_mA)",
    ])
print(f"\nCSV zapisany: {CSVFILE}")

# ─── wykresy ─────────────────────────────────────────────────────────────────
fig = plt.figure(figsize=(18, 9))
fig.suptitle("VCO – pojedynczy przebieg", fontsize=12, fontweight="bold")

gs = gridspec.GridSpec(
    2, 4,
    width_ratios=[2, 0.8, 0.8, 0.8],
    hspace=0.45, wspace=0.4,
)

ax_wave_pb  = fig.add_subplot(gs[0, 0])
ax_wave_out = fig.add_subplot(gs[1, 0])
ax_dc       = fig.add_subplot(gs[0, 1])
ax_fr       = fig.add_subplot(gs[0, 2])
ax_rt       = fig.add_subplot(gs[0, 3])
ax_idd      = fig.add_subplot(gs[1, 1])
ax_ft       = fig.add_subplot(gs[1, 2])
ax_idd_t    = fig.add_subplot(gs[1, 3])

# przebiegi czasowe
ax_wave_pb.plot(t_pb * 1e9, v_pb, linewidth=0.8, color="steelblue")
ax_wave_pb.set_title("v(out_pb)")
ax_wave_pb.set_xlabel("Czas (ns)")
ax_wave_pb.set_ylabel("Napięcie (V)")
ax_wave_pb.grid(True, linewidth=0.3, alpha=0.5)

ax_wave_out.plot(t_out * 1e9, v_out, linewidth=0.8, color="darkorange")
ax_wave_out.set_title("v(out)")
ax_wave_out.set_xlabel("Czas (ns)")
ax_wave_out.set_ylabel("Napięcie (V)")
ax_wave_out.grid(True, linewidth=0.3, alpha=0.5)

# prąd zasilania
ax_idd_t.plot(t_i2 * 1e9, -i_v2 * 1e3, linewidth=0.8, color="firebrick")
ax_idd_t.axhline(idd_avg_ma, color="black", linewidth=0.8, linestyle="--",
                 label=f"śr. {idd_avg_ma:.2f} mA")
ax_idd_t.set_title("I(V2) – zasilanie")
ax_idd_t.set_xlabel("Czas (ns)")
ax_idd_t.set_ylabel("Prąd (mA)")
ax_idd_t.legend(fontsize=7)
ax_idd_t.grid(True, linewidth=0.3, alpha=0.5)

# ── pomocnicze: wykres słupkowy z wartością ──
def bar1(ax, value, title, unit, ref=None, color="steelblue"):
    if value is None:
        ax.text(0.5, 0.5, "brak danych", ha="center", va="center",
                transform=ax.transAxes, fontsize=9, color="gray")
        ax.set_title(title)
        ax.set_xticks([])
        return
    bars = ax.barh([""], [value], color=color, alpha=0.8, height=0.4)
    if ref is not None:
        ax.axvline(ref, color="black", linewidth=0.8, linestyle="--")
    ax.set_title(title, fontsize=9)
    ax.set_xlabel(unit, fontsize=8)
    ax.text(value + ax.get_xlim()[1] * 0.02, 0,
            f"{value:.3f}", va="center", fontsize=8)
    ax.tick_params(axis="y", labelsize=7)
    ax.grid(axis="x", linewidth=0.3, alpha=0.5)

# ── pomocnicze: podwójny słupek (out_pb vs out) ──
def bar2(ax, v1, v2, title, unit, ref=None):
    labels  = ["out_pb", "out"]
    values  = [v if v is not None else 0 for v in [v1, v2]]
    colors  = ["steelblue", "darkorange"]
    bars = ax.barh(labels, values, color=colors, alpha=0.8, height=0.5)
    if ref is not None:
        ax.axvline(ref, color="black", linewidth=0.8, linestyle="--")
    ax.set_title(title, fontsize=9)
    ax.set_xlabel(unit, fontsize=8)
    for bar, val in zip(bars, [v1, v2]):
        if val is not None:
            ax.text(val + ax.get_xlim()[1] * 0.02,
                    bar.get_y() + bar.get_height() / 2,
                    f"{val:.3f}", va="center", fontsize=8)
    ax.tick_params(axis="y", labelsize=8)
    ax.grid(axis="x", linewidth=0.3, alpha=0.5)

bar2(ax_dc, m_pb["duty_cycle_pct"], m_out["duty_cycle_pct"],
     "Duty cycle", "%", ref=50)
ax_dc.set_xlim(0, 100)

bar2(ax_fr, m_pb["freq_ghz"], m_out["freq_ghz"],
     "Częstotliwość", "GHz")

bar1(ax_rt, m_pb["rise_time_ps"], "Czas narastania\n(out_pb)", "ps",
     color="steelblue")
bar1(ax_ft, m_pb["fall_time_ps"], "Czas opadania\n(out_pb)", "ps",
     color="steelblue")

bar1(ax_idd, idd_avg_ma, "Idd śr./szczyt", "mA", color="firebrick")
ax_idd.barh(["peak"], [idd_max_ma], color="salmon", alpha=0.7, height=0.4)
ax_idd.set_title("Idd", fontsize=9)

# ─── tabela podsumowania (osobne okno) ────────────────────────────────────────
def build_table():
    fig_t = plt.figure(figsize=(10, 3.5))
    fig_t.patch.set_facecolor("#f7f7f7")
    ax_t = fig_t.add_subplot(111)
    ax_t.axis("off")
    fig_t.suptitle("Tabela wyników – pojedynczy przebieg VCO",
                   fontsize=11, fontweight="bold", y=0.97)

    col_labels = [
        "Sygnał",
        "Częst.\n(GHz)", "Duty\n(%)", "Okres\n(ps)",
        "t_high\n(ps)", "t_rise\n(ps)", "t_fall\n(ps)",
    ]
    rows = []
    for sig, m in [("v(out_pb)", m_pb), ("v(out)", m_out)]:
        rows.append([
            sig,
            fmt(m["freq_ghz"], 4),
            fmt(m["duty_cycle_pct"], 3),
            fmt(m["period_ps"], 2),
            fmt(m["high_time_ps"], 2),
            fmt(m.get("rise_time_ps"), 2),
            fmt(m.get("fall_time_ps"), 2),
        ])
    rows.append([
        "I(V2) supply",
        "—", "—", "—", "—",
        f"avg {idd_avg_ma:.3f} mA",
        f"peak {idd_max_ma:.3f} mA",
    ])

    cell_colors = [
        ["#ccd6ff"] * 7,
        ["#ffe8cc"] * 7,
        ["#d0ffd0"] * 7,
    ]

    tbl = ax_t.table(
        cellText=rows,
        colLabels=col_labels,
        cellColours=cell_colors,
        loc="center",
        cellLoc="center",
    )
    tbl.auto_set_font_size(False)
    tbl.set_fontsize(9)
    tbl.auto_set_column_width(list(range(len(col_labels))))
    for (r, c), cell in tbl.get_celld().items():
        if r == 0:
            cell.set_text_props(fontweight="bold")
        cell.set_edgecolor("#cccccc")
    plt.tight_layout(rect=[0, 0, 1, 0.93])
    fig_t.show()

build_table()
plt.tight_layout(rect=[0, 0, 1, 0.95])
plt.show()
PYEOF

echo ""
echo "=== Uruchamianie skryptu analizy ==="
python3 "$PLOTSCRIPT"
