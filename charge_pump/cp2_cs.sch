v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 1170 -920 1170 -880 {lab=vp}
N 1410 -920 1410 -880 {lab=vp}
N 1170 -920 1410 -920 {lab=vp}
N 1410 -850 1420 -850 {lab=vp}
N 1420 -880 1420 -850 {lab=vp}
N 1410 -880 1420 -880 {lab=vp}
N 1160 -850 1170 -850 {lab=vp}
N 1160 -880 1160 -850 {lab=vp}
N 1160 -880 1170 -880 {lab=vp}
N 1170 -820 1170 -750 {lab=#net1}
N 1170 -820 1210 -820 {lab=#net1}
N 1210 -850 1210 -820 {lab=#net1}
N 1210 -850 1370 -850 {lab=#net1}
N 1210 -170 1370 -170 {lab=#net2}
N 1210 -200 1210 -170 {lab=#net2}
N 1170 -200 1210 -200 {lab=#net2}
N 1320 -350 1370 -350 {lab=dn}
N 1410 -170 1420 -170 {lab=gd}
N 1420 -170 1420 -140 {lab=gd}
N 1410 -140 1420 -140 {lab=gd}
N 1410 -350 1420 -350 {lab=gd}
N 1410 -600 1410 -480 {lab=vout}
N 1330 -480 1410 -480 {lab=vout}
N 1410 -630 1420 -630 {lab=vp}
N 1320 -630 1370 -630 {lab=upb}
N 1160 -140 1170 -140 {lab=gd}
N 1160 -170 1160 -140 {lab=gd}
N 1160 -170 1170 -170 {lab=gd}
N 1170 -140 1170 -110 {lab=gd}
N 1410 -140 1410 -110 {lab=gd}
N 1170 -110 1410 -110 {lab=gd}
N 450 -820 450 -780 {lab=vp}
N 610 -820 610 -780 {lab=vp}
N 450 -820 610 -820 {lab=vp}
N 450 -700 450 -640 {lab=iref}
N 610 -660 610 -640 {lab=#net3}
N 450 -580 450 -520 {lab=#net4}
N 510 -750 570 -750 {lab=iref}
N 550 -610 570 -610 {lab=#net3}
N 450 -700 510 -700 {lab=iref}
N 450 -720 450 -700 {lab=iref}
N 510 -750 510 -700 {lab=iref}
N 490 -750 510 -750 {lab=iref}
N 450 -460 450 -420 {lab=gd}
N 450 -420 610 -420 {lab=gd}
N 610 -580 610 -420 {lab=gd}
N 550 -660 550 -610 {lab=#net3}
N 490 -610 550 -610 {lab=#net3}
N 550 -660 610 -660 {lab=#net3}
N 610 -720 610 -660 {lab=#net3}
N 440 -750 450 -750 {lab=vp}
N 610 -750 620 -750 {lab=vp}
N 610 -610 620 -610 {lab=gd}
N 440 -610 450 -610 {lab=gd}
N 850 -690 850 -660 {lab=#net5}
N 910 -630 970 -630 {lab=#net5}
N 850 -690 910 -690 {lab=#net5}
N 850 -720 850 -690 {lab=#net5}
N 910 -690 910 -630 {lab=#net5}
N 890 -630 910 -630 {lab=#net5}
N 850 -820 850 -780 {lab=vp}
N 1010 -720 1010 -660 {lab=iref_p}
N 850 -550 1010 -550 {lab=gd}
N 850 -600 850 -550 {lab=gd}
N 1010 -600 1010 -550 {lab=gd}
N 790 -750 810 -750 {lab=iref}
N 1010 -630 1020 -630 {lab=gd}
N 840 -630 850 -630 {lab=gd}
N 850 -750 860 -750 {lab=vp}
N 1010 -720 1130 -650 {lab=iref_p}
N 1170 -420 1170 -400 {lab=vp}
N 1170 -370 1180 -370 {lab=vp}
N 1180 -420 1180 -370 {lab=vp}
N 1170 -420 1180 -420 {lab=vp}
N 1170 -440 1170 -420 {lab=vp}
N 1410 -480 1410 -380 {lab=vout}
N 1410 -320 1410 -290 {lab=#net6}
N 1410 -230 1410 -200 {lab=#net7}
N 1410 -820 1410 -770 {lab=#net8}
N 1410 -710 1410 -660 {lab=#net9}
N 1130 -650 1170 -690 {lab=iref_p}
N 1170 -340 1170 -300 {lab=iref2}
N 1170 -240 1170 -200 {lab=#net2}
N 1010 -370 1130 -370 {lab=iref}
C {sg13g2_pr/sg13_lv_pmos.sym} 1190 -850 0 1 {name=M3
l=0.15u
w=2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 1390 -850 0 0 {name=M1
l=0.15u
w=2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 1390 -630 0 0 {name=M6
l=0.15u
w=2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 1390 -350 0 0 {name=M9
l=0.15u
w=3u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 1390 -170 0 0 {name=M10
l=0.15u
w=3u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 1190 -170 0 1 {name=M14
l=0.15u
w=3u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 1420 -630 0 0 {name=p6 sig_type=std_logic lab=vp}
C {iopin.sym} 1410 -920 0 1 {name=p10 lab=vp
}
C {ipin.sym} 1320 -630 0 0 {name=p11 lab=upb}
C {opin.sym} 1330 -480 0 1 {name=p12 lab=vout
}
C {ipin.sym} 1320 -350 0 0 {name=p4 lab=dn}
C {iopin.sym} 1310 -110 0 0 {name=p5 lab=gd}
C {lab_pin.sym} 1420 -350 0 1 {name=p8 sig_type=std_logic lab=gd}
C {sg13g2_pr/sg13_lv_pmos.sym} 470 -750 0 1 {name=M13
l=0.15u
w=2.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 590 -750 0 0 {name=M15
l=0.15u
w=1.8u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 470 -610 0 1 {name=M16
l=0.15u
w=2.6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 590 -610 0 0 {name=M17
l=0.15u
w=2.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {res.sym} 450 -490 0 0 {name=R1
value=500
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 440 -750 0 0 {name=p16 sig_type=std_logic lab=vp}
C {lab_pin.sym} 620 -750 0 1 {name=p17 sig_type=std_logic lab=vp}
C {lab_pin.sym} 620 -610 0 1 {name=p18 sig_type=std_logic lab=gd}
C {lab_pin.sym} 440 -610 0 0 {name=p19 sig_type=std_logic lab=gd}
C {lab_pin.sym} 520 -820 0 1 {name=p20 sig_type=std_logic lab=vp}
C {lab_pin.sym} 530 -420 0 1 {name=p21 sig_type=std_logic lab=gd}
C {sg13g2_pr/sg13_lv_pmos.sym} 830 -750 0 0 {name=M20
l=0.15u
w=2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 990 -630 0 0 {name=M21
l=0.15u
w=2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 870 -630 0 1 {name=M22
l=0.15u
w=2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 510 -700 0 1 {name=p22 sig_type=std_logic lab=iref}
C {lab_pin.sym} 790 -750 0 0 {name=p23 sig_type=std_logic lab=iref}
C {lab_pin.sym} 940 -550 0 1 {name=p24 sig_type=std_logic lab=gd}
C {lab_pin.sym} 1010 -720 0 1 {name=p15 sig_type=std_logic lab=iref_p}
C {lab_pin.sym} 1170 -320 0 0 {name=p27 sig_type=std_logic lab=iref2}
C {lab_pin.sym} 850 -820 0 1 {name=p28 sig_type=std_logic lab=vp}
C {lab_pin.sym} 860 -750 0 1 {name=p25 sig_type=std_logic lab=vp}
C {lab_pin.sym} 840 -630 0 1 {name=p29 sig_type=std_logic lab=gd}
C {lab_pin.sym} 1020 -630 0 1 {name=p30 sig_type=std_logic lab=gd}
C {sg13g2_pr/sg13_lv_pmos.sym} 1150 -370 0 0 {name=M19
l=0.15u
w=3u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 1170 -440 0 1 {name=p31 sig_type=std_logic lab=vp}
C {vsource.sym} 1410 -740 0 0 {name=Viup
value=0 savecurrent=false}
C {vsource.sym} 1410 -260 0 0 {name=Vidn
value=0 savecurrent=false}
C {vsource.sym} 1170 -720 0 0 {name=Viup1
value=0 savecurrent=false}
C {vsource.sym} 1170 -270 0 0 {name=Vidn1
value=0 savecurrent=false}
C {lab_pin.sym} 1010 -370 0 0 {name=p1 sig_type=std_logic lab=iref}
