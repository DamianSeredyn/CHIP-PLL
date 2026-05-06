v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 770 -90 770 -60 {lab=gd}
N 290 -60 770 -60 {lab=gd}
N 770 -190 770 -150 {lab=net4}
N 770 -120 780 -120 {lab=gd}
N 730 -130 730 -120 {lab=net1}
N 770 -220 780 -220 {lab=gd}
N 390 -220 730 -220 {lab=biasn}
N 290 -90 290 -60 {lab=gd}
N 150 -90 150 -60 {lab=gd}
N 150 -60 290 -60 {lab=gd}
N 330 -420 380 -420 {lab=biasn}
N 190 -120 220 -120 {lab=net1}
N 280 -420 290 -420 {lab=gd}
N 140 -270 150 -270 {lab=#net3}
N 140 -120 150 -120 {lab=gd}
N 220 -120 250 -120 {lab=net1}
N 250 -130 250 -120 {lab=net1}
N 250 -130 370 -130 {lab=net1}
N 370 -130 370 -120 {lab=net1}
N 290 -120 300 -120 {lab=gd}
N 250 -230 250 -220 {lab=biasn}
N 390 -230 390 -220 {lab=biasn}
N 290 -220 300 -220 {lab=gd}
N 190 -220 250 -220 {lab=biasn}
N 290 -190 290 -150 {lab=net7}
N 250 -230 390 -230 {lab=biasn}
N 220 -350 220 -120 {lab=net1}
N 150 -350 220 -350 {lab=net1}
N 140 -300 150 -300 {lab=gd}
N 190 -300 190 -220 {lab=biasn}
N 150 -350 150 -330 {lab=net1}
N 150 -460 150 -350 {lab=net1}
N 150 -180 150 -150 {lab=net2}
N 150 -270 150 -240 {lab=#net3}
N 290 -270 290 -250 {lab=VE}
N 770 -400 770 -340 {lab=VF}
N 770 -280 770 -250 {lab=net13}
N 290 -810 290 -760 {lab=vp}
N 280 -600 290 -600 {lab=vp}
N 280 -530 290 -530 {lab=vp}
N 280 -730 290 -730 {lab=vp}
N 360 -630 730 -630 {lab=biasn}
N 290 -700 290 -630 {lab=net8}
N 330 -630 330 -600 {lab=biasn}
N 290 -570 290 -560 {lab=VG}
N 290 -490 290 -450 {lab=net15}
N 770 -810 770 -760 {lab=vp}
N 770 -730 780 -730 {lab=vp}
N 770 -570 780 -570 {lab=vp}
N 730 -630 730 -570 {lab=biasn}
N 770 -700 770 -680 {lab=net5}
N 770 -620 770 -600 {lab=#net6}
N 290 -390 290 -330 {lab=net10}
N 400 -730 400 -490 {lab=net15}
N 330 -730 400 -730 {lab=net15}
N 290 -490 400 -490 {lab=net15}
N 290 -500 290 -490 {lab=net15}
N 770 -540 770 -530 {lab=VH}
N 770 -530 890 -530 {lab=VH}
N 890 -530 890 -520 {lab=VH}
N 890 -420 890 -400 {lab=vout}
N 890 -340 890 -320 {lab=VF}
N 820 -320 890 -320 {lab=VF}
N 820 -400 820 -320 {lab=VF}
N 770 -400 820 -400 {lab=VF}
N 770 -410 770 -400 {lab=VF}
N 930 -370 950 -370 {lab=DN}
N 930 -490 950 -490 {lab=UP}
N 890 -460 890 -420 {lab=vout}
N 870 -370 890 -370 {lab=gd}
N 870 -490 890 -490 {lab=vp}
N 890 -420 970 -420 {lab=vout}
N 370 -120 730 -120 {lab=net1}
N 400 -730 730 -730 {lab=net15}
N 330 -530 360 -530 {lab=biasn}
N 360 -630 360 -530 {lab=biasn}
N 330 -630 360 -630 {lab=biasn}
N 650 -520 670 -520 {lab=gd}
N 650 -540 670 -540 {lab=vp}
N 650 -500 660 -500 {lab=biasn}
N 660 -500 660 -480 {lab=biasn}
N 150 -810 150 -520 {lab=vp}
N 290 -810 770 -810 {lab=vp}
N 150 -810 290 -810 {lab=vp}
C {sg13g2_pr/sg13_lv_nmos.sym} 750 -220 0 0 {name=M15
l=0.6u
w=1.6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 750 -120 0 0 {name=M16
l=0.6u
w=1.7u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 770 -180 0 1 {name=p54 sig_type=std_logic lab=net4}
C {lab_pin.sym} 550 -630 0 1 {name=p5 sig_type=std_logic lab=biasn}
C {sg13g2_pr/sg13_lv_nmos.sym} 310 -420 0 1 {name=M1
l=0.6u
w=1.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 270 -220 0 0 {name=M6
l=0.6u
w=1.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 270 -120 0 0 {name=M8
l=0.6u
w=1.72u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 170 -300 0 1 {name=M9
l=0.6u
w=1.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 170 -120 0 1 {name=M10
l=0.6u
w=1.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 290 -160 0 1 {name=p17 sig_type=std_logic lab=net7}
C {lab_pin.sym} 150 -170 0 1 {name=p7 sig_type=std_logic lab=net2}
C {lab_pin.sym} 290 -360 0 1 {name=p16 sig_type=std_logic lab=net10}
C {isource.sym} 150 -490 0 0 {name=Iiref
value=0.5u savecurrent=false}
C {lab_pin.sym} 150 -400 0 1 {name=p3 sig_type=std_logic lab=net1}
C {vsource.sym} 150 -210 0 0 {name=Vprad
value=0 savecurrent=false}
C {vsource.sym} 290 -300 0 0 {name=Vprad1
value=0 savecurrent=false}
C {vsource.sym} 770 -310 0 0 {name=Vprad2
value=0 savecurrent=false}
C {sg13g2_pr/sg13_lv_pmos.sym} 310 -600 0 1 {name=q
l=0.6u
w=2.84u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 310 -530 0 1 {name=M3
l=0.6u
w=2.8u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 280 -530 0 0 {name=p10 sig_type=std_logic lab=vp}
C {lab_pin.sym} 280 -600 0 0 {name=p34 sig_type=std_logic lab=vp}
C {lab_pin.sym} 280 -730 0 0 {name=p26 sig_type=std_logic lab=vp}
C {lab_pin.sym} 290 -670 0 1 {name=p14 sig_type=std_logic lab=net8}
C {lab_wire.sym} 770 -260 0 0 {name=p6 sig_type=std_logic lab=net13}
C {sg13g2_pr/sg13_lv_pmos.sym} 750 -570 0 0 {name=M7
l=0.8u
w=1u
ng=1
m=3
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 780 -730 2 0 {name=p13 sig_type=std_logic lab=vp}
C {lab_pin.sym} 780 -570 2 0 {name=p36 sig_type=std_logic lab=vp}
C {lab_pin.sym} 770 -690 0 1 {name=p57 sig_type=std_logic lab=net5}
C {sg13g2_pr/sg13_lv_pmos.sym} 750 -730 0 0 {name=M11
l=0.8u
w=1u
ng=1
m=3
model=sg13_lv_pmos
spiceprefix=X
}
C {vsource.sym} 770 -650 0 0 {name=Vprad3
value=0 savecurrent=false}
C {lab_pin.sym} 290 -470 0 1 {name=p9 sig_type=std_logic lab=net15}
C {sg13g2_pr/sg13_lv_pmos.sym} 310 -730 0 1 {name=M2
l=0.6u
w=2.84u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 910 -490 0 1 {name=M17
l=0.6u
w=1.6u
ng=1
m=3
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 910 -370 0 1 {name=M18
l=0.6u
w=1.6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_wire.sym} 870 -490 0 0 {name=p12 sig_type=std_logic lab=vp}
C {lab_pin.sym} 290 -260 2 0 {name=p27 sig_type=std_logic lab=VE}
C {lab_pin.sym} 290 -560 2 0 {name=p15 sig_type=std_logic lab=VG}
C {lab_pin.sym} 790 -530 2 0 {name=p28 sig_type=std_logic lab=VH}
C {lab_pin.sym} 790 -400 2 0 {name=p29 sig_type=std_logic lab=VF}
C {lab_pin.sym} 450 -220 0 1 {name=p19 sig_type=std_logic lab=biasn}
C {lab_pin.sym} 380 -420 0 1 {name=p21 sig_type=std_logic lab=biasn}
C {/foss/designs/CHIP-PLL/charge_pump/vbias.sym} 500 -520 0 0 {name=x1}
C {lab_pin.sym} 660 -480 0 1 {name=p23 sig_type=std_logic lab=biasn}
C {lab_wire.sym} 670 -540 0 0 {name=p24 sig_type=std_logic lab=vp}
C {iopin.sym} 950 -490 0 0 {name=p11 lab=UP
}
C {iopin.sym} 950 -370 0 0 {name=p18 lab=DN
}
C {iopin.sym} 490 -60 0 0 {name=p20 lab=gd}
C {lab_pin.sym} 300 -120 0 1 {name=p25 sig_type=std_logic lab=gd}
C {lab_pin.sym} 300 -220 0 1 {name=p30 sig_type=std_logic lab=gd}
C {lab_pin.sym} 140 -300 0 1 {name=p31 sig_type=std_logic lab=gd}
C {lab_pin.sym} 140 -120 0 1 {name=p32 sig_type=std_logic lab=gd}
C {lab_pin.sym} 780 -220 0 1 {name=p33 sig_type=std_logic lab=gd}
C {lab_pin.sym} 780 -120 0 1 {name=p35 sig_type=std_logic lab=gd}
C {lab_pin.sym} 280 -420 0 1 {name=p37 sig_type=std_logic lab=gd}
C {lab_pin.sym} 870 -370 0 1 {name=p38 sig_type=std_logic lab=gd}
C {lab_pin.sym} 670 -520 0 1 {name=p39 sig_type=std_logic lab=gd}
C {iopin.sym} 290 -810 0 0 {name=p22 lab=vp
}
C {opin.sym} 970 -420 0 0 {name=p1 lab=vout
}
