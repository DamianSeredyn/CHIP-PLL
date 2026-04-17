v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 140 -350 140 -330 {lab=#net1}
N 140 -250 140 -240 {lab=vbias}
N 140 -140 140 -120 {lab=#net2}
N 80 -90 100 -90 {lab=#net2}
N 80 -140 80 -90 {lab=#net2}
N 80 -140 140 -140 {lab=#net2}
N 140 -180 140 -140 {lab=#net2}
N 80 -210 100 -210 {lab=#net1}
N 80 -350 80 -210 {lab=#net1}
N 80 -350 140 -350 {lab=#net1}
N 140 -370 140 -350 {lab=#net1}
N 140 -250 280 -250 {lab=vbias}
N 140 -270 140 -250 {lab=vbias}
N 140 -210 150 -210 {lab=gd}
N 140 -90 150 -90 {lab=gd}
N 270 -850 270 -810 {lab=vp}
N 430 -850 430 -810 {lab=vp}
N 270 -850 430 -850 {lab=vp}
N 270 -730 270 -670 {lab=iref}
N 430 -690 430 -670 {lab=#net3}
N 270 -610 270 -550 {lab=#net4}
N 330 -780 390 -780 {lab=iref}
N 370 -640 390 -640 {lab=#net3}
N 270 -730 330 -730 {lab=iref}
N 270 -750 270 -730 {lab=iref}
N 330 -780 330 -730 {lab=iref}
N 310 -780 330 -780 {lab=iref}
N 270 -490 270 -450 {lab=gd}
N 270 -450 430 -450 {lab=gd}
N 430 -610 430 -450 {lab=gd}
N 370 -690 370 -640 {lab=#net3}
N 310 -640 370 -640 {lab=#net3}
N 370 -690 430 -690 {lab=#net3}
N 430 -750 430 -690 {lab=#net3}
N 260 -780 270 -780 {lab=vp}
N 430 -780 440 -780 {lab=vp}
N 430 -640 440 -640 {lab=gd}
N 260 -640 270 -640 {lab=gd}
N 180 -400 200 -400 {lab=iref}
N 140 -450 140 -430 {lab=vp}
N 130 -400 140 -400 {lab=vp}
N 130 -450 130 -400 {lab=vp}
N 130 -450 140 -450 {lab=vp}
N 140 -480 140 -450 {lab=vp}
C {sg13g2_pr/sg13_lv_nmos.sym} 120 -90 0 0 {name=M16
l=0.3u
w=1.8u
ng=1
m=6
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 120 -210 0 0 {name=M1
l=0.3u
w=1.8u
ng=1
m=6
model=sg13_lv_nmos
spiceprefix=X
}
C {res.sym} 140 -300 0 0 {name=R1
value=1k
footprint=1206
device=resistor
m=1}
C {gnd.sym} 140 -60 0 0 {name=l1 lab=0}
C {sg13g2_pr/sg13_lv_pmos.sym} 290 -780 0 1 {name=M5
l=0.15u
w=2.35u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 410 -780 0 0 {name=M6
l=0.15u
w=2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 290 -640 0 1 {name=M7
l=0.15u
w=1.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 410 -640 0 0 {name=M8
l=0.15u
w=2.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {res.sym} 270 -520 0 0 {name=R3
value=500
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 260 -780 0 0 {name=p8 sig_type=std_logic lab=vp}
C {lab_pin.sym} 440 -780 0 1 {name=p9 sig_type=std_logic lab=vp}
C {lab_pin.sym} 440 -640 0 1 {name=p10 sig_type=std_logic lab=gd}
C {lab_pin.sym} 260 -640 0 0 {name=p11 sig_type=std_logic lab=gd}
C {lab_pin.sym} 330 -730 0 1 {name=p15 sig_type=std_logic lab=iref}
C {sg13g2_pr/sg13_lv_pmos.sym} 160 -400 0 1 {name=M10
l=0.15u
w=2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 140 -480 0 1 {name=p16 sig_type=std_logic lab=vp}
C {lab_pin.sym} 200 -400 0 1 {name=p17 sig_type=std_logic lab=iref}
C {iopin.sym} 290 -850 0 0 {name=p28 lab=vp}
C {iopin.sym} 280 -450 0 0 {name=p6 lab=gd}
C {opin.sym} 280 -250 0 0 {name=p7 lab=vbias}
C {lab_pin.sym} 150 -210 0 1 {name=p4 sig_type=std_logic lab=gd}
C {lab_pin.sym} 150 -90 0 1 {name=p12 sig_type=std_logic lab=gd}
