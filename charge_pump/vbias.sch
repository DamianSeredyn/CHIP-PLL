v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 330 -320 330 -300 {lab=#net1}
N 330 -220 330 -210 {lab=vbias}
N 330 -110 330 -90 {lab=#net2}
N 270 -60 290 -60 {lab=#net2}
N 270 -110 270 -60 {lab=#net2}
N 270 -110 330 -110 {lab=#net2}
N 330 -150 330 -110 {lab=#net2}
N 270 -180 290 -180 {lab=#net1}
N 270 -320 270 -180 {lab=#net1}
N 270 -320 330 -320 {lab=#net1}
N 330 -340 330 -320 {lab=#net1}
N 330 -220 470 -220 {lab=vbias}
N 330 -240 330 -220 {lab=vbias}
N 330 -180 340 -180 {lab=gd}
N 330 -60 340 -60 {lab=gd}
N 590 -500 590 -460 {lab=vp}
N 750 -500 750 -460 {lab=vp}
N 590 -500 750 -500 {lab=vp}
N 750 -340 750 -320 {lab=#net3}
N 590 -260 590 -200 {lab=#net4}
N 650 -430 710 -430 {lab=iref}
N 690 -290 710 -290 {lab=#net3}
N 590 -380 650 -380 {lab=iref}
N 590 -400 590 -380 {lab=iref}
N 650 -430 650 -380 {lab=iref}
N 630 -430 650 -430 {lab=iref}
N 590 -140 590 -100 {lab=gd}
N 590 -100 750 -100 {lab=gd}
N 750 -260 750 -100 {lab=gd}
N 690 -340 690 -290 {lab=#net3}
N 630 -290 690 -290 {lab=#net3}
N 690 -340 750 -340 {lab=#net3}
N 750 -400 750 -340 {lab=#net3}
N 580 -430 590 -430 {lab=vp}
N 750 -430 760 -430 {lab=vp}
N 750 -290 760 -290 {lab=gd}
N 580 -290 590 -290 {lab=gd}
N 370 -370 390 -370 {lab=iref}
N 330 -420 330 -400 {lab=vp}
N 320 -370 330 -370 {lab=vp}
N 320 -420 320 -370 {lab=vp}
N 320 -420 330 -420 {lab=vp}
N 330 -450 330 -420 {lab=vp}
N 590 -380 590 -320 {lab=iref}
C {sg13g2_pr/sg13_lv_nmos.sym} 310 -60 0 0 {name=M16
l=0.6u
w=1.6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 310 -180 0 0 {name=M1
l=0.6u
w=1.6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {res.sym} 330 -270 0 0 {name=R1
value=500
footprint=1206
device=resistor
m=1}
C {gnd.sym} 330 -30 0 0 {name=l1 lab=0}
C {sg13g2_pr/sg13_lv_pmos.sym} 610 -430 0 1 {name=M5
l=0.6u
w=1.25u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 730 -430 0 0 {name=M6
l=0.6u
w=1u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 610 -290 0 1 {name=M7
l=0.6u
w=1u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 730 -290 0 0 {name=M8
l=0.6u
w=1.25u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {res.sym} 590 -170 0 0 {name=R3
value=500
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 580 -430 0 0 {name=p8 sig_type=std_logic lab=vp}
C {lab_pin.sym} 760 -430 0 1 {name=p9 sig_type=std_logic lab=vp}
C {lab_pin.sym} 760 -290 0 1 {name=p10 sig_type=std_logic lab=gd}
C {lab_pin.sym} 580 -290 0 0 {name=p11 sig_type=std_logic lab=gd}
C {lab_pin.sym} 650 -380 0 1 {name=p15 sig_type=std_logic lab=iref}
C {sg13g2_pr/sg13_lv_pmos.sym} 350 -370 0 1 {name=M10
l=0.6u
w=1.6u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 330 -450 0 1 {name=p16 sig_type=std_logic lab=vp}
C {lab_pin.sym} 390 -370 0 1 {name=p17 sig_type=std_logic lab=iref}
C {iopin.sym} 610 -500 0 0 {name=p28 lab=vp}
C {iopin.sym} 600 -100 0 0 {name=p6 lab=gd}
C {opin.sym} 470 -220 0 0 {name=p7 lab=vbias}
C {lab_pin.sym} 340 -180 0 1 {name=p4 sig_type=std_logic lab=gd}
C {lab_pin.sym} 340 -60 0 1 {name=p12 sig_type=std_logic lab=gd}
