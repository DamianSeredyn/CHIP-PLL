"""
Generuje interaktywny raport HTML z wynikow sweepa (wyniki_dobre.txt / wyniki_zle.txt /
wyniki_wszystkie_n_ok.txt). Tabela ma pola filtrow nad kazda kolumna.

Zakladki:
  - jedna per N (dane tylko dla tego dzielnika/VCO)
  - jedna "Wszystkie N stabilne" - przypadki (C1,C2,R2,icp) ktore sa stabilne
    dla KAZDEGO N naraz

Uzycie:
    python3 make_html_report.py
"""

import json
import re

IN_FILE_GOOD    = 'wyniki_dobre.txt'
IN_FILE_BAD     = 'wyniki_zle.txt'
IN_FILE_ALL_OK  = 'wyniki_wszystkie_n_ok.txt'
OUT_FILE        = 'raport.html'

COLUMNS = ["C1", "C2", "R2", "icp", "gmv2i", "kcco", "cvco", "rvco",
           "N", "PM", "GM", "BW", "stabilny"]


def to_float(s, default=float('nan')):
    try:
        return float(s)
    except (ValueError, TypeError):
        return default


def load_per_n_file(path):
    rows = []
    try:
        with open(path, 'r') as f:
            for line in f:
                line = line.strip()
                if not line or line.startswith('#'):
                    continue
                parts = line.split()
                if len(parts) != len(COLUMNS):
                    continue
                rows.append(dict(zip(COLUMNS, parts)))
    except FileNotFoundError:
        print(f"[UWAGA] nie znaleziono pliku: {path} (pomijam)")
    return rows


def load_all_ok_file(path):
    """Wczytuje plik z dynamiczna liczba kolumn (zalezna od liczby N).
    Zwraca (header_cols, rows) gdzie header_cols to lista nazw kolumn
    bez nawiasow jednostek, a rows to lista slownikow surowych stringow."""
    header_cols = None
    rows = []
    try:
        with open(path, 'r') as f:
            for line in f:
                line = line.strip()
                if not line:
                    continue
                if line.startswith('#'):
                    header_cols = line.lstrip('#').split()
                    continue
                if header_cols is None:
                    continue
                parts = line.split()
                if len(parts) != len(header_cols):
                    continue
                rows.append(dict(zip(header_cols, parts)))
    except FileNotFoundError:
        print(f"[UWAGA] nie znaleziono pliku: {path} (pomijam)")
    return header_cols or [], rows


def strip_unit(colname):
    """'PM_N2432[deg]' -> 'PM_N2432' ; 'BW[rad/s]' -> 'BW'"""
    return re.sub(r'\[.*?\]$', '', colname)


def main():
    # ---- dane per-N (dobre + zle) ----
    rows = load_per_n_file(IN_FILE_GOOD) + load_per_n_file(IN_FILE_BAD)
    print(f"Wczytano {len(rows)} wierszy per-N (dobre+zle)")

    data_per_n = {}
    for r in rows:
        n_val = r["N"]
        data_per_n.setdefault(n_val, []).append({
            "C1_pF":   to_float(r["C1"]) * 1e12,
            "C2_pF":   to_float(r["C2"]) * 1e12,
            "R2_kOhm": to_float(r["R2"]) / 1e3,
            "icp_uA":  to_float(r["icp"]) * 1e6,
            "PM_deg":  to_float(r["PM"]),
            "GM_dB":   to_float(r["GM"]),
            "BW":      to_float(r["BW"]),
            "stabilny": r["stabilny"],
        })

    for n_val, d in data_per_n.items():
        d.sort(key=lambda x: (x["PM_deg"] != x["PM_deg"], -x["PM_deg"] if x["PM_deg"] == x["PM_deg"] else 0))

    n_values = sorted(data_per_n.keys(), key=lambda x: to_float(x))

    # ---- dane "wszystkie N stabilne" ----
    header_cols, allok_rows_raw = load_all_ok_file(IN_FILE_ALL_OK)
    print(f"Wczytano {len(allok_rows_raw)} wierszy stabilnych dla wszystkich N")

    # ustal liste N-ow wystepujacych w naglowku pliku all-ok (z nazw kolumn PM_N<x>)
    allok_n_list = []
    for c in header_cols:
        m = re.match(r'PM_N(.+?)(\[.*\])?$', c)
        if m:
            allok_n_list.append(m.group(1))

    data_all_ok = []
    for r in allok_rows_raw:
        row = {
            "C1_pF":   to_float(r.get("C1")) * 1e12,
            "C2_pF":   to_float(r.get("C2")) * 1e12,
            "R2_kOhm": to_float(r.get("R2")) / 1e3,
            "icp_uA":  to_float(r.get("icp")) * 1e6,
        }
        for n_val in allok_n_list:
            for prefix, suffix in (("PM", "_deg"), ("GM", "_dB"), ("BW", "")):
                # znajdz oryginalny klucz naglowka z jednostka, np. 'PM_N2432[deg]'
                match_key = next((c for c in header_cols
                                   if strip_unit(c) == f"{prefix}_N{n_val}"), None)
                out_key = f"{prefix}_N{n_val}{suffix}"
                row[out_key] = to_float(r.get(match_key)) if match_key else float('nan')
        data_all_ok.append(row)

    # sortuj all-ok po najnizszym PM sposrod wszystkich N (najgorszy przypadek najpierw,
    # zeby na gorze byly te "najciasniej" spelniajace kryterium)
    def worst_pm(row):
        vals = [row[f"PM_N{n}_deg"] for n in allok_n_list]
        vals = [v for v in vals if v == v]  # odfiltruj nan
        return -min(vals) if vals else 0
    data_all_ok.sort(key=worst_pm)

    html = HTML_TEMPLATE
    html = html.replace("__DATA_PER_N_JSON__", json.dumps(data_per_n))
    html = html.replace("__N_VALUES_JSON__", json.dumps(n_values))
    html = html.replace("__DATA_ALL_OK_JSON__", json.dumps(data_all_ok))
    html = html.replace("__ALLOK_N_LIST_JSON__", json.dumps(allok_n_list))

    with open(OUT_FILE, 'w') as f:
        f.write(html)

    total_per_n = sum(len(d) for d in data_per_n.values())
    print(f"Zapisano raport: {OUT_FILE}")
    print(f"  Zakladki N: {n_values} ({total_per_n} wierszy lacznie)")
    print(f"  Zakladka 'wszystkie N stabilne': {len(data_all_ok)} wierszy")


HTML_TEMPLATE = r"""<!DOCTYPE html>
<html lang="pl">
<head>
<meta charset="UTF-8">
<title>Wyniki sweepa PLL</title>
<style>
  :root {
    --bg: #0d1117;
    --panel: #12181f;
    --border: #263140;
    --text: #d7dee6;
    --text-dim: #7b8794;
    --accent: #5fc9a8;
    --accent2: #d9a95f;
    --bad: #d9736b;
    --mono: "JetBrains Mono", "SF Mono", Consolas, monospace;
  }
  * { box-sizing: border-box; }
  body {
    background: var(--bg);
    color: var(--text);
    font-family: var(--mono);
    margin: 0;
    padding: 24px;
    font-size: 13px;
  }
  h1 {
    font-size: 16px;
    font-weight: 600;
    letter-spacing: 0.02em;
    margin: 0 0 4px 0;
  }
  .subtitle {
    color: var(--text-dim);
    font-size: 12px;
    margin-bottom: 16px;
  }
  .tabs {
    display: flex;
    gap: 4px;
    margin-bottom: 12px;
    border-bottom: 1px solid var(--border);
    flex-wrap: wrap;
  }
  .tab-btn {
    background: none;
    border: none;
    color: var(--text-dim);
    padding: 8px 16px;
    cursor: pointer;
    font-family: var(--mono);
    font-size: 13px;
    border-bottom: 2px solid transparent;
    margin-bottom: -1px;
  }
  .tab-btn:hover { color: var(--text); }
  .tab-btn.active {
    color: var(--accent);
    border-bottom-color: var(--accent);
  }
  .tab-btn.special.active {
    color: var(--accent2);
    border-bottom-color: var(--accent2);
  }
  .tab-panel { display: none; }
  .tab-panel.active { display: block; }
  .toolbar {
    display: flex;
    gap: 12px;
    align-items: center;
    margin-bottom: 10px;
    flex-wrap: wrap;
  }
  .toolbar button {
    background: var(--panel);
    border: 1px solid var(--border);
    color: var(--text);
    padding: 6px 12px;
    border-radius: 3px;
    cursor: pointer;
    font-family: var(--mono);
    font-size: 12px;
  }
  .toolbar button:hover { border-color: var(--accent); color: var(--accent); }
  .count { color: var(--accent); font-size: 12px; }
  .table-wrap {
    border: 1px solid var(--border);
    border-radius: 4px;
    overflow: auto;
    max-height: 78vh;
  }
  table { border-collapse: collapse; width: 100%; min-width: 900px; }
  thead th {
    position: sticky; top: 0;
    background: var(--panel);
    color: var(--text-dim);
    text-align: right;
    padding: 8px 10px 4px 10px;
    font-weight: 500;
    border-bottom: 1px solid var(--border);
    font-size: 11px;
    z-index: 2;
    white-space: nowrap;
  }
  thead th:first-child, td:first-child { text-align: left; padding-left: 14px; }
  .filter-row th {
    position: sticky; top: 27px;
    background: var(--panel);
    padding: 4px 6px 8px 6px;
    border-bottom: 1px solid var(--border);
    z-index: 2;
  }
  .filter-row input {
    width: 100%; min-width: 60px;
    background: var(--bg);
    border: 1px solid var(--border);
    color: var(--accent);
    padding: 4px 6px;
    border-radius: 3px;
    font-family: var(--mono);
    font-size: 12px;
    text-align: right;
  }
  .filter-row input::placeholder { color: #465063; }
  .filter-row input:focus { outline: none; border-color: var(--accent); }
  tbody td {
    padding: 5px 10px;
    text-align: right;
    border-bottom: 1px solid #1a222c;
    white-space: nowrap;
  }
  tbody tr:hover { background: #161d26; }
  tbody tr.unstable td { color: var(--bad); }
  .hint {
    color: var(--text-dim);
    font-size: 11px;
    margin-top: 10px;
    line-height: 1.6;
  }
  .hint code { background: var(--panel); padding: 1px 5px; border-radius: 3px; color: var(--accent); }
</style>
</head>
<body>

<h1>Wyniki sweepa PLL</h1>
<div class="subtitle">Filtruj kazda kolumne osobno - wartosci w pF / kOhm / uA / deg / dB</div>

<div class="tabs" id="tabs"></div>
<div id="panels"></div>

<div class="hint">
  Skladnia filtrow: <code>&lt;50</code> mniejsze niz, <code>&gt;10</code> wieksze niz,
  <code>&lt;=25</code>, <code>&gt;=5</code>, <code>10-30</code> zakres (wlacznie), <code>5</code> dokladna wartosc.
</div>

<script>
const DATA_PER_N   = __DATA_PER_N_JSON__;
const N_VALUES     = __N_VALUES_JSON__;
const DATA_ALL_OK  = __DATA_ALL_OK_JSON__;
const ALLOK_N_LIST = __ALLOK_N_LIST_JSON__;

function parseFilter(str) {
  str = str.trim();
  if (!str) return null;
  let m = str.match(/^(-?[\d.eE+]+)\s*-\s*(-?[\d.eE+]+)$/);
  if (m) {
    const a = parseFloat(m[1]), b = parseFloat(m[2]);
    return v => v >= Math.min(a,b) && v <= Math.max(a,b);
  }
  m = str.match(/^(<=|>=|<|>|=)?\s*(-?[\d.eE+]+)$/);
  if (m) {
    const op = m[1] || "=";
    const x = parseFloat(m[2]);
    if (op === "<")  return v => v < x;
    if (op === "<=") return v => v <= x;
    if (op === ">")  return v => v > x;
    if (op === ">=") return v => v >= x;
    return v => Math.abs(v - x) < 1e-9 || v === x;
  }
  return null;
}

function fmt(v) {
  if (v === null || v === undefined) return "nan";
  v = Number(v);   // stabilny (i inne kolumny) przychodza jako string - wymusz liczbe
  if (Number.isNaN(v)) return "nan";
  if (!isFinite(v)) return v > 0 ? "inf" : "-inf";
  if (Math.abs(v) >= 1000 || (Math.abs(v) < 0.001 && v !== 0)) return v.toExponential(3);
  return (Math.round(v * 1000) / 1000).toString();
}

// --- konfiguracja kolumn per zakladka ---
// kazda kolumna: {key, label}
function perNColumns() {
  return [
    {key: "C1_pF",   label: "C1 [pF]"},
    {key: "C2_pF",   label: "C2 [pF]"},
    {key: "R2_kOhm", label: "R2 [kOhm]"},
    {key: "icp_uA",  label: "icp [uA]"},
    {key: "PM_deg",  label: "PM [deg]"},
    {key: "GM_dB",   label: "GM [dB]"},
    {key: "BW",      label: "BW [rad/s]"},
    {key: "stabilny",label: "stabilny"},
  ];
}

function allOkColumns() {
  const cols = [
    {key: "C1_pF",   label: "C1 [pF]"},
    {key: "C2_pF",   label: "C2 [pF]"},
    {key: "R2_kOhm", label: "R2 [kOhm]"},
    {key: "icp_uA",  label: "icp [uA]"},
  ];
  for (const n of ALLOK_N_LIST) {
    cols.push({key: `PM_N${n}_deg`, label: `PM N=${n} [deg]`});
    cols.push({key: `GM_N${n}_dB`,  label: `GM N=${n} [dB]`});
  }
  return cols;
}

// --- generyczny builder tabeli z filtrami ---
function buildTablePanel(panelId, data, columns, unstableKey) {
  const panel = document.getElementById(panelId);

  let theadHtml = '<tr>' + columns.map(c => `<th>${c.label}</th>`).join('') + '</tr>';
  theadHtml += '<tr class="filter-row">' +
    columns.map(c => `<th><input data-col="${c.key}" placeholder=""></th>`).join('') +
    '</tr>';

  panel.innerHTML = `
    <div class="toolbar">
      <button class="clear-btn">Wyczysc filtry</button>
      <span class="count"></span>
    </div>
    <div class="table-wrap">
      <table>
        <thead>${theadHtml}</thead>
        <tbody></tbody>
      </table>
    </div>
  `;

  const tbody = panel.querySelector('tbody');
  const countEl = panel.querySelector('.count');
  const inputs = panel.querySelectorAll('.filter-row input');

  function render() {
    const filters = {};
    inputs.forEach(inp => {
      const f = parseFilter(inp.value);
      if (f) filters[inp.dataset.col] = f;
    });

    const rowsHtml = [];
    let shown = 0;
    for (const d of data) {
      let ok = true;
      for (const col in filters) {
        const raw = d[col];
        const val = (col === "stabilny") ? parseFloat(raw) : raw;
        if (!filters[col](val)) { ok = false; break; }
      }
      if (!ok) continue;
      shown++;
      const cls = (unstableKey && d[unstableKey] === "0") ? "unstable" : "";
      const tds = columns.map(c => `<td>${fmt(d[c.key])}</td>`).join('');
      rowsHtml.push(`<tr class="${cls}">${tds}</tr>`);
      if (shown >= 3000) break;
    }

    tbody.innerHTML = rowsHtml.join('');
    const total = data.length;
    countEl.textContent = shown < total
      ? `pokazano ${shown} / ${total}` + (shown === 3000 ? " (limit podgladu, zawez filtry)" : "")
      : `${total} wierszy`;
  }

  inputs.forEach(inp => inp.addEventListener('input', render));
  panel.querySelector('.clear-btn').addEventListener('click', () => {
    inputs.forEach(i => i.value = '');
    render();
  });

  render();
}

// --- budowa zakladek ---
const tabsEl = document.getElementById('tabs');
const panelsEl = document.getElementById('panels');

function addTab(id, label, special) {
  const btn = document.createElement('button');
  btn.className = 'tab-btn' + (special ? ' special' : '');
  btn.textContent = label;
  btn.dataset.target = id;
  btn.addEventListener('click', () => {
    document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
    document.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'));
    btn.classList.add('active');
    document.getElementById(id).classList.add('active');
  });
  tabsEl.appendChild(btn);

  const panel = document.createElement('div');
  panel.className = 'tab-panel';
  panel.id = id;
  panelsEl.appendChild(panel);

  return btn;
}

let firstBtn = null;

for (const n of N_VALUES) {
  const tabId = `tab-n-${n}`;
  const btn = addTab(tabId, `N = ${n}`, false);
  if (!firstBtn) firstBtn = btn;
  buildTablePanel(tabId, DATA_PER_N[n], perNColumns(), "stabilny");
}

const allOkBtn = addTab('tab-all-ok', `Wszystkie N stabilne (${DATA_ALL_OK.length})`, true);
buildTablePanel('tab-all-ok', DATA_ALL_OK, allOkColumns(), null);

if (firstBtn) {
  firstBtn.classList.add('active');
  document.getElementById(firstBtn.dataset.target).classList.add('active');
} else {
  allOkBtn.classList.add('active');
  document.getElementById('tab-all-ok').classList.add('active');
}
</script>

</body>
</html>
"""


if __name__ == "__main__":
    main()
