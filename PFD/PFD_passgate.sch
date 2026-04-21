v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -130 -100 -30 -100 {lab=A}
N -130 -20 -130 80 {lab=A}
N -130 80 -30 80 {lab=A}
N 30 80 100 80 {lab=B}
N 100 -10 100 80 {lab=B}
N 30 -100 100 -100 {lab=B}
N 100 -10 150 -10 {lab=B}
N 100 -100 100 -10 {lab=B}
N -170 -20 -130 -20 {lab=A}
N -130 -100 -130 -20 {lab=A}
N -0 120 0 160 {lab=in_n}
N -0 -180 -0 -140 {lab=in_n}
N 0 30 0 80 {lab=gnd}
N -0 -100 0 -50 {lab=vp}
C {sg13g2_pr/sg13_lv_pmos.sym} 0 -120 3 1 {name=M4
l=0.15u
w=0.9u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 0 100 1 1 {name=M5
l=0.15u
w=0.9u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {ipin.sym} -170 -20 0 0 {name=p5 lab=A}
C {ipin.sym} -170 -20 0 0 {name=p1 lab=A}
C {ipin.sym} 150 -10 0 1 {name=p2 lab=B}
C {ipin.sym} -170 -20 0 0 {name=p3 lab=A}
C {ipin.sym} 0 160 0 0 {name=p4 lab=in_n}
C {ipin.sym} 0 -180 0 0 {name=p6 lab=in_p}
C {iopin.sym} 0 -50 0 0 {name=p7 lab=vp
}
C {iopin.sym} 0 30 0 0 {name=p8 lab=gnd}
