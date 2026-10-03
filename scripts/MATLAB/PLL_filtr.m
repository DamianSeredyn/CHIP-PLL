close all
clear all

icp=10E-6 % mozemy zmienic

gmv2i=0.2E-3 % moze byc ciezko
kcco=3.22E12 % moze byc ciezko
cvco=40.6E-13 % mozemy zmienic
rvco=756 % idk szczerze

N=2432 % teoretycznie mozemy zmienic ale duzo pierdolenia sie


C1=10E-13 % cap filtr 
C2=200E-13 % cap filtr, z razaviego c2>c1 nie pamietam czy nie c2>10c1
R2=100E3 % res filtr

A=icp.*gmv2i.*kcco 
B=N.*C1.*cvco.*rvco
A/B

z=-1./(R2.*C2) % zero
p3=-1./(cvco.*rvco) % biegun w chuj daleko, u nas chyba nic nie zmieni
p4=-(C1+C2)./(C1.*C2.*R2) % biegun

H=tf([A A./(R2.*C2)] ,[B B.*(C1+C2)./(C1.*C2.*R2)+B./(cvco+rvco) B.*(C1+C2)./(cvco.*rvco.*C1.*C2.*R2) 0 0]) % transmitancja przeniesiona z obliczen z kartki

G=H/(1+H)


bode(H, {1E7.*2.*pi, 1E10.*2.*pi})

[GM, PM, Wcg, Wcp] = margin(H)

margin(H)
bandwidth(G)


% Zapis wynikow do pliku

fid = fopen('wyniki.txt', 'a');

fprintf(fid, '%g %g %g %g %g %g %g %g %g %.3f %.3f\n', ...
    C1, C2, R2, icp, gmv2i, kcco, cvco, rvco, N, PM, 20*log10(GM));

fclose(fid);