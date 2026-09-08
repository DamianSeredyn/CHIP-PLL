import numpy as np
import control as ct

# ---- parametry ----
icp = 10E-6      # mozemy zmienic

gmv2i = 0.2E-3   # moze byc ciezko
kcco = 3.22E12   # moze byc ciezko
cvco = 40.6E-13  # mozemy zmienic
rvco = 756       # idk szczerze

N = 2432         # teoretycznie mozemy zmienic ale duzo pierdolenia sie

C1 = 10E-13      # cap filtr
C2 = 200E-13     # cap filtr, z razaviego c2>c1 nie pamietam czy nie c2>10c1
R2 = 100E3       # res filtr

A = icp * gmv2i * kcco
B = N * C1 * cvco * rvco

print(f"A = {A:g}")
print(f"B = {B:g}")
print(f"A/B = {A / B:g}")

z = -1 / (R2 * C2)                          # zero
p3 = -1 / (cvco * rvco)                     # biegun w chuj daleko, u nas chyba nic nie zmieni
p4 = -(C1 + C2) / (C1 * C2 * R2)            # biegun

print(f"z  = {z:g}")
print(f"p3 = {p3:g}")
print(f"p4 = {p4:g}")

# ---- transmitancja przeniesiona z obliczen z kartki ----
num = [A, A / (R2 * C2)]
den = [
    B,
    B * (C1 + C2) / (C1 * C2 * R2) + B / (cvco + rvco),
    B * (C1 + C2) / (cvco * rvco * C1 * C2 * R2),
    0,
    0,
]

H = ct.tf(num, den)
G = H / (1 + H)

print("\nH(s) =")
print(H)

# ---- marginesy stabilnosci ----
GM, PM, Wcg, Wcp = ct.margin(H)

print(f"\nGM  = {GM:g}  ({20*np.log10(GM):.3f} dB)")
print(f"PM  = {PM:.3f} deg")
print(f"Wcg = {Wcg:g} rad/s")
print(f"Wcp = {Wcp:g} rad/s")

# ---- pasmo (bandwidth) ukladu zamknietego ----
BW = ct.bandwidth(G)
print(f"bandwidth(G) = {BW:g} rad/s")

# ---- zapis wynikow do pliku (dopisywanie, tak jak w MATLABie) ----
with open('wyniki.txt', 'a') as fid:
    fid.write(
        "%g %g %g %g %g %g %g %g %g %.3f %.3f\n" % (
            C1, C2, R2, icp, gmv2i, kcco, cvco, rvco, N, PM, 20 * np.log10(GM)
        )
    )

print("\nZapisano wyniki do wyniki.txt")
