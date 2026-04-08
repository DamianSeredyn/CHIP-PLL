v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 180 -920 180 -880 {lab=vp}
N 420 -920 420 -880 {lab=vp}
N 180 -920 420 -920 {lab=vp}
N 420 -850 430 -850 {lab=vp}
N 430 -880 430 -850 {lab=vp}
N 420 -880 430 -880 {lab=vp}
N 170 -850 180 -850 {lab=vp}
N 170 -880 170 -850 {lab=vp}
N 170 -880 180 -880 {lab=vp}
N 180 -820 180 -710 {lab=iref_p2}
N 180 -820 220 -820 {lab=iref_p2}
N 220 -850 220 -820 {lab=iref_p2}
N 220 -850 380 -850 {lab=iref_p2}
N 220 -170 380 -170 {lab=iref2}
N 180 -280 180 -200 {lab=iref2}
N 220 -200 220 -170 {lab=iref2}
N 180 -200 220 -200 {lab=iref2}
N 330 -350 380 -350 {lab=dn}
N 420 -170 430 -170 {lab=gd}
N 430 -170 430 -140 {lab=gd}
N 420 -140 430 -140 {lab=gd}
N 420 -350 430 -350 {lab=gd}
N 340 -480 420 -480 {lab=vout}
N 420 -630 430 -630 {lab=vp}
N 330 -630 380 -630 {lab=upb}
N 170 -140 180 -140 {lab=gd}
N 170 -170 170 -140 {lab=gd}
N 170 -170 180 -170 {lab=gd}
N 420 -320 420 -200 {lab=#net1}
N 420 -820 420 -660 {lab=#net2}
N 180 -140 180 -110 {lab=gd}
N 420 -140 420 -110 {lab=gd}
N 180 -110 420 -110 {lab=gd}
N 180 -420 190 -420 {lab=vp}
N 180 -440 180 -420 {lab=vp}
N 180 -420 180 -340 {lab=vp}
N 420 -480 420 -460 {lab=vout}
N 420 -500 420 -480 {lab=vout}
N 420 -600 420 -560 {lab=#net3}
N 420 -400 420 -380 {lab=#net4}
C {sg13g2_pr/sg13_lv_pmos.sym} 200 -850 0 1 {name=M3
l=\{l\}
w=\{wp\}
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 400 -850 0 0 {name=M1
l=\{l\}
w=\{wp\}
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 400 -630 0 0 {name=M6
l=\{l\}
w=\{wp\}
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 400 -350 0 0 {name=M9
l=\{l\}
w=\{wn\}
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 400 -170 0 0 {name=M10
l=\{l\}
w=\{wn\}
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 200 -170 0 1 {name=M14
l=\{l\}
w=\{wn\}
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 430 -630 0 0 {name=p6 sig_type=std_logic lab=vp}
C {iopin.sym} 420 -920 0 1 {name=p10 lab=vp
}
C {ipin.sym} 330 -630 0 0 {name=p11 lab=upb}
C {opin.sym} 340 -480 0 1 {name=p12 lab=vout
}
C {ipin.sym} 330 -350 0 0 {name=p4 lab=dn}
C {lab_pin.sym} 430 -350 0 1 {name=p8 sig_type=std_logic lab=gd}
C {lab_pin.sym} 180 -750 0 1 {name=p26 sig_type=std_logic lab=iref_p2}
C {lab_pin.sym} 180 -260 0 0 {name=p27 sig_type=std_logic lab=iref2}
C {isource.sym} 180 -680 0 0 {name=Itest1
value=25u savecurrent=false}
C {isource.sym} 180 -310 0 0 {name=Itest2
value=26.9u savecurrent=false}
C {lab_pin.sym} 180 -440 0 1 {name=p31 sig_type=std_logic lab=vp}
C {lab_pin.sym} 180 -650 0 0 {name=p3 sig_type=std_logic lab=gd}
C {iopin.sym} 280 -110 0 1 {name=p1 lab=gd
}
C {vsource.sym} 420 -430 0 0 {name=Vidn
value=0 savecurrent=false}
C {vsource.sym} 420 -530 0 0 {name=Viup
value=0 savecurrent=false}
