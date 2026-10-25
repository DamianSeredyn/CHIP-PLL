#!/usr/bin/env python3
"""
PFD Netlist Editor — Finger Grouper
Edytuje tylko W i L tranzystorów pogrupowanych po fingerach.
Wszystkie inne elementy (R, C, komentarze, .subckt itp.) pozostają niezmienione.
"""

import tkinter as tk
from tkinter import ttk, filedialog, messagebox
import re
import os

# ── stałe ────────────────────────────────────────────────────────────────────
MOSFET_TYPES = ("sg13_lv_nmos", "sg13_lv_pmos", "sg13_hv_nmos", "sg13_hv_pmos")
FINGER_RE    = re.compile(r'\.t\d+$')
W_RE         = re.compile(r'(w=)([\d.]+)(u)')
L_RE         = re.compile(r'(l=)([\d.]+)(u)')

# ── parsowanie ────────────────────────────────────────────────────────────────
def base(node):
    return FINGER_RE.sub('', node)

def parse_transistor(line):
    """Zwraca dict z danymi tranzystora lub None jeśli linia nie jest tranzystorem."""
    stripped = line.strip()
    if not stripped or stripped.startswith('*'):
        return None
    parts = stripped.split()
    if not parts[0].upper().startswith('X'):
        return None
    # znajdź typ MOSFET
    type_idx = next((i for i, p in enumerate(parts) if p in MOSFET_TYPES), None)
    if type_idx is None:
        return None
    name   = parts[0]
    nodes  = parts[1:type_idx]   # D G S B
    mtype  = parts[type_idx]
    params = parts[type_idx+1:]
    if len(nodes) < 4:
        return None
    d, g, s, b = nodes[0], nodes[1], nodes[2], nodes[3]
    w_m = W_RE.search(stripped)
    l_m = L_RE.search(stripped)
    w_val = float(w_m.group(2)) if w_m else 0.0
    l_val = float(l_m.group(2)) if l_m else 0.0
    return dict(
        name=name, mtype=mtype,
        d=d, g=g, s=s, b=b,
        dB=base(d), gB=base(g), sB=base(s), bB=base(b),
        w=w_val, l=l_val,
        w_orig=w_val, l_orig=l_val,
    )

def group_key(t):
    return (t['mtype'], t['gB'], t['dB'], t['sB'], t['bB'],
            round(t['w_orig'], 6), round(t['l_orig'], 6))

def build_groups(transistors):
    """Grupuje tranzystory — klucz to podłączenie + typ + oryginalne W/L."""
    gmap = {}
    gorder = []
    for idx, t in transistors:
        k = group_key(t)
        if k not in gmap:
            gmap[k] = []
            gorder.append(k)
        gmap[k].append((idx, t))
    return gorder, gmap


# ── GUI ───────────────────────────────────────────────────────────────────────
class NetlistEditor(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("PFD Netlist Editor — Finger Grouper")
        self.geometry("1100x680")
        self.configure(bg="#1e1e2e")
        self.minsize(800, 500)

        self.filepath    = None
        self.all_lines   = []          # wszystkie linie pliku (oryginalne)
        self.transistors = []          # [(line_idx, dict), ...]
        self.groups      = []          # [{'key':…, 'members':[(line_idx,dict),…]}, …]
        self.group_rows  = []          # widoczne grupy po filtracji
        self._iid_to_group = {}        # iid (str) → group dict  ← KLUCZ NAPRAWY

        self._build_ui()
        self._set_status("Otwórz plik netlist (.sp / .spi / .scs)")

    # ── UI ────────────────────────────────────────────────────────────────────
    def _build_ui(self):
        # top bar
        top = tk.Frame(self, bg="#1e1e2e", pady=6)
        top.pack(fill="x", padx=10)

        btn_open = tk.Button(top, text="📂  Otwórz netlist", command=self.open_file,
                             bg="#313244", fg="#cdd6f4", relief="flat",
                             activebackground="#45475a", activeforeground="#cdd6f4",
                             padx=10, pady=4, cursor="hand2")
        btn_open.pack(side="left", padx=(0,6))

        btn_save = tk.Button(top, text="💾  Zapisz", command=self.save_file,
                             bg="#a6e3a1", fg="#1e1e2e", relief="flat",
                             activebackground="#94e2d5", padx=10, pady=4, cursor="hand2")
        btn_save.pack(side="left", padx=(0,6))

        btn_saveas = tk.Button(top, text="💾  Zapisz jako…", command=self.save_file_as,
                               bg="#89b4fa", fg="#1e1e2e", relief="flat",
                               activebackground="#74c7ec", padx=10, pady=4, cursor="hand2")
        btn_saveas.pack(side="left", padx=(0,6))

        btn_reset = tk.Button(top, text="↩  Reset zmian", command=self.reset_all,
                              bg="#fab387", fg="#1e1e2e", relief="flat",
                              activebackground="#f38ba8", padx=10, pady=4, cursor="hand2")
        btn_reset.pack(side="left", padx=(0,20))

        # filtry
        tk.Label(top, text="Szukaj:", bg="#1e1e2e", fg="#a6adc8").pack(side="left")
        self.search_var = tk.StringVar()
        self.search_var.trace_add("write", lambda *_: self._apply_filter())
        ent = tk.Entry(top, textvariable=self.search_var, width=20,
                       bg="#313244", fg="#cdd6f4", insertbackground="#cdd6f4",
                       relief="flat", bd=4)
        ent.pack(side="left", padx=(4, 12))

        tk.Label(top, text="Typ:", bg="#1e1e2e", fg="#a6adc8").pack(side="left")
        self.type_var = tk.StringVar(value="Wszystkie")
        cb_type = ttk.Combobox(top, textvariable=self.type_var, width=10,
                                values=["Wszystkie", "pmos", "nmos"], state="readonly")
        cb_type.pack(side="left", padx=(4, 12))
        cb_type.bind("<<ComboboxSelected>>", lambda _: self._apply_filter())

        tk.Label(top, text="Fingery:", bg="#1e1e2e", fg="#a6adc8").pack(side="left")
        self.fg_var = tk.StringVar(value="Wszystkie")
        cb_fg = ttk.Combobox(top, textvariable=self.fg_var, width=12,
                              values=["Wszystkie", "≥2 (wielofinger)", "1 (pojedyncze)"],
                              state="readonly")
        cb_fg.pack(side="left", padx=(4, 12))
        cb_fg.bind("<<ComboboxSelected>>", lambda _: self._apply_filter())

        tk.Label(top, text="Pokaż:", bg="#1e1e2e", fg="#a6adc8").pack(side="left")
        self.mod_var = tk.StringVar(value="Wszystkie")
        cb_mod = ttk.Combobox(top, textvariable=self.mod_var, width=14,
                               values=["Wszystkie", "Zmodyfikowane"],
                               state="readonly")
        cb_mod.pack(side="left", padx=(4, 0))
        cb_mod.bind("<<ComboboxSelected>>", lambda _: self._apply_filter())

        # status bar
        self.status_var = tk.StringVar()
        status = tk.Label(self, textvariable=self.status_var, bg="#181825",
                          fg="#a6adc8", anchor="w", padx=10, pady=3)
        status.pack(side="bottom", fill="x")

        # tabela
        frame = tk.Frame(self, bg="#1e1e2e")
        frame.pack(fill="both", expand=True, padx=10, pady=(0, 6))

        style = ttk.Style()
        style.theme_use("clam")
        style.configure("Treeview",
                         background="#181825", foreground="#cdd6f4",
                         fieldbackground="#181825", rowheight=26,
                         font=("Courier New", 11))
        style.configure("Treeview.Heading",
                         background="#313244", foreground="#cdd6f4",
                         font=("Segoe UI", 10, "bold"), relief="flat")
        style.map("Treeview",
                  background=[("selected", "#45475a")],
                  foreground=[("selected", "#cdd6f4")])

        cols = ("fg", "names", "type", "w", "l", "gate", "drain", "source")
        self.tree = ttk.Treeview(frame, columns=cols, show="headings",
                                  selectmode="browse")

        self.tree.heading("fg",     text="Fg ↕",  command=lambda: self._sort("fg"))
        self.tree.heading("names",  text="Instancje")
        self.tree.heading("type",   text="Typ",   command=lambda: self._sort("type"))
        self.tree.heading("w",      text="W (µm)",command=lambda: self._sort("w"))
        self.tree.heading("l",      text="L (µm)",command=lambda: self._sort("l"))
        self.tree.heading("gate",   text="Gate",  command=lambda: self._sort("gate"))
        self.tree.heading("drain",  text="Drain", command=lambda: self._sort("drain"))
        self.tree.heading("source", text="Source",command=lambda: self._sort("source"))

        self.tree.column("fg",     width=50,  minwidth=40,  anchor="center")
        self.tree.column("names",  width=200, minwidth=120)
        self.tree.column("type",   width=70,  minwidth=60,  anchor="center")
        self.tree.column("w",      width=90,  minwidth=70,  anchor="center")
        self.tree.column("l",      width=90,  minwidth=70,  anchor="center")
        self.tree.column("gate",   width=130, minwidth=80)
        self.tree.column("drain",  width=130, minwidth=80)
        self.tree.column("source", width=130, minwidth=80)

        self.tree.tag_configure("modified", background="#1c3a5e", foreground="#89b4fa")
        self.tree.tag_configure("pmos",     foreground="#fab387")
        self.tree.tag_configure("nmos",     foreground="#89dceb")
        self.tree.tag_configure("pmos_mod", background="#1c3a5e", foreground="#fab387")
        self.tree.tag_configure("nmos_mod", background="#1c3a5e", foreground="#89dceb")

        vsb = ttk.Scrollbar(frame, orient="vertical",   command=self.tree.yview)
        hsb = ttk.Scrollbar(frame, orient="horizontal", command=self.tree.xview)
        self.tree.configure(yscrollcommand=vsb.set, xscrollcommand=hsb.set)

        self.tree.grid(row=0, column=0, sticky="nsew")
        vsb.grid(row=0, column=1, sticky="ns")
        hsb.grid(row=1, column=0, sticky="ew")
        frame.rowconfigure(0, weight=1)
        frame.columnconfigure(0, weight=1)

        self.tree.bind("<Double-1>", self._on_double_click)

        # sort state
        self._sort_col = "fg"
        self._sort_rev = True

    # ── plik ──────────────────────────────────────────────────────────────────
    def open_file(self):
        path = filedialog.askopenfilename(
            title="Otwórz netlist",
            filetypes=[("SPICE netlist", "*.sp *.spi *.scs *.cir *.net"),
                       ("Wszystkie pliki", "*.*")]
        )
        if not path:
            return
        self.filepath = path
        self._load(path)

    def _load(self, path):
        with open(path, encoding="utf-8", errors="replace") as f:
            self.all_lines = f.readlines()

        self.transistors = []
        for i, line in enumerate(self.all_lines):
            t = parse_transistor(line)
            if t:
                self.transistors.append((i, t))

        gorder, gmap = build_groups(self.transistors)
        self.groups = [
            {"key": k, "members": gmap[k]}
            for k in gorder
        ]

        self.title(f"PFD Netlist Editor — {os.path.basename(path)}")
        self._apply_filter()
        n_tr  = len(self.transistors)
        n_grp = len(self.groups)
        self._set_status(
            f"Załadowano: {len(self.all_lines)} linii | "
            f"{n_tr} tranzystorów → {n_grp} grup | "
            f"Dwuklik na grupie = edycja W/L"
        )

    def save_file(self):
        if not self.filepath:
            self.save_file_as(); return
        self._write(self.filepath)

    def save_file_as(self):
        path = filedialog.asksaveasfilename(
            title="Zapisz jako",
            defaultextension=".sp",
            initialfile=os.path.basename(self.filepath or "PFD_modified.sp"),
            filetypes=[("SPICE netlist", "*.sp *.spi"), ("Wszystkie pliki", "*.*")]
        )
        if not path:
            return
        self.filepath = path
        self._write(path)

    def _write(self, path):
        """Zapisuje plik — zmienia tylko w= i l= w liniach tranzystorów."""
        lines = list(self.all_lines)  # kopia
        for line_idx, t in self.transistors:
            orig = lines[line_idx]
            new  = W_RE.sub(lambda m: f"{m.group(1)}{t['w']:.4g}{m.group(3)}", orig)
            new  = L_RE.sub(lambda m: f"{m.group(1)}{t['l']:.4g}{m.group(3)}", new)
            lines[line_idx] = new

        with open(path, "w", encoding="utf-8") as f:
            f.writelines(lines)

        mod = sum(1 for _, t in self.transistors
                  if round(t['w'],6)!=round(t['w_orig'],6) or
                     round(t['l'],6)!=round(t['l_orig'],6))
        messagebox.showinfo("Zapisano",
                            f"Plik zapisany:\n{path}\n\n"
                            f"Zmodyfikowane tranzystory: {mod} / {len(self.transistors)}")
        self._set_status(f"Zapisano → {os.path.basename(path)} | zmienione: {mod} inst.")

    # ── tabela ────────────────────────────────────────────────────────────────
    def _apply_filter(self):
        q   = self.search_var.get().lower()
        typ = self.type_var.get()
        fgf = self.fg_var.get()
        mod = self.mod_var.get()

        visible = []
        for g in self.groups:
            t = g["members"][0][1]
            if typ != "Wszystkie" and typ not in t['mtype']:
                continue
            n = len(g["members"])
            if fgf == "≥2 (wielofinger)" and n < 2:
                continue
            if fgf == "1 (pojedyncze)" and n >= 2:
                continue
            if mod == "Zmodyfikowane":
                changed = any(
                    round(x['w'],6) != round(x['w_orig'],6) or
                    round(x['l'],6) != round(x['l_orig'],6)
                    for _, x in g["members"]
                )
                if not changed:
                    continue
            if q:
                tokens = [t['mtype'], t['gB'], t['dB'], t['sB'], t['bB']] + \
                         [x['name'] for _, x in g["members"]]
                if not any(q in tok.lower() for tok in tokens):
                    continue
            visible.append(g)

        self.group_rows = visible
        self._redraw()

    def _sort(self, col):
        if self._sort_col == col:
            self._sort_rev = not self._sort_rev
        else:
            self._sort_col = col
            self._sort_rev = False

        def key(g):
            t = g["members"][0][1]
            if col == "fg":     return len(g["members"])
            if col == "w":      return t["w"]
            if col == "l":      return t["l"]
            if col == "type":   return t["mtype"]
            if col == "gate":   return t["gB"]
            if col == "drain":  return t["dB"]
            if col == "source": return t["sB"]
            return g["members"][0][1]["name"]

        self.group_rows.sort(key=key, reverse=self._sort_rev)
        self._redraw()

    def _redraw(self):
        self.tree.delete(*self.tree.get_children())
        self._iid_to_group.clear()
        mod_total = 0

        for g in self.group_rows:
            members = g["members"]
            t  = members[0][1]
            n  = len(members)
            names_str = ", ".join(x["name"] for _, x in members)
            if len(names_str) > 60:
                shown = ", ".join(x["name"] for _, x in members[:4])
                names_str = f"{shown} … +{n-4}"

            changed = any(
                round(x['w'],6) != round(x['w_orig'],6) or
                round(x['l'],6) != round(x['l_orig'],6)
                for _, x in members
            )
            if changed:
                mod_total += 1

            isPmos = "pmos" in t["mtype"]
            if changed:
                tag = "pmos_mod" if isPmos else "nmos_mod"
            else:
                tag = "pmos" if isPmos else "nmos"

            iid = self.tree.insert("", "end", tags=(tag,), values=(
                f"{n}×",
                names_str,
                "pmos" if isPmos else "nmos",
                f"{t['w']:.4g}",
                f"{t['l']:.4g}",
                t["gB"],
                t["dB"],
                t["sB"],
            ))
            # mapowanie iid → obiekt grupy (nie przez tagi!)
            self._iid_to_group[iid] = g

        n_grp = len(self.group_rows)
        n_all = len(self.groups)
        n_tr  = len(self.transistors)
        self._set_status(
            f"Widoczne: {n_grp} / {n_all} grup | "
            f"{n_tr} instancji | "
            f"Zmienione: {mod_total} grup | "
            f"Dwuklik = edycja W/L"
        )

    # ── edycja ────────────────────────────────────────────────────────────────
    def _on_double_click(self, event):
        sel = self.tree.selection()
        if not sel:
            return
        iid = sel[0]
        # pobierz grupę bezpośrednio ze słownika — żadnych tagów
        g = self._iid_to_group.get(iid)
        if not g:
            return
        self._edit_dialog(g)

    def _edit_dialog(self, g):
        t = g["members"][0][1]
        n = len(g["members"])
        names = ", ".join(x["name"] for _, x in g["members"])

        dlg = tk.Toplevel(self)
        dlg.title(f"Edycja grupy ({n}× finger)")
        dlg.configure(bg="#1e1e2e")
        dlg.resizable(False, False)
        dlg.grab_set()

        pad = dict(padx=12, pady=6)

        tk.Label(dlg, text=f"Fingery ({n}×):", bg="#1e1e2e", fg="#a6adc8",
                 font=("Segoe UI", 9)).grid(row=0, column=0, sticky="w", **pad)
        tk.Label(dlg, text=names, bg="#1e1e2e", fg="#cdd6f4",
                 font=("Courier New", 9), wraplength=400, justify="left"
                 ).grid(row=0, column=1, sticky="w", **pad)

        # info
        info = [
            ("Typ",    "pmos" if "pmos" in t["mtype"] else "nmos"),
            ("Gate",   t["gB"]),
            ("Drain",  t["dB"]),
            ("Source", t["sB"]),
            ("Bulk",   t["bB"]),
        ]
        for r, (lbl, val) in enumerate(info, start=1):
            tk.Label(dlg, text=f"{lbl}:", bg="#1e1e2e", fg="#a6adc8",
                     font=("Segoe UI", 9)).grid(row=r, column=0, sticky="w", **pad)
            tk.Label(dlg, text=val, bg="#1e1e2e", fg="#89dceb",
                     font=("Courier New", 10)).grid(row=r, column=1, sticky="w", **pad)

        sep = ttk.Separator(dlg, orient="horizontal")
        sep.grid(row=len(info)+1, column=0, columnspan=2, sticky="ew", pady=4)

        row_w = len(info) + 2
        tk.Label(dlg, text="W (µm):", bg="#1e1e2e", fg="#a6adc8",
                 font=("Segoe UI", 10, "bold")).grid(row=row_w, column=0, sticky="w", **pad)
        w_var = tk.StringVar(value=str(t["w"]))
        ent_w = tk.Entry(dlg, textvariable=w_var, width=14,
                         bg="#313244", fg="#a6e3a1", insertbackground="#cdd6f4",
                         font=("Courier New", 12), relief="flat", bd=6)
        ent_w.grid(row=row_w, column=1, sticky="w", **pad)
        tk.Label(dlg, text=f"  (oryginał: {t['w_orig']})", bg="#1e1e2e",
                 fg="#585b70", font=("Segoe UI", 9)).grid(row=row_w, column=2, sticky="w")

        row_l = row_w + 1
        tk.Label(dlg, text="L (µm):", bg="#1e1e2e", fg="#a6adc8",
                 font=("Segoe UI", 10, "bold")).grid(row=row_l, column=0, sticky="w", **pad)
        l_var = tk.StringVar(value=str(t["l"]))
        ent_l = tk.Entry(dlg, textvariable=l_var, width=14,
                         bg="#313244", fg="#a6e3a1", insertbackground="#cdd6f4",
                         font=("Courier New", 12), relief="flat", bd=6)
        ent_l.grid(row=row_l, column=1, sticky="w", **pad)
        tk.Label(dlg, text=f"  (oryginał: {t['l_orig']})", bg="#1e1e2e",
                 fg="#585b70", font=("Segoe UI", 9)).grid(row=row_l, column=2, sticky="w")

        self.err_var = tk.StringVar()
        tk.Label(dlg, textvariable=self.err_var, bg="#1e1e2e",
                 fg="#f38ba8", font=("Segoe UI", 9)
                 ).grid(row=row_l+1, column=0, columnspan=3, sticky="w", padx=12)

        def apply():
            try:
                new_w = float(w_var.get().replace(',', '.'))
                new_l = float(l_var.get().replace(',', '.'))
                if new_w <= 0 or new_l <= 0:
                    raise ValueError
            except ValueError:
                self.err_var.set("⚠  Podaj liczby > 0")
                return
            for _, mt in g["members"]:
                mt["w"] = new_w
                mt["l"] = new_l
            dlg.destroy()
            self._apply_filter()

        def reset_group():
            for _, mt in g["members"]:
                mt["w"] = mt["w_orig"]
                mt["l"] = mt["l_orig"]
            dlg.destroy()
            self._apply_filter()

        btn_frame = tk.Frame(dlg, bg="#1e1e2e")
        btn_frame.grid(row=row_l+2, column=0, columnspan=3, pady=10, padx=12, sticky="e")

        tk.Button(btn_frame, text="Zastosuj", command=apply,
                  bg="#a6e3a1", fg="#1e1e2e", relief="flat",
                  padx=12, pady=4, cursor="hand2"
                  ).pack(side="right", padx=(6,0))
        tk.Button(btn_frame, text="Reset grupy", command=reset_group,
                  bg="#fab387", fg="#1e1e2e", relief="flat",
                  padx=10, pady=4, cursor="hand2"
                  ).pack(side="right", padx=(6,0))
        tk.Button(btn_frame, text="Anuluj", command=dlg.destroy,
                  bg="#313244", fg="#cdd6f4", relief="flat",
                  padx=10, pady=4, cursor="hand2"
                  ).pack(side="right")

        ent_w.focus_set()
        ent_w.select_range(0, "end")
        dlg.bind("<Return>", lambda _: apply())
        dlg.bind("<Escape>", lambda _: dlg.destroy())

    def reset_all(self):
        if not messagebox.askyesno("Reset", "Cofnąć wszystkie zmiany W i L?"):
            return
        for _, t in self.transistors:
            t["w"] = t["w_orig"]
            t["l"] = t["l_orig"]
        self._apply_filter()
        self._set_status("Wszystkie zmiany cofnięte.")

    # ── helpers ───────────────────────────────────────────────────────────────
    def _set_status(self, msg):
        self.status_var.set(f"  {msg}")


# ── main ──────────────────────────────────────────────────────────────────────
if __name__ == "__main__":
    app = NetlistEditor()
    app.mainloop()
