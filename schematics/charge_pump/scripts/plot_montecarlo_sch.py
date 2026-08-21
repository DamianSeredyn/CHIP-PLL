#!/usr/bin/env python3
"""
plot_montecarlo.py
Analiza wynikow Monte Carlo (mismatch) charge pumpa - histogram rozkladu
Iup/Idn i ich rozbieznosci po N niezaleznych iteracjach z rozna losowoscia.

WAZNE: rozbieznosc [%] = (|Iup|-|Idn|)/max(|Iup|,|Idn|)*100 jest MATEMATYCZNIE
niezalezna od wspolnej skali (jesli Iup i Idn skaluja sie razem x2 w danej
iteracji, ich stosunek/rozbieznosc % sie NIE zmienia). Ale surowy scatter
Iup vs Idn wizualnie dominuje wspolny dryf referencji (Iref rozny miedzy
iteracjami) - to prawdziwa informacja (np. czy uklad pracuje przy niskim
prądzie blisko progu, gdzie wrazliwosc na mismatch VTH jest wieksza), ale
utrudnia OKIEM ocenic sam mismatch rozznicowy. Dlatego dodatkowo:
  - normalizujemy Iup/Iref i Idn/Iref (dzielimy przez REFERENCJE TEJ SAMEJ
    iteracji) - to usuwa wspolny dryf z WYKRESU (nie ze statystyki %, ktora
    juz byla niezalezna), pokazujac czysty obraz jak ciasno klastruja sie
    znormalizowane prady wokol jeden drugiego
  - scatter rozbieznosc[%] vs Iref - pokazuje CZY mismatch rozniczkowy
    faktycznie zalezy od punktu pracy (np. wiekszy % przy niskim Iref,
    blisko progu, w slabej inwersji) - to NOWA informacja, nie widoczna
    w samym histogramie %.
"""

import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import glob
import os
import re

SCRIPT_DIR  = os.path.dirname(os.path.abspath(__file__))
PROJECT_DIR = os.path.abspath(os.path.join(SCRIPT_DIR, '../..'))
DATA_DIR    = os.path.join(PROJECT_DIR, 'charge_pump/results_mc/data')
RESULTS_DIR = os.path.join(PROJECT_DIR, 'charge_pump/results_mc')

UP_DN_THRESHOLD = 0.5

data_files = sorted(
    glob.glob(os.path.join(DATA_DIR, 'cp_mc_data_mc_*.txt')),
    key=lambda p: int(re.search(r'mc_(\d+)\.txt', p).group(1))
)
if not data_files:
    print(f"BLAD: brak plikow cp_mc_data_mc_*.txt w {DATA_DIR}")
    raise SystemExit(1)


def read_data(filepath):
    rows = []
    with open(filepath, 'r') as fh:
        for line in fh:
            line = line.strip()
            if not line:
                continue
            try:
                vals = [float(v) for v in line.split()]
                if len(vals) >= 14:
                    rows.append(vals[:14])
            except ValueError:
                pass
    if not rows:
        raise ValueError(f"Brak danych numerycznych: {filepath}")
    d = np.array(rows)
    return (d[:, 0], d[:, 1], d[:, 3], d[:, 5], d[:, 7], d[:, 9], d[:, 11], d[:, 13])


def find_active_segments(active_mask):
    idx = np.where(active_mask)[0]
    if len(idx) < 2:
        return []
    breaks = np.where(np.diff(idx) != 1)[0]
    return [g for g in np.split(idx, breaks + 1) if len(g) >= 2]


def time_avg_active(values, time_vec, active_mask):
    trapz_fn = getattr(np, 'trapezoid', None) or np.trapz
    segments = find_active_segments(active_mask)
    if not segments:
        return float('nan')
    total_integral = 0.0
    total_duration = 0.0
    for g in segments:
        t_g = time_vec[g]
        v_g = values[g]
        total_integral += trapz_fn(v_g, t_g)
        total_duration += (t_g[-1] - t_g[0])
    if total_duration == 0:
        return float('nan')
    return total_integral / total_duration


def time_avg_window(values, time_vec, mask):
    """Srednia wazona czasem dla JEDNEGO ciaglego okna - do pomiaru Iref
    (sygnal ciagly, nie impulsowy jak Iup/Idn)."""
    t_win = time_vec[mask]
    v_win = values[mask]
    if len(t_win) < 2:
        return float(np.mean(v_win)) if len(v_win) else float('nan')
    trapz_fn = getattr(np, 'trapezoid', None) or np.trapz
    return float(trapz_fn(v_win, t_win) / (t_win[-1] - t_win[0]))


iup_list = []
idn_list = []
iref_list = []
pct_list = []          # rozbieznosc surowa (juz niezalezna od skali - patrz docstring)
ratio_up_list = []     # Iup / Iref tej samej iteracji
ratio_dn_list = []     # Idn / Iref tej samej iteracji
run_ids = []

for fpath in data_files:
    m = re.search(r'mc_(\d+)\.txt', fpath)
    run_id = int(m.group(1))
    try:
        time, vout, vbias, i_iref, i_iup, i_idn, v_up, v_dn = read_data(fpath)
    except Exception as exc:
        print(f"  pominieto run {run_id}: {exc}")
        continue

    time_us = time * 1e6
    i_iref_uA = i_iref * 1e6
    i_iup_uA = i_iup * 1e6
    i_idn_uA = i_idn * 1e6

    up_active = v_up > UP_DN_THRESHOLD
    dn_active = v_dn > UP_DN_THRESHOLD

    iup_avg = time_avg_active(i_iup_uA, time_us, up_active)
    idn_avg = time_avg_active(i_idn_uA, time_us, dn_active)

    # Iref - sygnal ciagly (nie impulsowy), usredniony z ostatnich 20% symulacji
    # (stan ustalony), niezaleznie od dokladnej dlugosci tran
    steady_mask = time_us >= (0.8 * time_us.max())
    iref_avg = time_avg_window(i_iref_uA, time_us, steady_mask)

    if np.isnan(iup_avg) or np.isnan(idn_avg) or np.isnan(iref_avg):
        print(f"  UWAGA: run {run_id} ma NaN w iup/idn/iref, pomijam")
        continue
    if iref_avg == 0:
        print(f"  UWAGA: run {run_id} ma Iref=0, pomijam (dzielenie przez zero)")
        continue

    abs_iup, abs_idn = abs(iup_avg), abs(idn_avg)
    denom = max(abs_iup, abs_idn)
    pct = (abs_iup - abs_idn) / denom * 100 if denom != 0 else 0.0

    iup_list.append(iup_avg)
    idn_list.append(idn_avg)
    iref_list.append(iref_avg)
    pct_list.append(pct)
    ratio_up_list.append(iup_avg / iref_avg)
    ratio_dn_list.append(idn_avg / iref_avg)
    run_ids.append(run_id)

if not pct_list:
    print("BLAD: brak poprawnych wynikow do analizy")
    raise SystemExit(1)

iup_arr = np.array(iup_list)
idn_arr = np.array(idn_list)
iref_arr = np.array(iref_list)
pct_arr = np.array(pct_list)
ratio_up_arr = np.array(ratio_up_list)
ratio_dn_arr = np.array(ratio_dn_list)
n = len(pct_arr)

# korelacja rozbieznosci % z poziomem Iref - czy mismatch zalezy od punktu pracy
corr_pct_iref = float(np.corrcoef(pct_arr, iref_arr)[0, 1]) if n > 1 else float('nan')

stats = {
    'n':          n,
    'iup_mean':   float(np.mean(iup_arr)),
    'iup_std':    float(np.std(iup_arr)),
    'idn_mean':   float(np.mean(idn_arr)),
    'idn_std':    float(np.std(idn_arr)),
    'iref_mean':  float(np.mean(iref_arr)),
    'iref_std':   float(np.std(iref_arr)),
    'pct_mean':   float(np.mean(pct_arr)),
    'pct_std':    float(np.std(pct_arr)),
    'pct_min':    float(np.min(pct_arr)),
    'pct_max':    float(np.max(pct_arr)),
    'pct_3sigma': float(np.mean(pct_arr) + 3 * np.std(pct_arr)),
    'corr_pct_iref': corr_pct_iref,
}

print(f"N = {stats['n']}")
print(f"Iup:  mean={stats['iup_mean']:.4f} uA, std={stats['iup_std']:.4f} uA")
print(f"Idn:  mean={stats['idn_mean']:.4f} uA, std={stats['idn_std']:.4f} uA")
print(f"Iref: mean={stats['iref_mean']:.4f} uA, std={stats['iref_std']:.4f} uA")
print(f"Rozbieznosc [%]: mean={stats['pct_mean']:.2f}, std={stats['pct_std']:.2f}, "
      f"min={stats['pct_min']:.2f}, max={stats['pct_max']:.2f}, "
      f"3-sigma={stats['pct_3sigma']:.2f}")
print(f"Korelacja rozbieznosc[%] vs Iref: {stats['corr_pct_iref']:.3f} "
      f"(blisko 0 = mismatch NIE zalezy od punktu pracy, "
      f"|>0.3| = zauwazalna zaleznosc)")

# ---------------------------------------------------------------------------
# Histogramy: Iup, Idn, rozbieznosc %
# ---------------------------------------------------------------------------
fig, axes = plt.subplots(1, 3, figsize=(15, 4.5))

axes[0].hist(iup_arr, bins=30, color='#ff7f0e', alpha=0.8, edgecolor='white')
axes[0].axvline(stats['iup_mean'], color='k', linestyle='--', linewidth=1)
axes[0].set_title(f"Iup [uA]  (mean={stats['iup_mean']:.3f}, std={stats['iup_std']:.3f})")
axes[0].set_xlabel('Iup [uA]')
axes[0].set_ylabel('liczba iteracji')
axes[0].grid(True, alpha=0.3)

axes[1].hist(idn_arr, bins=30, color='#9467bd', alpha=0.8, edgecolor='white')
axes[1].axvline(stats['idn_mean'], color='k', linestyle='--', linewidth=1)
axes[1].set_title(f"Idn [uA]  (mean={stats['idn_mean']:.3f}, std={stats['idn_std']:.3f})")
axes[1].set_xlabel('Idn [uA]')
axes[1].grid(True, alpha=0.3)

axes[2].hist(pct_arr, bins=30, color='#2ca02c', alpha=0.8, edgecolor='white')
axes[2].axvline(stats['pct_mean'], color='k', linestyle='--', linewidth=1, label='mean')
axes[2].axvline(stats['pct_mean'] + 3 * stats['pct_std'], color='r', linestyle=':', linewidth=1, label='+3sigma')
axes[2].axvline(stats['pct_mean'] - 3 * stats['pct_std'], color='b', linestyle=':', linewidth=1, label='-3sigma')
axes[2].set_title(f"Rozbieznosc Iup vs Idn [%]  (mean={stats['pct_mean']:.2f}, std={stats['pct_std']:.2f})")
axes[2].set_xlabel('(|Iup|-|Idn|)/max * 100 [%]')
axes[2].legend(fontsize=8)
axes[2].grid(True, alpha=0.3)

plt.tight_layout()
hist_path = os.path.join(RESULTS_DIR, 'mc_histogram.png')
plt.savefig(hist_path, dpi=140, bbox_inches='tight')
plt.close()

# ---------------------------------------------------------------------------
# Scatter 1: surowe Iup vs Idn (dominuje wspolny dryf Iref miedzy iteracjami)
# Scatter 2: ZNORMALIZOWANE Iup/Iref vs Idn/Iref (usuwa wspolny dryf z obrazu -
#            to jest "czysty" obraz mismatchu roznicowego)
# ---------------------------------------------------------------------------
fig2, axes2 = plt.subplots(1, 2, figsize=(12, 6))

axes2[0].scatter(iup_arr, idn_arr, s=12, alpha=0.6, color='#1f77b4')
lims = [min(iup_arr.min(), idn_arr.min()), max(iup_arr.max(), idn_arr.max())]
axes2[0].plot(lims, lims, 'k--', linewidth=1, label='Iup = Idn (idealne)')
axes2[0].set_xlabel('Iup [uA]')
axes2[0].set_ylabel('Idn [uA]')
axes2[0].set_title('SUROWE Iup vs Idn\n(zawiera wspolny dryf referencji)')
axes2[0].legend(fontsize=9)
axes2[0].grid(True, alpha=0.3)

axes2[1].scatter(ratio_up_arr, ratio_dn_arr, s=12, alpha=0.6, color='#2ca02c')
lims2 = [min(ratio_up_arr.min(), ratio_dn_arr.min()), max(ratio_up_arr.max(), ratio_dn_arr.max())]
axes2[1].plot(lims2, lims2, 'k--', linewidth=1, label='Iup/Iref = Idn/Iref (idealne)')
axes2[1].set_xlabel('Iup / Iref (tej samej iteracji)')
axes2[1].set_ylabel('Idn / Iref (tej samej iteracji)')
axes2[1].set_title('ZNORMALIZOWANE wzgledem Iref\n(czysty mismatch roznicowy)')
axes2[1].legend(fontsize=9)
axes2[1].grid(True, alpha=0.3)

plt.tight_layout()
scatter_path = os.path.join(RESULTS_DIR, 'mc_scatter.png')
plt.savefig(scatter_path, dpi=140, bbox_inches='tight')
plt.close()

# ---------------------------------------------------------------------------
# Scatter 3: rozbieznosc [%] vs Iref - czy mismatch zalezy od punktu pracy
# ---------------------------------------------------------------------------
fig3, ax3 = plt.subplots(figsize=(7, 6))
ax3.scatter(iref_arr, pct_arr, s=14, alpha=0.6, color='#d62728')
ax3.axhline(0, color='k', linewidth=0.8)
ax3.set_xlabel('Iref [uA] (tej samej iteracji)')
ax3.set_ylabel('Rozbieznosc Iup vs Idn [%]')
ax3.set_title(f'Rozbieznosc vs punkt pracy (korelacja r={stats["corr_pct_iref"]:.3f})')
ax3.grid(True, alpha=0.3)
plt.tight_layout()
vs_iref_path = os.path.join(RESULTS_DIR, 'mc_pct_vs_iref.png')
plt.savefig(vs_iref_path, dpi=140, bbox_inches='tight')
plt.close()

# ---------------------------------------------------------------------------
# Raport HTML
# ---------------------------------------------------------------------------
html_out = os.path.join(RESULTS_DIR, 'mc_report.html')

html = f'''<!DOCTYPE html>
<html lang="pl">
<head>
<meta charset="utf-8">
<title>Charge pump - Monte Carlo (mismatch)</title>
<style>
body {{ font-family: Arial, sans-serif; font-size: 14px; margin: 20px; color: #111; }}
h1 {{ font-size: 18px; }}
h2 {{ font-size: 15px; margin-top: 28px; }}
table {{ border-collapse: collapse; margin-bottom: 24px; }}
td, th {{ border: 1px solid #ccc; padding: 4px 10px; text-align: right; }}
th {{ background: #eee; }}
td:first-child, th:first-child {{ text-align: left; }}
img {{ max-width: 100%; border: 1px solid #ccc; margin-bottom: 20px; }}
.note {{ background: #fff8e1; padding: 10px 14px; border-left: 3px solid #f0ad4e; margin-bottom: 20px; }}
</style>
</head>
<body>
<h1>Charge pump - Monte Carlo (mismatch, corner mos_tt_mismatch)</h1>
<p>N = {stats['n']} iteracji, kazda z innym rndseed. Iup/Idn liczone srednia
wazona czasem TYLKO gdy odpowiednie zrodlo sterujace (Vup2/Vdn2) jest aktywne.
Iref usredniony w ostatnich 20% symulacji (stan ustalony).</p>

<table>
<tr><th>Wielkosc</th><th>srednia</th><th>odchylenie std</th><th>min</th><th>max</th></tr>
<tr><td>Iup [uA]</td><td>{stats['iup_mean']:.4f}</td><td>{stats['iup_std']:.4f}</td>
    <td>{iup_arr.min():.4f}</td><td>{iup_arr.max():.4f}</td></tr>
<tr><td>Idn [uA]</td><td>{stats['idn_mean']:.4f}</td><td>{stats['idn_std']:.4f}</td>
    <td>{idn_arr.min():.4f}</td><td>{idn_arr.max():.4f}</td></tr>
<tr><td>Iref [uA]</td><td>{stats['iref_mean']:.4f}</td><td>{stats['iref_std']:.4f}</td>
    <td>{iref_arr.min():.4f}</td><td>{iref_arr.max():.4f}</td></tr>
<tr><td>Rozbieznosc [%]</td><td>{stats['pct_mean']:.2f}</td><td>{stats['pct_std']:.2f}</td>
    <td>{stats['pct_min']:.2f}</td><td>{stats['pct_max']:.2f}</td></tr>
</table>
<p><b>Rozbieznosc 3-sigma (worst-case estymacja):</b> {stats['pct_3sigma']:.2f}%</p>
<p><b>Korelacja rozbieznosci [%] z Iref:</b> r = {stats['corr_pct_iref']:.3f}
({'BRAK zaleznosci od punktu pracy' if abs(stats['corr_pct_iref']) < 0.3 else 'WYRAZNA zaleznosc od punktu pracy - patrz wykres nizej'})</p>

<div class="note">
Rozbieznosc [%] = (|Iup|-|Idn|)/max(|Iup|,|Idn|)*100 jest matematycznie
niezalezna od wspolnej skali 
</div>

<h2>Histogramy: Iup, Idn, rozbieznosc %</h2>
<img src="mc_histogram.png">

<h2>Surowy vs znormalizowany scatter Iup/Idn</h2>
<img src="mc_scatter.png">

<h2>Czy mismatch zalezy od punktu pracy (Iref)?</h2>
<img src="mc_pct_vs_iref.png">

</body>
</html>
'''

with open(html_out, 'w', encoding='utf-8') as fh:
    fh.write(html)

print(f"\nZapisano raport: {html_out}")
