v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 170 -350 170 -330 {lab=#net1}
N 170 -250 170 -240 {lab=vbias}
N 170 -140 170 -120 {lab=#net2}
N 110 -90 130 -90 {lab=#net2}
N 110 -140 110 -90 {lab=#net2}
N 110 -140 170 -140 {lab=#net2}
N 170 -180 170 -140 {lab=#net2}
N 110 -210 130 -210 {lab=#net1}
N 110 -350 110 -210 {lab=#net1}
N 110 -350 170 -350 {lab=#net1}
N 170 -370 170 -350 {lab=#net1}
N 170 -250 310 -250 {lab=vbias}
N 170 -270 170 -250 {lab=vbias}
N 170 -210 180 -210 {lab=gd}
N 170 -90 180 -90 {lab=gd}
N 300 -850 300 -810 {lab=vp}
N 460 -850 460 -810 {lab=vp}
N 300 -850 460 -850 {lab=vp}
N 460 -690 460 -670 {lab=#net3}
N 300 -610 300 -550 {lab=#net4}
N 360 -780 420 -780 {lab=iref}
N 400 -640 420 -640 {lab=#net3}
N 300 -730 360 -730 {lab=iref}
N 300 -750 300 -730 {lab=iref}
N 360 -780 360 -730 {lab=iref}
N 340 -780 360 -780 {lab=iref}
N 300 -490 300 -450 {lab=gd}
N 300 -450 460 -450 {lab=gd}
N 460 -610 460 -450 {lab=gd}
N 400 -690 400 -640 {lab=#net3}
N 340 -640 400 -640 {lab=#net3}
N 400 -690 460 -690 {lab=#net3}
N 460 -750 460 -690 {lab=#net3}
N 290 -780 300 -780 {lab=vp}
N 460 -780 470 -780 {lab=vp}
N 460 -640 470 -640 {lab=gd}
N 290 -640 300 -640 {lab=gd}
N 210 -400 230 -400 {lab=iref}
N 170 -450 170 -430 {lab=vp}
N 160 -400 170 -400 {lab=vp}
N 160 -450 160 -400 {lab=vp}
N 160 -450 170 -450 {lab=vp}
N 170 -480 170 -450 {lab=vp}
N 300 -730 300 -670 {lab=iref}
C {sg13g2_pr/sg13_lv_nmos.sym} 150 -90 0 0 {name=M16
l=0.6u
w=1.6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 150 -210 0 0 {name=M1
l=0.6u
w=1.6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {res.sym} 170 -300 0 0 {name=R1
value=500
footprint=1206
device=resistor
m=1}
C {gnd.sym} 170 -60 0 0 {name=l1 lab=0}
C {sg13g2_pr/sg13_lv_pmos.sym} 320 -780 0 1 {name=M5
l=0.6u
w=1.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 440 -780 0 0 {name=M6
l=0.6u
w=1u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 320 -640 0 1 {name=M7
l=0.6u
w=1u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 440 -640 0 0 {name=M8
l=0.6u
w=1.4u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {res.sym} 300 -520 0 0 {name=R3
value=500
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 290 -780 0 0 {name=p8 sig_type=std_logic lab=vp}
C {lab_pin.sym} 470 -780 0 1 {name=p9 sig_type=std_logic lab=vp}
C {lab_pin.sym} 470 -640 0 1 {name=p10 sig_type=std_logic lab=gd}
C {lab_pin.sym} 290 -640 0 0 {name=p11 sig_type=std_logic lab=gd}
C {lab_pin.sym} 360 -730 0 1 {name=p15 sig_type=std_logic lab=iref}
C {sg13g2_pr/sg13_lv_pmos.sym} 190 -400 0 1 {name=M10
l=0.6u
w=1.6u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 170 -480 0 1 {name=p16 sig_type=std_logic lab=vp}
C {lab_pin.sym} 230 -400 0 1 {name=p17 sig_type=std_logic lab=iref}
C {iopin.sym} 320 -850 0 0 {name=p28 lab=vp}
C {iopin.sym} 310 -450 0 0 {name=p6 lab=gd}
C {opin.sym} 310 -250 0 0 {name=p7 lab=vbias}
C {lab_pin.sym} 180 -210 0 1 {name=p4 sig_type=std_logic lab=gd}
C {lab_pin.sym} 180 -90 0 1 {name=p12 sig_type=std_logic lab=gd}
