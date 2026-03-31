v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
P 4 1 180 -110 {}
N 50 -70 50 -40 {lab=OUT}
N 50 -70 130 -70 {lab=OUT}
N 50 -90 50 -70 {lab=OUT}
N 50 -190 50 -150 {lab=VP}
N 50 -120 90 -120 {lab=VP}
N 50 -10 80 -10 {lab=GND}
N -30 -120 10 -120 {lab=IN}
N -30 -10 10 -10 {lab=IN}
N 50 50 50 80 {lab=GND}
N 80 -10 80 50 {lab=GND}
N 50 50 80 50 {lab=GND}
N 50 20 50 50 {lab=GND}
N 90 -190 90 -120 {lab=VP}
N 50 -190 90 -190 {lab=VP}
N -30 -70 -30 -10 {lab=IN}
N -50 -70 -30 -70 {lab=IN}
N -30 -120 -30 -70 {lab=IN}
N 50 -230 50 -190 {lab=VP}
C {sg13g2_pr/sg13_lv_rf_nmos.sym} 30 -10 0 0 {name=M1
l=0.13u
w=0.15u
ng=1
m=1
rfmode=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 30 -120 0 0 {name=M2
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {iopin.sym} 50 -230 0 0 {name=p1 lab=VP
}
C {iopin.sym} 50 80 0 0 {name=p2 lab=GND
}
C {ipin.sym} -50 -70 0 0 {name=p3 lab=IN
}
C {opin.sym} 130 -70 0 0 {name=p4 lab=OUT

}
