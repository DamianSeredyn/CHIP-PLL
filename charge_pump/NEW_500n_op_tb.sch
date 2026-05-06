v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 1070 -120 1070 -90 {lab=0}
N 590 -90 1070 -90 {lab=0}
N 1070 -220 1070 -180 {lab=net4}
N 930 -150 1030 -150 {lab=net1}
N 1070 -150 1080 -150 {lab=0}
N 1030 -160 1030 -150 {lab=net1}
N 1070 -250 1080 -250 {lab=0}
N 690 -250 1030 -250 {lab=biasn}
N 590 -120 590 -90 {lab=0}
N 450 -120 450 -90 {lab=0}
N 450 -90 590 -90 {lab=0}
N 630 -450 680 -450 {lab=biasn}
N 490 -150 520 -150 {lab=net1}
N 580 -450 590 -450 {lab=0}
N 440 -300 450 -300 {lab=#net3}
N 440 -150 450 -150 {lab=0}
N 520 -150 550 -150 {lab=net1}
N 550 -160 550 -150 {lab=net1}
N 550 -160 670 -160 {lab=net1}
N 670 -160 670 -150 {lab=net1}
N 590 -150 600 -150 {lab=0}
N 550 -260 550 -250 {lab=biasn}
N 690 -260 690 -250 {lab=biasn}
N 590 -250 600 -250 {lab=0}
N 490 -250 550 -250 {lab=biasn}
N 590 -220 590 -180 {lab=net7}
N 550 -260 690 -260 {lab=biasn}
N 520 -380 520 -150 {lab=net1}
N 450 -380 520 -380 {lab=net1}
N 440 -330 450 -330 {lab=0}
N 490 -330 490 -250 {lab=biasn}
N 450 -380 450 -360 {lab=net1}
N 450 -720 450 -550 {lab=vp}
N 450 -490 450 -380 {lab=net1}
N 450 -210 450 -180 {lab=net2}
N 450 -300 450 -270 {lab=#net3}
N 590 -300 590 -280 {lab=VE}
N 1070 -430 1070 -370 {lab=VF}
N 1070 -310 1070 -280 {lab=net13}
N 590 -840 590 -790 {lab=vp}
N 580 -630 590 -630 {lab=vp}
N 580 -560 590 -560 {lab=vp}
N 580 -760 590 -760 {lab=vp}
N 660 -660 1030 -660 {lab=biasn}
N 590 -730 590 -660 {lab=net8}
N 630 -660 630 -630 {lab=biasn}
N 590 -600 590 -590 {lab=VG}
N 590 -520 590 -480 {lab=net15}
N 1070 -840 1070 -790 {lab=vp}
N 1070 -760 1080 -760 {lab=vp}
N 1070 -600 1080 -600 {lab=vp}
N 1030 -660 1030 -600 {lab=biasn}
N 1070 -730 1070 -710 {lab=net5}
N 1070 -650 1070 -630 {lab=#net6}
N 590 -420 590 -360 {lab=net10}
N 700 -760 700 -520 {lab=net15}
N 630 -760 700 -760 {lab=net15}
N 590 -520 700 -520 {lab=net15}
N 590 -530 590 -520 {lab=net15}
N 1070 -570 1070 -560 {lab=VH}
N 1070 -560 1190 -560 {lab=VH}
N 1190 -560 1190 -550 {lab=VH}
N 1190 -450 1190 -430 {lab=vout}
N 1190 -370 1190 -350 {lab=VF}
N 1120 -350 1190 -350 {lab=VF}
N 1120 -430 1120 -350 {lab=VF}
N 1070 -430 1120 -430 {lab=VF}
N 1070 -440 1070 -430 {lab=VF}
N 1230 -400 1250 -400 {lab=dn}
N 1230 -520 1250 -520 {lab=up}
N 1190 -490 1190 -450 {lab=vout}
N 1170 -400 1190 -400 {lab=0}
N 1170 -520 1190 -520 {lab=vp}
N 1070 -840 1310 -840 {lab=vp}
N 1190 -450 1270 -450 {lab=vout}
N 1170 -150 1270 -150 {lab=net1}
N 1170 -200 1170 -150 {lab=net1}
N 930 -200 1170 -200 {lab=net1}
N 930 -200 930 -150 {lab=net1}
N 670 -150 930 -150 {lab=net1}
N 700 -760 1030 -760 {lab=net15}
N 630 -560 660 -560 {lab=biasn}
N 1410 -460 1410 -440 {lab=vout}
N 660 -660 660 -560 {lab=biasn}
N 630 -660 660 -660 {lab=biasn}
N 950 -550 970 -550 {lab=0}
N 950 -570 970 -570 {lab=vp}
N 950 -530 960 -530 {lab=biasn}
N 960 -530 960 -510 {lab=biasn}
C {sg13g2_pr/sg13_lv_nmos.sym} 1050 -250 0 0 {name=M15
l=0.6u
w=1.6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 1050 -150 0 0 {name=M16
l=0.6u
w=1.7u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 1070 -210 0 1 {name=p54 sig_type=std_logic lab=net4}
C {lab_pin.sym} 850 -660 0 1 {name=p5 sig_type=std_logic lab=biasn}
C {sg13g2_pr/sg13_lv_nmos.sym} 610 -450 0 1 {name=M1
l=0.6u
w=1.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 570 -250 0 0 {name=M6
l=0.6u
w=1.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 570 -150 0 0 {name=M8
l=0.6u
w=1.72u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 470 -330 0 1 {name=M9
l=0.6u
w=1.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 470 -150 0 1 {name=M10
l=0.6u
w=1.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 590 -190 0 1 {name=p17 sig_type=std_logic lab=net7}
C {lab_pin.sym} 450 -200 0 1 {name=p7 sig_type=std_logic lab=net2}
C {lab_pin.sym} 590 -390 0 1 {name=p16 sig_type=std_logic lab=net10}
C {lab_wire.sym} 450 -670 0 0 {name=p2 sig_type=std_logic lab=vp}
C {vsource.sym} 260 -570 0 0 {name=Vvp
value=1.2 savecurrent=false}
C {gnd.sym} 260 -540 0 0 {name=l16 lab=0}
C {lab_pin.sym} 260 -600 0 0 {name=p47 sig_type=std_logic lab=vp}
C {devices/code_shown.sym} 10 -440 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} 60 -350 0 0 {name=NGSPICE only_toplevel=true 
value="
.temp 27

.control

op
save all
write mirror_test.raw
set appendwrite
show all
.endc
"}
C {gnd.sym} 580 -450 0 0 {name=l1 lab=0}
C {gnd.sym} 1080 -250 0 0 {name=l5 lab=0}
C {gnd.sym} 1080 -150 0 0 {name=l6 lab=0}
C {gnd.sym} 600 -150 0 0 {name=l7 lab=0}
C {gnd.sym} 440 -150 0 0 {name=l8 lab=0}
C {gnd.sym} 600 -250 0 0 {name=l2 lab=0}
C {gnd.sym} 440 -330 0 0 {name=l9 lab=0}
C {isource.sym} 450 -520 0 0 {name=Iiref
value=0.5u savecurrent=false}
C {gnd.sym} 740 -90 0 0 {name=l10 lab=0}
C {lab_pin.sym} 450 -430 0 1 {name=p3 sig_type=std_logic lab=net1}
C {vsource.sym} 450 -240 0 0 {name=Vprad
value=0 savecurrent=false}
C {vsource.sym} 590 -330 0 0 {name=Vprad1
value=0 savecurrent=false}
C {vsource.sym} 1070 -340 0 0 {name=Vprad2
value=0 savecurrent=false}
C {sg13g2_pr/sg13_lv_pmos.sym} 610 -630 0 1 {name=q
l=0.6u
w=2.84u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 610 -560 0 1 {name=M3
l=0.6u
w=2.8u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 580 -560 0 0 {name=p10 sig_type=std_logic lab=vp}
C {lab_pin.sym} 580 -630 0 0 {name=p34 sig_type=std_logic lab=vp}
C {lab_pin.sym} 580 -760 0 0 {name=p26 sig_type=std_logic lab=vp}
C {lab_pin.sym} 590 -700 0 1 {name=p14 sig_type=std_logic lab=net8}
C {lab_wire.sym} 590 -820 0 0 {name=p4 sig_type=std_logic lab=vp}
C {lab_wire.sym} 1070 -290 0 0 {name=p6 sig_type=std_logic lab=net13}
C {sg13g2_pr/sg13_lv_pmos.sym} 1050 -600 0 0 {name=M7
l=0.8u
w=1u
ng=1
m=3
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 1080 -760 2 0 {name=p13 sig_type=std_logic lab=vp}
C {lab_pin.sym} 1080 -600 2 0 {name=p36 sig_type=std_logic lab=vp}
C {lab_pin.sym} 1070 -720 0 1 {name=p57 sig_type=std_logic lab=net5}
C {sg13g2_pr/sg13_lv_pmos.sym} 1050 -760 0 0 {name=M11
l=0.8u
w=1u
ng=1
m=3
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_wire.sym} 1070 -840 0 0 {name=p8 sig_type=std_logic lab=vp}
C {vsource.sym} 1070 -680 0 0 {name=Vprad3
value=0 savecurrent=false}
C {lab_pin.sym} 590 -500 0 1 {name=p9 sig_type=std_logic lab=net15}
C {sg13g2_pr/sg13_lv_pmos.sym} 610 -760 0 1 {name=M2
l=0.6u
w=2.84u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 1210 -520 0 1 {name=M17
l=0.6u
w=1.6u
ng=1
m=3
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 1210 -400 0 1 {name=M18
l=0.6u
w=1.6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_wire.sym} 1170 -520 0 0 {name=p12 sig_type=std_logic lab=vp}
C {gnd.sym} 1170 -400 0 0 {name=l13 lab=0}
C {lab_pin.sym} 590 -290 2 0 {name=p27 sig_type=std_logic lab=VE}
C {lab_pin.sym} 590 -590 2 0 {name=p15 sig_type=std_logic lab=VG}
C {lab_pin.sym} 1090 -560 2 0 {name=p28 sig_type=std_logic lab=VH}
C {lab_pin.sym} 1090 -430 2 0 {name=p29 sig_type=std_logic lab=VF}
C {capa.sym} 1410 -410 0 0 {name=C1
m=1
value=5p
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 1410 -380 0 0 {name=l14 lab=0}
C {lab_pin.sym} 1260 -450 2 0 {name=p1 sig_type=std_logic lab=vout}
C {lab_pin.sym} 1410 -460 2 0 {name=p18 sig_type=std_logic lab=vout}
C {lab_pin.sym} 750 -250 0 1 {name=p19 sig_type=std_logic lab=biasn}
C {lab_pin.sym} 680 -450 0 1 {name=p21 sig_type=std_logic lab=biasn}
C {/foss/designs/CHIP-PLL/charge_pump/vbias.sym} 800 -550 0 0 {name=x1}
C {gnd.sym} 970 -550 0 0 {name=Vbias2 lab=0}
C {lab_pin.sym} 960 -510 0 1 {name=p23 sig_type=std_logic lab=biasn}
C {lab_wire.sym} 970 -570 0 0 {name=p24 sig_type=std_logic lab=vp}
C {lab_pin.sym} 1250 -520 0 1 {name=p11 sig_type=std_logic lab=up}
C {lab_pin.sym} 1250 -400 0 1 {name=p20 sig_type=std_logic lab=dn}
C {vsource.sym} 160 -780 0 0 {name=Vup2
value=0 savecurrent=false}
C {gnd.sym} 160 -750 0 0 {name=l11 lab=0}
C {vsource.sym} 160 -670 0 0 {name=Vdn2
value=1.2 savecurrent=false}
C {gnd.sym} 160 -640 0 0 {name=l12 lab=0}
C {lab_pin.sym} 160 -810 0 1 {name=p30 sig_type=std_logic lab=up}
C {lab_pin.sym} 160 -700 0 1 {name=p31 sig_type=std_logic lab=dn}
C {vsource.sym} 1350 -410 0 0 {name=Vup1
value=0.8 savecurrent=false}
C {gnd.sym} 1350 -380 0 0 {name=l3 lab=0}
C {lab_pin.sym} 1350 -440 0 1 {name=p22 sig_type=std_logic lab=vout}
