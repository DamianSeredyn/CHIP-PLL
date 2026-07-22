#!/usr/bin/env python3
"""
plot_cp_new500n.py
Generuje wykresy PNG oraz raport HTML dla symulacji cornerów PVT
charge pump NEW_500n_tran_tb.

Kolumny w plikach danych (wrdata):
  time  v(vout)  v(x1.biasn)  v(x3.vbias)  i(v.x1.Viup)  i(v.x1.Vidn)

ngspice wrdata zapisuje każdy wektor jako parę (time, value), więc 5 sygnałów = 10 kolumn:
  col0=time  col1=vout
  col2=time  col3=biasn
  col4=time  col5=biasp
  col6=time  col7=i_viup
  col8=time  col9=i_vidn
"""

import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import glob
import os
import re

# ---------------------------------------------------------------------------
# Ścieżki
# ---------------------------------------------------------------------------
SCRIPT_DIR  = os.path.dirname(os.path.abspath(__file__))
PROJECT_DIR = os.path.abspath(os.path.join(SCRIPT_DIR, '../..'))
DATA_DIR    = os.path.join(PROJECT_DIR, 'charge_pump/results_new500n/data')
RESULTS_DIR = os.path.join(PROJECT_DIR, 'charge_pump/results_new500n')

# ---------------------------------------------------------------------------
# Czyszczenie starych wyników
# ---------------------------------------------------------------------------
for f in glob.glob(os.path.join(RESULTS_DIR, 'cp_new500n_*.png')):
    os.remove(f)
html_out = os.path.join(RESULTS_DIR, 'cp_new500n_report.html')
if os.path.exists(html_out):
    os.remove(html_out)

# ---------------------------------------------------------------------------
# Wyszukanie plików danych
# ---------------------------------------------------------------------------
data_files = sorted(glob.glob(os.path.join(DATA_DIR, 'cp_new500n_data_*.txt')))
if not data_files:
    print(f"BŁĄD: Brak plików cp_new500n_data_*.txt w {DATA_DIR}")
    raise SystemExit(1)

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
def parse_tag(filename: str):
    """Wyciąga (corner, temp, vp) z nazwy pliku."""
    basename = os.path.basename(filename)
    m = re.search(r'cp_new500n_data_(.+)_T(.+)_Vp(.+)\.txt', basename)
    if m:
        return m.group(1), m.group(2), m.group(3)
    stem = basename.replace('cp_new500n_data_', '').replace('.txt', '')
    parts = stem.split('_')
    corner = '_'.join(parts[:2])
    temp = parts[2].lstrip('T') if len(parts) > 2 else '?'
    vp   = parts[3].lstrip('Vp') if len(parts) > 3 else '?'
    return corner, temp, vp


def read_data(filepath: str):
    """
    Wczytuje plik tekstowy ngspice (wrdata) i zwraca sześć tablic:
      time, vout, biasn, biasp, i_viup, i_vidn

    Netlista zawiera:
      wrdata cp_test.txt v(vout) v(x1.biasn) v(x3.vbias) i(v.x1.Viup) i(v.x1.Vidn)

    ngspice wrdata zapisuje każdy wektor jako parę (skala_czasu, wartość),
    więc dla 5 sygnałów mamy 10 kolumn:
      col0=time  col1=vout
      col2=time  col3=biasn
      col4=time  col5=biasp
      col6=time  col7=i_viup
      col8=time  col9=i_vidn
    """
    rows = []
    with open(filepath, 'r') as fh:
        for line in fh:
            line = line.strip()
            if not line:
                continue
            try:
                vals = [float(v) for v in line.split()]
                if len(vals) >= 10:
                    rows.append(vals[:10])
            except ValueError:
                pass

    if not rows:
        raise ValueError(f"Brak danych numerycznych w pliku: {filepath}")

    data = np.array(rows)
    time   = data[:, 0]
    vout   = data[:, 1]
    biasn  = data[:, 3]
    biasp  = data[:, 5]
    i_viup = data[:, 7]
    i_vidn = data[:, 9]
    return time, vout, biasn, biasp, i_viup, i_vidn


# Kolory i styl
COLORS = {
    'vout':   '#1f77b4',   # niebieski
    'biasn':  '#d62728',   # czerwony
    'biasp':  '#e67e22',   # pomarańczowy
    'i_viup': '#2ca02c',   # zielony
    'i_vidn': '#9467bd',   # fioletowy
}

CORNER_ORDER = {
    'mos_tt': 0, 'mos_ss': 1, 'mos_ff': 2, 'mos_sf': 3, 'mos_fs': 4
}

# ---------------------------------------------------------------------------
# Pętla główna – wczytanie + wykresy
# ---------------------------------------------------------------------------
summary = []

for fpath in data_files:
    corner, temp, vp = parse_tag(fpath)
    tag = f"{corner}_T{temp}_Vp{vp}"
    print(f"Przetwarzam: {tag}")

    try:
        time, vout, biasn, biasp, i_viup, i_vidn = read_data(fpath)
    except Exception as exc:
        print(f"  OSTRZEŻENIE: nie można wczytać danych – {exc}")
        continue

    # Konwersja jednostek
    time_us   = time   * 1e6
    i_viup_nA = i_viup * 1e9
    i_vidn_nA = i_vidn * 1e9

    # Średnie z ostatniej 1/4 czasu symulacji
    n = len(time_us)
    q = n - n // 4
    avgs = {
        'vout':   float(np.mean(vout[q:])),
        'biasn':  float(np.mean(biasn[q:])),
        'biasp':  float(np.mean(biasp[q:])),
        'i_Viup': float(np.mean(i_viup_nA[q:])),
        'i_Vidn': float(np.mean(i_vidn_nA[q:])),
    }
    summary.append((tag, corner, temp, vp, avgs))

    # ----------------------------------------------------------------
    # Wykres 5-panelowy
    # ----------------------------------------------------------------
    fig, axes = plt.subplots(5, 1, figsize=(13, 14), sharex=True)
    fig.suptitle(
        f'Charge Pump NEW_500n  |  corner: {corner}  |  T = {temp} °C  |  Vp = {vp} V',
        fontsize=13, fontweight='bold'
    )

    # Panel 1 – Napięcie wyjściowe
    axes[0].plot(time_us, vout, color=COLORS['vout'], linewidth=1.2)
    axes[0].axhline(avgs['vout'], color=COLORS['vout'], linestyle='--',
                    linewidth=0.8, alpha=0.6,
                    label=f"śr. = {avgs['vout']:.4f} V")
    axes[0].set_ylabel('V(out) [V]')
    axes[0].set_title('Napięcie wyjściowe V(out)')
    axes[0].legend(fontsize=9, loc='upper right')
    axes[0].grid(True, alpha=0.3)

    # Panel 2 – Napięcie biasn
    axes[1].plot(time_us, biasn, color=COLORS['biasn'], linewidth=1.2)
    axes[1].axhline(avgs['biasn'], color=COLORS['biasn'], linestyle='--',
                    linewidth=0.8, alpha=0.6,
                    label=f"śr. = {avgs['biasn']:.4f} V")
    axes[1].set_ylabel('V(biasn) [V]')
    axes[1].set_title('Napięcie polaryzacji V(biasn)')
    axes[1].legend(fontsize=9, loc='upper right')
    axes[1].grid(True, alpha=0.3)

    # Panel 3 – Napięcie biasp
    axes[2].plot(time_us, biasp, color=COLORS['biasp'], linewidth=1.2)
    axes[2].axhline(avgs['biasp'], color=COLORS['biasp'], linestyle='--',
                    linewidth=0.8, alpha=0.6,
                    label=f"śr. = {avgs['biasp']:.4f} V")
    axes[2].set_ylabel('V(biasp) [V]')
    axes[2].set_title('Napięcie polaryzacji V(biasp)')
    axes[2].legend(fontsize=9, loc='upper right')
    axes[2].grid(True, alpha=0.3)

    # Panel 4 – Prąd Viup
    axes[3].plot(time_us, i_viup_nA, color=COLORS['i_viup'], linewidth=1.2)
    axes[3].axhline(avgs['i_Viup'], color=COLORS['i_viup'], linestyle='--',
                    linewidth=0.8, alpha=0.6,
                    label=f"śr. = {avgs['i_Viup']:.4f} nA")
    axes[3].set_ylabel('i(Viup) [nA]')
    axes[3].set_title('Prąd źródła Viup')
    axes[3].set_ylim(-800, 800)                          # stała skala ±800 nA
    axes[3].legend(fontsize=9, loc='upper right')
    axes[3].grid(True, alpha=0.3)

    # Panel 5 – Prąd Vidn
    axes[4].plot(time_us, i_vidn_nA, color=COLORS['i_vidn'], linewidth=1.2)
    axes[4].axhline(avgs['i_Vidn'], color=COLORS['i_vidn'], linestyle='--',
                    linewidth=0.8, alpha=0.6,
                    label=f"śr. = {avgs['i_Vidn']:.4f} nA")
    axes[4].set_ylabel('i(Vidn) [nA]')
    axes[4].set_title('Prąd źródła Vidn')
    axes[4].set_ylim(-800, 800)                          # stała skala ±800 nA
    axes[4].set_xlabel('Czas [µs]')
    axes[4].legend(fontsize=9, loc='upper right')
    axes[4].grid(True, alpha=0.3)

    # Podziałka osi czasu – co 10 µs główna, co 5 µs pomocnicza
    import matplotlib.ticker as ticker
    for ax in axes:
        ax.xaxis.set_major_locator(ticker.MultipleLocator(10))   # główne: co 10 µs
        ax.xaxis.set_minor_locator(ticker.MultipleLocator(5))    # pomocnicze: co 5 µs
        ax.xaxis.set_major_formatter(ticker.FormatStrFormatter('%.0f µs'))
        ax.tick_params(axis='x', which='major', labelsize=8)
        ax.tick_params(axis='x', which='minor', length=3)
        ax.grid(True, which='minor', alpha=0.15, linestyle=':')

    plt.tight_layout(rect=[0, 0, 1, 0.95])
    out_img = os.path.join(RESULTS_DIR, f'cp_new500n_{tag}.png')
    plt.savefig(out_img, dpi=150, bbox_inches='tight')
    plt.close()
    print(f"  Zapisano wykres: {out_img}")

# ---------------------------------------------------------------------------
# Sortowanie podsumowania: corner → temp → vp
# ---------------------------------------------------------------------------
summary.sort(key=lambda x: (
    CORNER_ORDER.get(x[1], 99),
    float(x[2]),
    float(x[3])
))

# ---------------------------------------------------------------------------
# Generowanie raportu HTML
# ---------------------------------------------------------------------------

def fmt(val: float, decimals: int = 4) -> str:
    return f"{val:.{decimals}f}"


# ---- zakładki ----
html_tabs = '<button class="tab active" onclick="showTab(\'summary\', this)">📋 Podsumowanie</button>\n'
for tag, corner, temp, vp, _ in summary:
    label = f'{corner} T{temp}°C {vp}V'
    html_tabs += (
        f'<button class="tab" onclick="showTab(\'{tag}\', this)">'
        f'{label}</button>\n'
    )

# ---- wiersze tabeli podsumowania ----
summary_rows = ''
current_corner = None
for tag, corner, temp, vp, avgs in summary:
    if corner != current_corner:
        current_corner = corner
        corner_label = corner.replace('mos_', '').upper()
        summary_rows += (
            f'<tr class="corner-header">'
            f'<td colspan="8"><b>Corner: {corner} ({corner_label})</b></td>'  # +1 kolumna
            f'</tr>\n'
        )
    summary_rows += f'''
        <tr>
            <td>{temp} °C</td>
            <td>{vp} V</td>
            <td class="num">{fmt(avgs["vout"])}</td>
            <td class="num">{fmt(avgs["biasn"])}</td>
            <td class="num">{fmt(avgs["biasp"])}</td>
            <td class="num">{fmt(avgs["i_Viup"], 2)}</td>
            <td class="num">{fmt(avgs["i_Vidn"], 2)}</td>
            <td><a href="#" onclick="showTabByTag(\'{tag}\'); return false;">🔍 Wykres</a></td>
        </tr>
    '''

# ---- panele z wykresami ----
html_panels = f'''
<div id="summary" class="panel active">
    <h2>Podsumowanie – Charge Pump NEW_500n (PVT corners)</h2>
    <p class="note">Wartości uśrednione z ostatniej 1/4 czasu symulacji.</p>
    <table class="summary">
        <thead>
            <tr>
                <th>Temp</th>
                <th>Vp</th>
                <th>V(out) [V]</th>
                <th>V(biasn) [V]</th>
                <th>V(biasp) [V]</th>
                <th>i(Viup) [nA]</th>
                <th>i(Vidn) [nA]</th>
                <th>Wykres</th>
            </tr>
        </thead>
        <tbody>{summary_rows}</tbody>
    </table>
</div>
'''

for tag, corner, temp, vp, avgs in summary:
    png_name = f'cp_new500n_{tag}.png'
    html_panels += f'''
<div id="{tag}" class="panel">
    <h2>Corner: {corner} &nbsp;|&nbsp; T = {temp} °C &nbsp;|&nbsp; Vp = {vp} V</h2>
    <div class="stats-bar">
        <span class="stat vout">V(out) śr. = {fmt(avgs["vout"])} V</span>
        <span class="stat biasn">V(biasn) śr. = {fmt(avgs["biasn"])} V</span>
        <span class="stat biasp">V(biasp) śr. = {fmt(avgs["biasp"])} V</span>
        <span class="stat iviup">i(Viup) śr. = {fmt(avgs["i_Viup"], 4)} nA</span>
        <span class="stat ividn">i(Vidn) śr. = {fmt(avgs["i_Vidn"], 4)} nA</span>
    </div>
    <div class="card">
        <img src="{png_name}" style="max-width:100%; height:auto;">
    </div>
</div>
'''

# ---- kompletny HTML ----
html = f'''<!DOCTYPE html>
<html lang="pl">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Charge Pump NEW_500n – Raport PVT</title>
<style>
/* ===== reset & base ===== */
*, *::before, *::after {{ box-sizing: border-box; margin: 0; padding: 0; }}
body {{
    font-family: 'Segoe UI', Arial, sans-serif;
    font-size: 14px;
    background: #eef1f6;
    color: #222;
}}

/* ===== layout ===== */
header {{
    background: linear-gradient(135deg, #1a3a5c 0%, #2e6da4 100%);
    color: white;
    padding: 18px 30px;
    display: flex;
    align-items: center;
    gap: 14px;
    box-shadow: 0 2px 6px rgba(0,0,0,.3);
}}
header h1 {{ font-size: 20px; font-weight: 700; }}
header .subtitle {{ font-size: 12px; opacity: .8; margin-top: 3px; }}

.container {{
    max-width: 1400px;
    margin: 0 auto;
    padding: 20px 24px;
}}

/* ===== tabs ===== */
.tabs {{
    display: flex;
    flex-wrap: wrap;
    gap: 5px;
    margin-bottom: 18px;
    padding: 12px;
    background: white;
    border-radius: 8px;
    box-shadow: 0 1px 4px rgba(0,0,0,.1);
}}
.tab {{
    padding: 7px 13px;
    background: #e4e8ef;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 12px;
    font-family: inherit;
    color: #333;
    transition: background .15s, color .15s;
    white-space: nowrap;
}}
.tab:hover  {{ background: #c5d6ea; }}
.tab.active {{ background: #2e6da4; color: white; font-weight: 600; }}

/* ===== panels ===== */
.panel {{ display: none; }}
.panel.active {{ display: block; }}

/* ===== summary table ===== */
.note {{ color: #666; font-size: 12px; margin: 6px 0 14px; }}
table.summary {{
    border-collapse: collapse;
    width: 100%;
    font-size: 13px;
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 1px 4px rgba(0,0,0,.1);
}}
table.summary thead th {{
    background: #2e6da4;
    color: white;
    padding: 10px 12px;
    text-align: center;
    font-weight: 600;
    letter-spacing: .3px;
}}
table.summary td {{
    padding: 7px 12px;
    border-bottom: 1px solid #e0e4ea;
    text-align: center;
}}
table.summary tr:last-child td {{ border-bottom: none; }}
table.summary tr:hover:not(.corner-header) {{ background: #f0f5fb; }}
table.summary td.num {{ font-family: 'Consolas', monospace; font-size: 12.5px; }}
tr.corner-header td {{
    background: #dce8f5;
    font-size: 13px;
    text-align: left;
    padding: 8px 12px;
    color: #1a3a5c;
}}
table.summary a {{
    color: #2e6da4;
    text-decoration: none;
    font-weight: 600;
}}
table.summary a:hover {{ text-decoration: underline; }}

/* ===== chart panel ===== */
h2 {{
    font-size: 16px;
    color: #1a3a5c;
    border-bottom: 2px solid #2e6da4;
    padding-bottom: 6px;
    margin-bottom: 14px;
}}
.stats-bar {{
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    margin-bottom: 16px;
}}
.stat {{
    padding: 5px 14px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
    font-family: 'Consolas', monospace;
    color: white;
}}
.stat.vout   {{ background: #1f77b4; }}
.stat.biasn  {{ background: #d62728; }}
.stat.biasp  {{ background: #e67e22; }}
.stat.iviup  {{ background: #2ca02c; }}
.stat.ividn  {{ background: #7b4fa6; }}

.card {{
    background: white;
    border-radius: 8px;
    padding: 16px;
    box-shadow: 0 1px 4px rgba(0,0,0,.1);
}}
</style>
</head>
<body>

<header>
    <div>
        <h1>⚡ Charge Pump NEW_500n – Raport PVT</h1>
        <div class="subtitle">
            Symulacja transientna | 5 cornery MOS × 3 temperatury × 3 napięcia Vp = 45 przypadków
        </div>
    </div>
</header>

<div class="container">
    <div class="tabs">{html_tabs}</div>
    {html_panels}
</div>

<script>
function showTab(id, el) {{
    document.querySelectorAll('.panel').forEach(p => p.classList.remove('active'));
    document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
    var panel = document.getElementById(id);
    if (panel) panel.classList.add('active');
    if (el) el.classList.add('active');
    window.scrollTo({{top: 0, behavior: 'smooth'}});
}}
function showTabByTag(id) {{
    var btn = Array.from(document.querySelectorAll('.tab'))
        .find(t => (t.getAttribute('onclick') || '').includes("'" + id + "'"));
    showTab(id, btn || null);
}}
</script>

</body>
</html>
'''

with open(html_out, 'w', encoding='utf-8') as fh:
    fh.write(html)

print(f"\nZapisano raport: {html_out}")
print(f"Wygenerowano wykresów: {len(summary)}")
print("Done.")
