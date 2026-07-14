v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 850 -100 850 -70 {lab=gd}
N 850 -200 850 -160 {lab=net4}
N 850 -130 860 -130 {lab=gd}
N 810 -140 810 -130 {lab=net1}
N 850 -230 860 -230 {lab=gd}
N 470 -230 810 -230 {lab=bias}
N 370 -100 370 -70 {lab=gd}
N 230 -100 230 -70 {lab=gd}
N 230 -70 370 -70 {lab=gd}
N 410 -430 460 -430 {lab=bias}
N 270 -130 300 -130 {lab=net1}
N 360 -430 370 -430 {lab=gd}
N 220 -280 230 -280 {lab=net2}
N 220 -130 230 -130 {lab=gd}
N 300 -130 330 -130 {lab=net1}
N 330 -140 330 -130 {lab=net1}
N 330 -140 450 -140 {lab=net1}
N 450 -140 450 -130 {lab=net1}
N 370 -130 380 -130 {lab=gd}
N 330 -240 330 -230 {lab=bias}
N 470 -240 470 -230 {lab=bias}
N 370 -230 380 -230 {lab=gd}
N 270 -230 330 -230 {lab=bias}
N 370 -200 370 -160 {lab=net7}
N 330 -240 470 -240 {lab=bias}
N 300 -360 300 -130 {lab=net1}
N 230 -360 300 -360 {lab=net1}
N 220 -310 230 -310 {lab=gd}
N 270 -310 270 -230 {lab=bias}
N 230 -360 230 -340 {lab=net1}
N 230 -280 230 -160 {lab=net2}
N 370 -820 370 -770 {lab=vp}
N 360 -610 370 -610 {lab=vp}
N 360 -740 370 -740 {lab=vp}
N 370 -710 370 -640 {lab=net8}
N 410 -640 410 -610 {lab=bias}
N 370 -580 370 -500 {lab=net15}
N 370 -500 370 -460 {lab=net15}
N 850 -820 850 -770 {lab=vp}
N 850 -740 860 -740 {lab=vp}
N 850 -580 860 -580 {lab=vp}
N 810 -640 810 -580 {lab=bias}
N 370 -400 370 -260 {lab=net10}
N 480 -740 480 -500 {lab=net15}
N 410 -740 480 -740 {lab=net15}
N 370 -500 480 -500 {lab=net15}
N 850 -550 850 -530 {lab=#net3}
N 890 -400 910 -400 {lab=DN}
N 450 -130 810 -130 {lab=net1}
N 480 -740 810 -740 {lab=net15}
N 370 -820 850 -820 {lab=vp}
N 230 -820 370 -820 {lab=vp}
N 850 -710 850 -610 {lab=net5}
N 230 -710 230 -690 {lab=vp}
N 150 -660 190 -660 {lab=#net6}
N 150 -730 150 -680 {lab=vp}
N 150 -730 230 -730 {lab=vp}
N 230 -820 230 -730 {lab=vp}
N 150 -640 160 -640 {lab=gd}
N 230 -660 240 -660 {lab=vp}
N 240 -710 240 -660 {lab=vp}
N 230 -710 240 -710 {lab=vp}
N 230 -730 230 -710 {lab=vp}
N 230 -630 230 -360 {lab=net1}
N 410 -640 810 -640 {lab=bias}
N 370 -70 850 -70 {lab=gd}
N 680 -560 710 -560 {lab=vp}
N 680 -540 710 -540 {lab=gd}
N 680 -520 710 -520 {lab=bias}
N 1060 -610 1060 -590 {lab=#net9}
N 1060 -620 1060 -610 {lab=#net9}
N 1060 -690 1060 -680 {lab=vp}
N 1060 -530 1060 -520 {lab=gd}
N 1060 -520 1080 -520 {lab=gd}
N 1100 -560 1110 -560 {lab=UP}
N 1110 -650 1110 -560 {lab=UP}
N 1100 -650 1110 -650 {lab=UP}
N 1050 -650 1060 -650 {lab=vp}
N 1050 -690 1050 -650 {lab=vp}
N 1050 -690 1060 -690 {lab=vp}
N 1060 -700 1060 -690 {lab=vp}
N 1050 -560 1060 -560 {lab=gd}
N 1050 -560 1050 -520 {lab=gd}
N 1050 -520 1060 -520 {lab=gd}
N 850 -450 850 -430 {lab=vout}
N 850 -450 930 -450 {lab=vout}
N 850 -470 850 -450 {lab=vout}
N 850 -370 850 -260 {lab=net13}
N 840 -500 850 -500 {lab=vp}
N 840 -400 850 -400 {lab=gd}
N 890 -500 960 -500 {lab=#net9}
N 960 -610 960 -500 {lab=#net9}
N 960 -610 1060 -610 {lab=#net9}
C {sg13g2_pr/sg13_lv_nmos.sym} 830 -230 0 0 {name=M15
l=0.6u
w=1.6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 830 -130 0 0 {name=M16
l=0.6u
w=1.6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 850 -190 0 1 {name=p54 sig_type=std_logic lab=net4}
C {sg13g2_pr/sg13_lv_nmos.sym} 390 -430 0 1 {name=M1
l=0.6u
w=1.6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 350 -230 0 0 {name=M6
l=0.6u
w=1.6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 350 -130 0 0 {name=M8
l=0.6u
w=1.6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 250 -310 0 1 {name=M9
l=0.6u
w=4.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 250 -130 0 1 {name=M10
l=0.6u
w=4.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 370 -170 0 1 {name=p17 sig_type=std_logic lab=net7}
C {lab_pin.sym} 230 -180 0 1 {name=p7 sig_type=std_logic lab=net2}
C {lab_pin.sym} 370 -370 0 1 {name=p16 sig_type=std_logic lab=net10}
C {lab_pin.sym} 230 -410 0 1 {name=p3 sig_type=std_logic lab=net1}
C {sg13g2_pr/sg13_lv_pmos.sym} 390 -610 0 1 {name=M19
l=0.6u
w=1.6u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 360 -610 0 0 {name=p34 sig_type=std_logic lab=vp}
C {lab_pin.sym} 360 -740 0 0 {name=p26 sig_type=std_logic lab=vp}
C {lab_pin.sym} 370 -680 0 1 {name=p14 sig_type=std_logic lab=net8}
C {lab_wire.sym} 850 -270 0 0 {name=p6 sig_type=std_logic lab=net13}
C {sg13g2_pr/sg13_lv_pmos.sym} 830 -580 0 0 {name=M7
l=0.6u
w=1.6u
ng=1
m=3
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 860 -740 2 0 {name=p13 sig_type=std_logic lab=vp}
C {lab_pin.sym} 860 -580 2 0 {name=p36 sig_type=std_logic lab=vp}
C {lab_pin.sym} 850 -700 0 1 {name=p57 sig_type=std_logic lab=net5}
C {sg13g2_pr/sg13_lv_pmos.sym} 830 -740 0 0 {name=M11
l=0.6u
w=1.6u
ng=1
m=3
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 370 -480 0 1 {name=p9 sig_type=std_logic lab=net15}
C {sg13g2_pr/sg13_lv_pmos.sym} 390 -740 0 1 {name=M2
l=0.6u
w=5.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 870 -500 0 1 {name=M17
l=0.6u
w=1u
ng=1
m=3
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 870 -400 0 1 {name=M18
l=0.6u
w=1u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_wire.sym} 840 -500 0 0 {name=p12 sig_type=std_logic lab=vp}
C {lab_pin.sym} 530 -230 0 1 {name=p19 sig_type=std_logic lab=bias}
C {lab_pin.sym} 460 -430 0 1 {name=p21 sig_type=std_logic lab=bias}
C {iopin.sym} 1110 -600 0 0 {name=p11 lab=UP
}
C {iopin.sym} 910 -400 0 0 {name=p18 lab=DN
}
C {iopin.sym} 570 -70 0 0 {name=p20 lab=gd}
C {lab_pin.sym} 380 -130 0 1 {name=p25 sig_type=std_logic lab=gd}
C {lab_pin.sym} 380 -230 0 1 {name=p30 sig_type=std_logic lab=gd}
C {lab_pin.sym} 220 -310 0 1 {name=p31 sig_type=std_logic lab=gd}
C {lab_pin.sym} 220 -130 0 1 {name=p32 sig_type=std_logic lab=gd}
C {lab_pin.sym} 860 -230 0 1 {name=p33 sig_type=std_logic lab=gd}
C {lab_pin.sym} 860 -130 0 1 {name=p35 sig_type=std_logic lab=gd}
C {lab_pin.sym} 360 -430 0 1 {name=p37 sig_type=std_logic lab=gd}
C {iopin.sym} 370 -820 0 0 {name=p22 lab=vp
}
C {opin.sym} 930 -450 0 0 {name=p1 lab=vout
}
C {sg13g2_pr/sg13_lv_pmos.sym} 210 -660 0 0 {name=M3
l=0.6u
w=1u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {curr_source.sym} 0 -660 0 0 {name=x2}
C {lab_pin.sym} 160 -640 0 1 {name=p5 sig_type=std_logic lab=gd}
C {vbias.sym} 530 -540 0 0 {name=x1}
C {lab_pin.sym} 670 -640 0 1 {name=p2 sig_type=std_logic lab=bias}
C {lab_pin.sym} 710 -520 0 1 {name=p8 sig_type=std_logic lab=bias}
C {lab_pin.sym} 710 -540 0 1 {name=p10 sig_type=std_logic lab=gd}
C {lab_pin.sym} 710 -560 2 0 {name=p15 sig_type=std_logic lab=vp}
C {sg13g2_pr/sg13_lv_pmos.sym} 1080 -650 0 1 {name=M4
l=0.8u
w=1u
ng=1
m=3
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 1080 -560 0 1 {name=M5
l=0.6u
w=1u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 1060 -700 2 0 {name=p39 sig_type=std_logic lab=vp}
C {lab_pin.sym} 1080 -520 0 1 {name=p40 sig_type=std_logic lab=gd}
C {lab_pin.sym} 840 -400 0 1 {name=p4 sig_type=std_logic lab=gd}
