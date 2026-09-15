"""
Sprawdza, czy srodowisko jest gotowe do odpalenia sweep_pll.py na serwerze:
- czy biblioteki sa zainstalowane i w jakiej wersji
- czy da sie policzyc jedna probna kombinacje (control dziala poprawnie)
- czy da sie zapisac plik wynikowy w tym katalogu
- ile jest wolnego miejsca na dysku

Uruchomienie:
    python3 check_env.py
"""

import sys
import os
import shutil

OK = "[OK]"
FAIL = "[BLAD]"

problems = []

# ---------------------------------------------------------
# 1. Wersja Pythona
# ---------------------------------------------------------
print(f"{OK} Python {sys.version.split()[0]} ({sys.executable})")

# ---------------------------------------------------------
# 2. Wymagane biblioteki
# ---------------------------------------------------------
def check_import(modname, pip_name=None):
    pip_name = pip_name or modname
    try:
        mod = __import__(modname)
        ver = getattr(mod, "__version__", "brak wersji")
        print(f"{OK} {modname} zainstalowany (wersja: {ver})")
        return mod
    except ImportError as e:
        print(f"{FAIL} brak modulu '{modname}' -> zainstaluj: pip install {pip_name}")
        problems.append(f"brak {modname}")
        return None


np = check_import("numpy")
ct = check_import("control", pip_name="control")

if ct is not None:
    try:
        import scipy
        print(f"{OK} scipy zainstalowany (wersja: {scipy.__version__}) "
              f"[wymagany przez pakiet control]")
    except ImportError:
        print(f"{FAIL} brak scipy -> zainstaluj: pip install scipy")
        problems.append("brak scipy")

# ---------------------------------------------------------
# 3. Testowe obliczenie ukladu (czy control faktycznie dziala)
# ---------------------------------------------------------
if np is not None and ct is not None:
    try:
        icp, gmv2i, kcco, cvco, rvco, N = 10E-6, 0.2E-3, 3.22E12, 40.6E-13, 756, 2432
        C1, C2, R2 = 10E-12, 200E-12, 100E3

        A = icp * gmv2i * kcco
        B = N * C1 * cvco * rvco
        num = [A, A / (R2 * C2)]
        den = [
            B,
            B * (C1 + C2) / (C1 * C2 * R2) + B / (cvco + rvco),
            B * (C1 + C2) / (cvco * rvco * C1 * C2 * R2),
            0,
            0,
        ]
        H = ct.tf(num, den)
        GM, PM, Wcg, Wcp = ct.margin(H)
        print(f"{OK} testowe obliczenie H(s) i margin() dziala "
              f"(PM={PM:.2f} deg, GM={20*np.log10(GM):.2f} dB)")
    except Exception as e:
        print(f"{FAIL} obliczenie testowe nie dziala -> {e}")
        problems.append("blad obliczen control/numpy")

# ---------------------------------------------------------
# 4. Zapis do pliku w biezacym katalogu
# ---------------------------------------------------------
test_file = "._write_test.tmp"
try:
    with open(test_file, "w") as f:
        f.write("test\n")
    os.remove(test_file)
    print(f"{OK} zapis/odczyt plikow w katalogu '{os.getcwd()}' dziala")
except Exception as e:
    print(f"{FAIL} nie mozna zapisac pliku w '{os.getcwd()}' -> {e}")
    problems.append("brak uprawnien do zapisu")

# ---------------------------------------------------------
# 5. Wolne miejsce na dysku
# ---------------------------------------------------------
try:
    total, used, free = shutil.disk_usage(".")
    free_gb = free / 1e9
    print(f"{OK} wolne miejsce na dysku: {free_gb:.1f} GB")
    if free_gb < 1:
        print(f"{FAIL} mniej niz 1 GB wolnego miejsca - uwazaj przy duzych sweepach")
        problems.append("malo miejsca na dysku")
except Exception as e:
    print(f"{FAIL} nie udalo sie sprawdzic miejsca na dysku -> {e}")

# ---------------------------------------------------------
# 6. Czy istnieje juz stary wyniki.txt (ostrzezenie o dopisywaniu)
# ---------------------------------------------------------
if os.path.exists("wyniki.txt"):
    size_mb = os.path.getsize("wyniki.txt") / 1e6
    print(f"[UWAGA] plik 'wyniki.txt' juz istnieje ({size_mb:.2f} MB) - "
          f"sweep_pll.py DOPISUJE do niego, a nie nadpisuje. "
          f"Usun go recznie, jesli chcesz czysty start:  rm wyniki.txt")

# ---------------------------------------------------------
# Podsumowanie
# ---------------------------------------------------------
print("\n" + "=" * 50)
if problems:
    print(f"ZNALEZIONO PROBLEMY ({len(problems)}):")
    for p in problems:
        print(f"  - {p}")
    print("Napraw powyzsze przed odpaleniem sweep_pll.py na serwerze.")
    sys.exit(1)
else:
    print("Wszystko wyglada OK - mozna odpalac sweep_pll.py.")
    sys.exit(0)
