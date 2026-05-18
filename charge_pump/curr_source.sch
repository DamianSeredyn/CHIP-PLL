v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 160 -480 160 -440 {lab=vp}
N 320 -480 320 -440 {lab=vp}
N 160 -480 320 -480 {lab=vp}
N 160 -360 160 -300 {lab=iref}
N 320 -320 320 -300 {lab=#net1}
N 160 -240 160 -180 {lab=#net2}
N 220 -410 280 -410 {lab=iref}
N 260 -270 280 -270 {lab=#net1}
N 160 -360 220 -360 {lab=iref}
N 160 -380 160 -360 {lab=iref}
N 220 -410 220 -360 {lab=iref}
N 200 -410 220 -410 {lab=iref}
N 160 -120 160 -80 {lab=gd}
N 160 -80 320 -80 {lab=gd}
N 320 -240 320 -80 {lab=gd}
N 260 -320 260 -270 {lab=#net1}
N 200 -270 260 -270 {lab=#net1}
N 260 -320 320 -320 {lab=#net1}
N 320 -380 320 -320 {lab=#net1}
N 150 -410 160 -410 {lab=vp}
N 320 -410 330 -410 {lab=vp}
N 320 -270 330 -270 {lab=gd}
N 150 -270 160 -270 {lab=gd}
C {sg13g2_pr/sg13_lv_pmos.sym} 180 -410 0 1 {name=M4
l=0.15u
w=2.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 300 -410 0 0 {name=M5
l=0.15u
w=2.5u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 180 -270 0 1 {name=M6
l=0.15u
w=3u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 300 -270 0 0 {name=M7
l=0.15u
w=2.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {res.sym} 160 -150 0 0 {name=R2
value=500
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 150 -410 0 0 {name=p7 sig_type=std_logic lab=vp}
C {lab_pin.sym} 330 -410 0 1 {name=p8 sig_type=std_logic lab=vp}
C {lab_pin.sym} 330 -270 0 1 {name=p9 sig_type=std_logic lab=gd}
C {lab_pin.sym} 150 -270 0 0 {name=p10 sig_type=std_logic lab=gd}
C {iopin.sym} 180 -480 0 0 {name=p28 lab=vp}
C {iopin.sym} 180 -80 0 0 {name=p29 lab=gd}
C {opin.sym} 220 -360 0 0 {name=p1 lab=iref}
