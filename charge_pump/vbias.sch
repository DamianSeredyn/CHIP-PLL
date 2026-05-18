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
N 460 -820 460 -780 {lab=vp}
N 620 -820 620 -780 {lab=vp}
N 460 -820 620 -820 {lab=vp}
N 620 -660 620 -640 {lab=#net3}
N 460 -580 460 -520 {lab=#net4}
N 520 -750 580 -750 {lab=viref}
N 560 -610 580 -610 {lab=#net3}
N 460 -700 520 -700 {lab=viref}
N 460 -720 460 -700 {lab=viref}
N 520 -750 520 -700 {lab=viref}
N 500 -750 520 -750 {lab=viref}
N 460 -460 460 -420 {lab=gd}
N 460 -420 620 -420 {lab=gd}
N 620 -580 620 -420 {lab=gd}
N 560 -660 560 -610 {lab=#net3}
N 500 -610 560 -610 {lab=#net3}
N 560 -660 620 -660 {lab=#net3}
N 620 -720 620 -660 {lab=#net3}
N 450 -750 460 -750 {lab=vp}
N 620 -750 630 -750 {lab=vp}
N 620 -610 630 -610 {lab=gd}
N 450 -610 460 -610 {lab=gd}
N 370 -370 390 -370 {lab=viref}
N 330 -420 330 -400 {lab=vp}
N 320 -370 330 -370 {lab=vp}
N 320 -420 320 -370 {lab=vp}
N 320 -420 330 -420 {lab=vp}
N 330 -450 330 -420 {lab=vp}
C {sg13g2_pr/sg13_lv_nmos.sym} 310 -60 0 0 {name=M16
l=0.6u
w=1u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 310 -180 0 0 {name=M1
l=0.6u
w=1u
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
C {sg13g2_pr/sg13_lv_pmos.sym} 480 -750 0 1 {name=M5
l=0.6u
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 600 -750 0 0 {name=M6
l=0.6u
w=1u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 480 -610 0 1 {name=M7
l=0.6u
w=1u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 600 -610 0 0 {name=M8
l=0.6u
w=1.3u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {res.sym} 460 -490 0 0 {name=R3
value=1k
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 450 -750 0 0 {name=p8 sig_type=std_logic lab=vp}
C {lab_pin.sym} 630 -750 0 1 {name=p9 sig_type=std_logic lab=vp}
C {lab_pin.sym} 630 -610 0 1 {name=p10 sig_type=std_logic lab=gd}
C {lab_pin.sym} 450 -610 0 0 {name=p11 sig_type=std_logic lab=gd}
C {lab_pin.sym} 520 -700 0 1 {name=p15 sig_type=std_logic lab=viref}
C {sg13g2_pr/sg13_lv_pmos.sym} 350 -370 0 1 {name=M10
l=0.6u
w=1u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 330 -450 0 1 {name=p16 sig_type=std_logic lab=vp}
C {lab_pin.sym} 390 -370 0 1 {name=p17 sig_type=std_logic lab=viref}
C {iopin.sym} 480 -820 0 0 {name=p28 lab=vp}
C {iopin.sym} 470 -420 0 0 {name=p6 lab=gd}
C {opin.sym} 470 -220 0 0 {name=p7 lab=vbias}
C {lab_pin.sym} 340 -180 0 1 {name=p4 sig_type=std_logic lab=gd}
C {lab_pin.sym} 340 -60 0 1 {name=p12 sig_type=std_logic lab=gd}
C {vsource.sym} 460 -670 0 0 {name=Viref
value=0 savecurrent=false}
