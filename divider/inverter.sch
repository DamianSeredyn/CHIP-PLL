v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -10 -40 -10 -20 {lab=#net1}
N -80 10 -50 10 {lab=#net2}
N -80 -70 -80 10 {lab=#net2}
N -80 -70 -50 -70 {lab=#net2}
N -10 -70 20 -70 {lab=#net3}
N 20 -110 20 -70 {lab=#net3}
N -10 -110 20 -110 {lab=#net3}
N -10 -110 -10 -100 {lab=#net3}
N -10 40 -10 50 {lab=#net4}
N -10 50 20 50 {lab=#net4}
N 20 10 20 50 {lab=#net4}
N -10 10 20 10 {lab=#net4}
C {sg13g2_pr/sg13_lv_nmos.sym} -30 10 0 0 {name=M1
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -30 -70 0 0 {name=M2
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} -100 -30 0 0 {name=p1 sig_type=std_logic lab=xxx}
