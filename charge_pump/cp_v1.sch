v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 260 -740 260 -690 {lab=Vp}
N 740 -740 1100 -740 {lab=Vp}
N 1100 -740 1100 -690 {lab=Vp}
N 740 -740 740 -690 {lab=Vp}
N 260 -740 740 -740 {lab=Vp}
N 120 -740 120 -500 {lab=Vp}
N 120 -740 260 -740 {lab=Vp}
N 400 -660 1060 -660 {lab=#net1}
N 300 -560 700 -560 {lab=Vbp}
N 560 -530 950 -530 {lab=VH}
N 560 -530 560 -500 {lab=VH}
N 950 -530 950 -500 {lab=VH}
N 950 -420 950 -400 {lab=Vout}
N 560 -410 560 -400 {lab=Vamp_m}
N 490 -470 520 -470 {lab=UPB}
N 490 -370 520 -370 {lab=DNB}
N 990 -470 1020 -470 {lab=UP}
N 990 -370 1020 -370 {lab=UP}
N 560 -340 560 -320 {lab=VF}
N 740 -320 950 -320 {lab=VF}
N 950 -340 950 -320 {lab=VF}
N 740 -320 740 -280 {lab=VF}
N 560 -320 740 -320 {lab=VF}
N 740 -90 1100 -90 {lab=0}
N 1100 -120 1100 -90 {lab=0}
N 740 -120 740 -90 {lab=0}
N 260 -90 740 -90 {lab=0}
N 260 -120 260 -90 {lab=0}
N 120 -120 120 -90 {lab=0}
N 120 -90 260 -90 {lab=0}
N 120 -310 120 -280 {lab=#net2}
N 190 -150 1060 -150 {lab=#net2}
N 160 -250 700 -250 {lab=Vbn}
N 1040 -560 1060 -560 {lab=Vout}
N 1040 -420 1040 -250 {lab=Vout}
N 1040 -250 1060 -250 {lab=Vout}
N 950 -420 1040 -420 {lab=Vout}
N 950 -440 950 -420 {lab=Vout}
N 1040 -560 1040 -420 {lab=Vout}
N 1040 -420 1190 -420 {lab=Vout}
N 1100 -610 1100 -590 {lab=Vn}
N 1100 -610 1210 -610 {lab=Vn}
N 1100 -630 1100 -610 {lab=Vn}
N 300 -460 350 -460 {lab=Vp}
N 300 -370 350 -370 {lab=Vn}
N 1100 -200 1100 -180 {lab=Vp}
N 1100 -200 1200 -200 {lab=Vp}
N 1100 -220 1100 -200 {lab=Vp}
N 120 -310 190 -310 {lab=#net2}
N 120 -440 120 -310 {lab=#net2}
N 190 -310 190 -150 {lab=#net2}
N 160 -150 190 -150 {lab=#net2}
N 120 -220 120 -180 {lab=#net3}
N 260 -340 260 -280 {lab=VE}
N 260 -410 260 -400 {lab=#net1}
N 260 -530 260 -490 {lab=VG}
N 260 -410 400 -410 {lab=#net1}
N 260 -430 260 -410 {lab=#net1}
N 400 -660 400 -410 {lab=#net1}
N 300 -660 400 -660 {lab=#net1}
N 660 -390 780 -390 {lab=Vamp_m}
N 660 -410 660 -390 {lab=Vamp_m}
N 560 -410 660 -410 {lab=Vamp_m}
N 560 -440 560 -410 {lab=Vamp_m}
N 780 -450 840 -450 {lab=Vout}
N 840 -450 840 -420 {lab=Vout}
N 840 -420 950 -420 {lab=Vout}
N 740 -220 740 -180 {lab=#net4}
N 740 -630 740 -590 {lab=#net5}
N 260 -630 260 -590 {lab=#net6}
C {sg13g2_pr/sg13_lv_nmos.sym} 280 -370 0 1 {name=M1
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 720 -660 0 0 {name=M3
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 280 -660 0 1 {name=M4
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 280 -560 0 1 {name=M5
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 720 -560 0 0 {name=M6
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 280 -460 0 1 {name=M7
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 540 -470 0 0 {name=M8
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 970 -470 0 1 {name=M9
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 540 -370 0 0 {name=M10
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 970 -370 0 1 {name=M11
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 720 -250 0 0 {name=M12
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 720 -150 0 0 {name=M13
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 1080 -660 0 0 {name=M14
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 1080 -560 0 0 {name=M15
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 1080 -250 0 0 {name=M16
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 1080 -150 0 0 {name=M17
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 240 -250 0 0 {name=M2
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 240 -150 0 0 {name=M18
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 140 -250 0 1 {name=M19
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 140 -150 0 1 {name=M20
l=0.13u
w=0.15u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {isource.sym} 120 -470 0 0 {name=I0 value=400u}
C {gnd.sym} 260 -90 0 0 {name=l1 lab=0}
C {gnd.sym} 1100 -530 0 0 {name=l2 lab=0}
C {bsource.sym} 780 -420 0 1 {name=B1 VAR=I FUNC="(v(Vout)-v(Vamp_m))*0.001" m=1}
C {lab_wire.sym} 490 -560 0 0 {name=p1 sig_type=std_logic lab=Vbp}
C {lab_wire.sym} 560 -410 0 0 {name=p2 sig_type=std_logic lab=Vamp_m}
C {vdd.sym} 740 -740 0 0 {name=l3 lab=Vp}
C {vdd.sym} 1200 -200 0 0 {name=l4 lab=Vp}
C {vdd.sym} 1210 -610 0 0 {name=l5 lab=Vn}
C {vdd.sym} 350 -460 0 0 {name=l6 lab=Vp}
C {vdd.sym} 350 -370 0 0 {name=l7 lab=Vn}
C {vdd.sym} 1020 -470 0 0 {name=l8 lab=UP}
C {vdd.sym} 1020 -370 0 0 {name=l9 lab=UP}
C {vdd.sym} 490 -370 0 0 {name=l10 lab=DNB}
C {vdd.sym} 490 -470 0 0 {name=l11 lab=UPB}
C {vdd.sym} 1190 -420 0 0 {name=l12 lab=Vout}
C {lab_wire.sym} 470 -250 0 0 {name=p3 sig_type=std_logic lab=Vbn}
C {lab_wire.sym} 730 -320 0 0 {name=p4 sig_type=std_logic lab=VF}
C {lab_wire.sym} 260 -500 0 0 {name=p5 sig_type=std_logic lab=VG}
C {lab_wire.sym} 260 -300 0 0 {name=p6 sig_type=std_logic lab=VE}
C {lab_wire.sym} 860 -530 0 0 {name=p7 sig_type=std_logic lab=VH}
C {vdd.sym} 1100 -280 0 0 {name=l13 lab=Vp}
