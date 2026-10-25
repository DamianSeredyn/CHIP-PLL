import numpy as np
import control as ct
import itertools
import sys
import time

# =========================================================
#                    ZAKRESY PRZEMIATANIA
# =========================================================
# Dwa sposoby definiowania zakresu:
#
#  A) KROKOWO:            ("step", start, stop, step)
#     np.arange(start, stop + step/2, step)   (stop wlaczony, jesli sie zgadza z krokiem)
#
#  B) LICZBA PUNKTOW:      ("n", start, stop, ile_punktow, skala)
#     skala: "lin" -> np.linspace, "log" -> np.logspace (start, stop > 0)
#
#  Pojedyncza (stala) wartosc: ("n", wartosc, wartosc, 1, "lin")  -> zwroci [wartosc]

def make_range(cfg):
    kind = cfg[0]
    if kind == "step":
        _, start, stop, step = cfg
        n = round((stop - start) / step)
        return start + step * np.arange(n + 1)
    elif kind == "n":
        _, start, stop, n, scale = cfg
        if n <= 1:
            return np.array([start])
        if scale == "log":
            return np.logspace(np.log10(start), np.log10(stop), n)
        return np.linspace(start, stop, n)
    else:
        raise ValueError(f"Nieznany typ zakresu: {kind}")


# --- WSPOLNE dla wszystkich VCO/N: caps filtr, res filtr, prad pompy ---
C1_CFG = ("step", 1E-12, 1000E-12, 10E-12)
C2_CFG = ("step", 1E-12, 1000E-12, 20E-12)
R2_CFG = ("step", 10E3, 100E3, 2E3)
icp_CFG = ("step", 0.5E-6, 10E-6, 0.25E-6)

C1_range   = make_range(C1_CFG)
C2_range   = make_range(C2_CFG)
R2_range   = make_range(R2_CFG)
icp_range  = make_range(icp_CFG)

# co ile iteracji drukowac PELNY, szczegolowy postep na ekranie (samo
# drukowanie kosztuje czas przy duzej liczbie kombinacji, wiec przy
# milionach lepiej rzadziej)
PRINT_EVERY = 500

# czy pokazywac zywy, nadpisywany pasek postepu co KAZDA iteracje (True),
# czy tylko rzadkie, pelne printy co PRINT_EVERY (False). Wylacz, jesli
# przekierowujesz output do pliku logu (\r nie dziala ladnie w plikach).
LIVE_PROGRESS = True

# =========================================================
#         PARAMETRY VCO W ZALEZNOSCI OD DZIELNIKA N
# =========================================================
# Kazdy klucz to wartosc N (dzielnik w petli). Kazdemu N odpowiada
# INNY fizyczny VCO/ICO w ukladzie, wiec parametry VCO sa deklarowane
# tutaj OSOBNO dla kazdego N. C1, C2, R2, icp (wyzej) sa WSPOLNE dla
# wszystkich VCO - przemiatane tak samo niezaleznie od N.
#
# Dopisuj kolejne N-y i ich parametry ponizej wedlug potrzeb - slownik
# jest calkowicie otwarty, moze byc 2, 5, czy 10 wpisow.
#
#   gmv2i - transkonduktancja V2I               [A/V]
#   kcco  - wzmocnienie VCO/ICO                  [rad/s na A]
#   cvco  - pasozytnicza pojemnosc wewnatrz VCO   [F]
#   rvco  - pasozytnicza rezystancja wewnatrz VCO [Ohm]

VCO_PARAMS = {
    2432: { #VCO_0
        "gmv2i": 0.2E-3,
        "kcco":  3.22E12,
        "cvco":  40.6E-13,
        "rvco":  756,
    },
    304: { # 14M-82 VCO_1
        "gmv2i": 0.03E-3,   
        "kcco":  1.69E12,   
        "cvco":  228.0E-13,  
        "rvco":  4050,       
    },
    200: { # 14M-82M VCO_2
        "gmv2i": 0.07E-3,    
        "kcco":  0.806E12,   
        "cvco":  735.0E-13,  
        "rvco":  19000,           
    },
    15: { # VCO_3
        "gmv2i": 0.001E-3,    
        "kcco":  0.209E12,   
        "cvco":  2.29E-10,  
        "rvco":  71E3,       
    },
    2: { # VCO_4
        "gmv2i": 0.0009E-3,    
        "kcco":  0.186E12,   
        "cvco":  3.78E-10,  
        "rvco":  137E3,       
    }
    # dopisz kolejne N-y tutaj, np.:
    # 1216: {"gmv2i": ..., "kcco": ..., "cvco": ..., "rvco": ...},
}

N_LIST = list(VCO_PARAMS.keys())

# =========================================================
#              KRYTERIUM "DOBRY" WYNIK (STABILNY)
# =========================================================
# Kombinacja jest uznawana za "dobra", jesli oba warunki sa spelnione:
#   PM  > PM_MIN_DEG
#   GM  > GM_MIN_DB
PM_MIN_DEG = 20
GM_MIN_DB  = 0

# minimalny stosunek C2/C1 (typowe zalecenie Razaviego: C2 >= 10*C1)
C2_MIN_RATIO = 10

OUT_FILE_GOOD   = 'wyniki_dobre.txt'          # PM i GM spelniaja kryterium (per N, osobne wiersze)
OUT_FILE_BAD    = 'wyniki_zle.txt'            # niestabilne / graniczne / nan / blad (per N)
OUT_FILE_ALL_OK = 'wyniki_wszystkie_n_ok.txt' # (C1,C2,R2,icp) stabilne dla KAZDEGO N naraz


def analyze(C1, C2, R2, icp, gmv2i, kcco, cvco, rvco, N):
    """Liczy H(s), G(s), marginesy stabilnosci i pasmo dla zadanych parametrow.
    Zwraca dict z wynikami albo None, jesli cos sie wywali (np. niestabilny uklad)."""

    A = icp * gmv2i * kcco
    B = N * C1 * cvco * rvco

    z  = -1 / (R2 * C2)
    p3 = -1 / (cvco * rvco)
    p4 = -(C1 + C2) / (C1 * C2 * R2)

    num = [A, A / (R2 * C2)]
    den = [
        B,
        B * (C1 + C2) / (C1 * C2 * R2) + B / (cvco + rvco),
        B * (C1 + C2) / (cvco * rvco * C1 * C2 * R2),
        0,
        0,
    ]

    try:
        H = ct.tf(num, den)
        G = H / (1 + H)

        GM, PM, Wcg, Wcp = ct.margin(H)
        BW = ct.bandwidth(G)
    except Exception as e:
        print(f"  [BLAD] C1={C1:g} C2={C2:g} R2={R2:g} icp={icp:g} "
              f"cvco={cvco:g} rvco={rvco:g} N={N} -> {e}")
        return None

    return {
        "A": A, "B": B, "z": z, "p3": p3, "p4": p4,
        "GM": GM, "PM": PM, "Wcg": Wcg, "Wcp": Wcp, "BW": BW,
    }


def main():
    total_all = (len(C1_range) * len(C2_range) * len(R2_range)
                 * len(icp_range) * len(N_LIST))

    n_c1c2_valid = sum(1 for c1 in C1_range for c2 in C2_range if c2 >= C2_MIN_RATIO * c1)
    total_base = n_c1c2_valid * len(R2_range) * len(icp_range)
    total = total_base * len(N_LIST)
    n_skipped_ratio_total = total_all - total

    print(f"Rozmiary zakresow: C1={len(C1_range)} C2={len(C2_range)} "
          f"R2={len(R2_range)} icp={len(icp_range)}")
    print(f"Dzielniki N (VCO): {N_LIST}")
    for n_val, p in VCO_PARAMS.items():
        print(f"  N={n_val}: gmv2i={p['gmv2i']:g} kcco={p['kcco']:g} "
              f"cvco={p['cvco']:g} rvco={p['rvco']:g}")
    print(f"Wszystkich kombinacji (C1 x C2 x ... x N): {total_all:,}".replace(",", " "))
    print(f"Kombinacji po filtrze C2 >= {C2_MIN_RATIO}*C1: {total:,}".replace(",", " ")
          + f"  (pominietych: {n_skipped_ratio_total:,})".replace(",", " "))

    # szybki pomiar czasu jednej iteracji, zeby oszacowac calosc
    n0 = N_LIST[0]
    p0 = VCO_PARAMS[n0]
    t0 = time.perf_counter()
    analyze(C1_range[0], C2_range[-1], R2_range[0], icp_range[0],
             p0["gmv2i"], p0["kcco"], p0["cvco"], p0["rvco"], n0)
    dt = time.perf_counter() - t0
    est_sec = dt * total
    print(f"Szacowany czas: ~{est_sec:.1f} s (~{est_sec/60:.1f} min, "
          f"~{est_sec/3600:.2f} h) przy {dt*1000:.2f} ms/iteracje\n")

    combos_base = itertools.product(C1_range, C2_range, R2_range, icp_range)

    n_good = 0
    n_bad = 0
    n_err = 0
    n_skipped_ratio = 0
    n_all_ok = 0
    i = 0  # licznik FAKTYCZNIE policzonych (C1,C2,R2,icp,N) kombinacji
    t_start = time.perf_counter()

    header = ("# C1 C2 R2 icp gmv2i kcco cvco rvco N PM[deg] GM[dB] BW[rad/s] stabilny\n")
    header_allok = ("# C1 C2 R2 icp " +
                     " ".join(f"PM_N{n}[deg] GM_N{n}[dB] BW_N{n}[rad/s]" for n in N_LIST) + "\n")

    with open(OUT_FILE_GOOD, 'a') as fid_good, \
         open(OUT_FILE_BAD, 'a') as fid_bad, \
         open(OUT_FILE_ALL_OK, 'a') as fid_allok:

        if fid_good.tell() == 0:
            fid_good.write(header)
        if fid_bad.tell() == 0:
            fid_bad.write(header)
        if fid_allok.tell() == 0:
            fid_allok.write(header_allok)

        for C1, C2, R2, icp in combos_base:

            # --- filtr: pomijamy kombinacje gdzie C2 nie jest co najmniej
            # C2_MIN_RATIO razy wieksze od C1 (nie liczymy dla zadnego N) ---
            if C2 < C2_MIN_RATIO * C1:
                n_skipped_ratio += len(N_LIST)
                continue

            per_n = {}  # N -> {"PM":..., "GM_db":..., "BW":..., "stabilny":bool}

            for N in N_LIST:
                p = VCO_PARAMS[N]
                gmv2i, kcco, cvco, rvco = p["gmv2i"], p["kcco"], p["cvco"], p["rvco"]

                i += 1

                res = analyze(C1, C2, R2, icp, gmv2i, kcco, cvco, rvco, N)

                if res is None:
                    n_err += 1
                    n_bad += 1
                    fid_bad.write(
                        "%g %g %g %g %g %g %g %g %g nan nan nan 0\n" % (
                            C1, C2, R2, icp, gmv2i, kcco, cvco, rvco, N
                        )
                    )
                    per_n[N] = {"PM": float('nan'), "GM_db": float('nan'),
                                "BW": float('nan'), "stabilny": False}
                else:
                    GM, PM, BW = res["GM"], res["PM"], res["BW"]
                    GM_valid = GM not in (0, None) and not np.isnan(GM)
                    GM_db = 20 * np.log10(GM) if GM_valid else float('nan')
                    PM_valid = PM is not None and not np.isnan(PM)

                    stabilny = bool(
                        PM_valid and GM_valid
                        and PM > PM_MIN_DEG and GM_db > GM_MIN_DB
                    )

                    line = "%g %g %g %g %g %g %g %g %g %.3f %.3f %g %d\n" % (
                        C1, C2, R2, icp, gmv2i, kcco, cvco, rvco, N,
                        PM if PM_valid else float('nan'),
                        GM_db, BW, int(stabilny),
                    )

                    if stabilny:
                        fid_good.write(line)
                        n_good += 1
                    else:
                        fid_bad.write(line)
                        n_bad += 1

                    per_n[N] = {"PM": PM if PM_valid else float('nan'),
                                "GM_db": GM_db, "BW": BW, "stabilny": stabilny}

                if LIVE_PROGRESS:
                    elapsed_live = time.perf_counter() - t_start
                    rate_live = i / elapsed_live if elapsed_live > 0 else 0
                    cur = per_n[N]
                    sys.stdout.write(
                        f"\r  [{i}/{total}] ({100*i/total:5.1f}%) N={N:<6} "
                        f"PM={cur['PM']:7.3f} deg  GM={cur['GM_db']:8.3f} dB  "
                        f"[{'OK ' if cur['stabilny'] else 'zle'}]  "
                        f"{rate_live:.0f} it/s   "
                    )
                    sys.stdout.flush()

                if i % PRINT_EVERY == 0 or i == total:
                    elapsed = time.perf_counter() - t_start
                    rate = i / elapsed if elapsed > 0 else 0
                    eta = (total - i) / rate if rate > 0 else float('nan')
                    prefix = "\n" if LIVE_PROGRESS else ""
                    cur = per_n[N]
                    print(f"{prefix}[{i}/{total}] ({100*i/total:.1f}%) "
                          f"C1={C1:g} C2={C2:g} R2={R2:g} icp={icp:g} N={N} "
                          f"-> PM={cur['PM']:.3f} deg, GM={cur['GM_db']:.3f} dB "
                          f"[{'OK' if cur['stabilny'] else 'zle'}] | "
                          f"elapsed={elapsed:.1f}s ETA={eta:.1f}s "
                          f"dobre={n_good} zle={n_bad} wszystkieN_ok={n_all_ok}")

            # --- po policzeniu WSZYSTKICH N dla tego (C1,C2,R2,icp): ---
            if all(per_n[N]["stabilny"] for N in N_LIST):
                vals = [C1, C2, R2, icp]
                for N in N_LIST:
                    r = per_n[N]
                    vals += [r["PM"], r["GM_db"], r["BW"]]
                fid_allok.write(" ".join(f"{v:.6g}" for v in vals) + "\n")
                n_all_ok += 1

    print(f"\nDobre (stabilne, pojedynczy N): {n_good} / {total}  -> {OUT_FILE_GOOD}")
    print(f"Zle (niestabilne/blad, pojedynczy N): {n_bad} / {total}  -> {OUT_FILE_BAD}  (bledy: {n_err})")
    print(f"Stabilne dla WSZYSTKICH N naraz: {n_all_ok} / {total_base}  -> {OUT_FILE_ALL_OK}")
    print(f"Pominietych przez filtr C2 < {C2_MIN_RATIO}*C1: {n_skipped_ratio}")
    print(f"Kryterium 'dobry': PM > {PM_MIN_DEG} deg  ORAZ  GM > {GM_MIN_DB} dB")
    print("Kolumny w plikach dobre/zle: C1 C2 R2 icp gmv2i kcco cvco rvco N PM[deg] GM[dB] BW[rad/s] stabilny(0/1)")


if __name__ == "__main__":
    main()
