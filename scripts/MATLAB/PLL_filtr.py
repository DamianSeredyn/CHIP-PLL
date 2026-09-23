import numpy as np
import control as ct
import itertools

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


# --- caps filtr: 1p do 25p co 1p ---
C1_CFG = ("step", 1E-12, 25E-12, 1E-12)
C2_CFG = ("step", 1E-12, 25E-12, 1E-12)

# --- res filtr: 1k do 20k co 1000 Ohm ---
R2_CFG = ("step", 1E3, 20E3, 1E3)

# --- prad pompy ladunkowej: 0.5u do 7.5u co 0.25u ---
icp_CFG = ("step", 0.5E-6, 7.5E-6, 0.25E-6)

# --- reszta na razie przemiatana tylko raz (stala wartosc) ---
cvco_CFG = ("n", 40.6E-13, 40.6E-13, 1, "lin")   # mozemy zmienic (na razie stale)
rvco_CFG = ("n", 756,      756,      1, "lin")   # idk szczerze (na razie stale)

C1_range   = make_range(C1_CFG)
C2_range   = make_range(C2_CFG)
R2_range   = make_range(R2_CFG)
icp_range  = make_range(icp_CFG)
cvco_range = make_range(cvco_CFG)
rvco_range = make_range(rvco_CFG)

# co ile iteracji drukowac postep na ekranie (samo drukowanie kosztuje czas
# przy duzej liczbie kombinacji, wiec przy milionach lepiej rzadziej)
PRINT_EVERY = 500

# =========================================================
#                 PARAMETRY STALE (bez zmian)
# =========================================================
gmv2i = 0.2E-3   # moze byc ciezko
kcco  = 3.22E12  # moze byc ciezko
N     = 2432     # teoretycznie mozemy zmienic ale duzo pierdolenia sie

OUT_FILE = 'wyniki.txt'


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
              f"cvco={cvco:g} rvco={rvco:g} -> {e}")
        return None

    return {
        "A": A, "B": B, "z": z, "p3": p3, "p4": p4,
        "GM": GM, "PM": PM, "Wcg": Wcg, "Wcp": Wcp, "BW": BW,
    }


def main():
    import time

    total = (len(C1_range) * len(C2_range) * len(R2_range)
              * len(icp_range) * len(cvco_range) * len(rvco_range))

    print(f"Rozmiary zakresow: C1={len(C1_range)} C2={len(C2_range)} "
          f"R2={len(R2_range)} icp={len(icp_range)} "
          f"cvco={len(cvco_range)} rvco={len(rvco_range)}")
    print(f"Liczba kombinacji do policzenia: {total:,}".replace(",", " "))

    # szybki pomiar czasu jednej iteracji, zeby oszacowac calosc
    t0 = time.perf_counter()
    analyze(C1_range[0], C2_range[0], R2_range[0],
             icp_range[0], gmv2i, kcco, cvco_range[0], rvco_range[0], N)
    dt = time.perf_counter() - t0
    est_sec = dt * total
    print(f"Szacowany czas: ~{est_sec:.1f} s (~{est_sec/60:.1f} min, "
          f"~{est_sec/3600:.2f} h) przy {dt*1000:.2f} ms/iteracje\n")

    combos = itertools.product(
        C1_range, C2_range, R2_range, icp_range, cvco_range, rvco_range
    )

    n_ok = 0
    n_err = 0
    t_start = time.perf_counter()

    with open(OUT_FILE, 'a') as fid:
        for i, (C1, C2, R2, icp, cvco, rvco) in enumerate(combos, start=1):

            res = analyze(C1, C2, R2, icp, gmv2i, kcco, cvco, rvco, N)
            if res is None:
                n_err += 1
                continue

            GM, PM, BW = res["GM"], res["PM"], res["BW"]
            GM_db = 20 * np.log10(GM) if GM not in (0, None) and not np.isnan(GM) else float('nan')

            fid.write(
                "%g %g %g %g %g %g %g %g %g %.3f %.3f %g\n" % (
                    C1, C2, R2, icp, gmv2i, kcco, cvco, rvco, N, PM, GM_db, BW
                )
            )
            n_ok += 1

            if i % PRINT_EVERY == 0 or i == total:
                elapsed = time.perf_counter() - t_start
                rate = i / elapsed if elapsed > 0 else 0
                eta = (total - i) / rate if rate > 0 else float('nan')
                print(f"[{i}/{total}] ({100*i/total:.1f}%) "
                      f"C1={C1:g} C2={C2:g} R2={R2:g} icp={icp:g} "
                      f"-> PM={PM:.3f} deg, GM={GM_db:.3f} dB | "
                      f"elapsed={elapsed:.1f}s ETA={eta:.1f}s")

    print(f"\nZapisano {n_ok} / {total} wynikow do {OUT_FILE} (bledy: {n_err})")
    print("Kolumny w pliku: C1 C2 R2 icp gmv2i kcco cvco rvco N PM[deg] GM[dB] BW[rad/s]")


if __name__ == "__main__":
    main()

