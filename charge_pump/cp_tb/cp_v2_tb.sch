v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 180 -870 180 -830 {lab=vp}
N 640 -870 900 -870 {lab=vp}
N 900 -870 900 -830 {lab=vp}
N 640 -870 640 -830 {lab=vp}
N 420 -870 640 -870 {lab=vp}
N 420 -870 420 -830 {lab=vp}
N 180 -870 420 -870 {lab=vp}
N 420 -800 430 -800 {lab=vp}
N 430 -830 430 -800 {lab=vp}
N 420 -830 430 -830 {lab=vp}
N 630 -800 640 -800 {lab=vp}
N 630 -830 630 -800 {lab=vp}
N 630 -830 640 -830 {lab=vp}
N 170 -800 180 -800 {lab=vp}
N 170 -830 170 -800 {lab=vp}
N 170 -830 180 -830 {lab=vp}
N 180 -770 180 -700 {lab=#net1}
N 180 -770 220 -770 {lab=#net1}
N 220 -800 220 -770 {lab=#net1}
N 220 -800 380 -800 {lab=#net1}
N 900 -830 910 -830 {lab=vp}
N 910 -830 910 -800 {lab=vp}
N 900 -800 910 -800 {lab=vp}
N 680 -800 860 -800 {lab=#net2}
N 900 -770 900 -540 {lab=#net2}
N 860 -800 860 -770 {lab=#net2}
N 860 -770 900 -770 {lab=#net2}
N 900 -510 910 -510 {lab=0}
N 910 -510 910 -480 {lab=0}
N 900 -480 910 -480 {lab=0}
N 900 -410 900 -390 {lab=vp}
N 900 -330 900 -150 {lab=#net3}
N 900 -360 910 -360 {lab=vp}
N 910 -390 910 -360 {lab=vp}
N 900 -390 910 -390 {lab=vp}
N 900 -120 910 -120 {lab=0}
N 910 -120 910 -90 {lab=0}
N 900 -90 910 -90 {lab=0}
N 680 -120 860 -120 {lab=#net3}
N 860 -150 860 -120 {lab=#net3}
N 860 -150 900 -150 {lab=#net3}
N 680 -240 740 -240 {lab=dn}
N 220 -120 380 -120 {lab=#net4}
N 180 -230 180 -150 {lab=#net4}
N 180 -310 180 -290 {lab=vp}
N 220 -150 220 -120 {lab=#net4}
N 180 -150 220 -150 {lab=#net4}
N 330 -300 380 -300 {lab=dn}
N 420 -120 430 -120 {lab=0}
N 430 -120 430 -90 {lab=0}
N 420 -90 430 -90 {lab=0}
N 630 -120 640 -120 {lab=0}
N 630 -120 630 -90 {lab=0}
N 630 -90 640 -90 {lab=0}
N 420 -300 430 -300 {lab=0}
N 630 -240 640 -240 {lab=0}
N 640 -360 860 -360 {lab=vout}
N 420 -360 420 -330 {lab=vout}
N 640 -360 640 -270 {lab=vout}
N 420 -360 640 -360 {lab=vout}
N 640 -550 640 -510 {lab=vout}
N 420 -550 420 -510 {lab=vout}
N 420 -510 640 -510 {lab=vout}
N 640 -510 860 -510 {lab=vout}
N 340 -430 420 -430 {lab=vout}
N 640 -770 640 -610 {lab=#net5}
N 420 -580 430 -580 {lab=vp}
N 630 -580 640 -580 {lab=vp}
N 330 -580 380 -580 {lab=upb}
N 680 -580 730 -580 {lab=upb}
N 640 -210 640 -150 {lab=#net6}
N 170 -90 180 -90 {lab=0}
N 170 -120 170 -90 {lab=0}
N 170 -120 180 -120 {lab=0}
N 420 -510 420 -430 {lab=vout}
N 420 -430 420 -360 {lab=vout}
N 420 -270 420 -150 {lab=#net7}
N 420 -770 420 -610 {lab=#net8}
C {sg13g2_pr/sg13_lv_pmos.sym} 200 -800 0 1 {name=M3
l=0.13u
w=2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 400 -800 0 0 {name=M1
l=0.13u
w=2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 660 -800 0 1 {name=M2
l=0.13u
w=2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 880 -800 0 0 {name=M4
l=0.13u
w=2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 660 -580 0 1 {name=M5
l=0.13u
w=2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 400 -580 0 0 {name=M6
l=0.13u
w=2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 880 -510 0 0 {name=M18
l=0.13u
w=2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 880 -360 0 0 {name=M7
l=0.13u
w=2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 880 -120 0 0 {name=M8
l=0.13u
w=2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 400 -300 0 0 {name=M9
l=0.13u
w=2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 400 -120 0 0 {name=M10
l=0.13u
w=2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 660 -240 0 1 {name=M11
l=0.13u
w=2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 660 -120 0 1 {name=M12
l=0.13u
w=2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 200 -120 0 1 {name=M14
l=0.13u
w=2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {isource.sym} 180 -670 0 0 {name=Ichar value=50e-06}
C {gnd.sym} 180 -640 0 0 {name=l11 lab=0}
C {gnd.sym} 900 -480 0 0 {name=l1 lab=0}
C {lab_pin.sym} 520 -870 0 0 {name=p47 sig_type=std_logic lab=vp}
C {lab_pin.sym} 900 -410 0 0 {name=p1 sig_type=std_logic lab=vp}
C {gnd.sym} 900 -90 0 0 {name=l2 lab=0}
C {lab_pin.sym} 740 -240 0 1 {name=p2 sig_type=std_logic lab=dn}
C {gnd.sym} 640 -90 0 0 {name=l3 lab=0}
C {gnd.sym} 420 -90 0 0 {name=l4 lab=0}
C {gnd.sym} 180 -90 0 0 {name=l5 lab=0}
C {isource.sym} 180 -260 0 0 {name=Idisch value=50e-06}
C {lab_pin.sym} 180 -310 0 0 {name=p3 sig_type=std_logic lab=vp}
C {lab_pin.sym} 330 -300 0 0 {name=p4 sig_type=std_logic lab=dn}
C {gnd.sym} 430 -300 0 0 {name=l6 lab=0}
C {gnd.sym} 630 -240 0 0 {name=l7 lab=0}
C {lab_pin.sym} 340 -430 0 0 {name=p5 sig_type=std_logic lab=vout}
C {lab_pin.sym} 430 -580 0 0 {name=p6 sig_type=std_logic lab=vp}
C {lab_pin.sym} 630 -580 0 0 {name=p7 sig_type=std_logic lab=vp}
C {lab_pin.sym} 330 -580 0 0 {name=p8 sig_type=std_logic lab=upb}
C {lab_pin.sym} 730 -580 0 1 {name=p9 sig_type=std_logic lab=upb}
C {capa.sym} 1110 -440 0 0 {name=C1
m=1
value=10p
ic=0.6
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 1110 -410 0 0 {name=l14 lab=0}
C {lab_pin.sym} 1110 -470 0 1 {name=p24 sig_type=std_logic lab=vout}
C {vsource.sym} 180 -1040 0 0 {name=vvp
value=1.2 savecurrent=false}
C {gnd.sym} 180 -1010 0 0 {name=l16 lab=0}
C {lab_pin.sym} 180 -1070 0 0 {name=p10 sig_type=std_logic lab=vp}
C {devices/code_shown.sym} 1160 -1020 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} 1160 -690 0 0 {name=NGSPICE1 only_toplevel=true 
value="
.param temp=27
.control
tran 0.01 80n
plot v(vout) v(dn)
show all
.end
"}
C {vsource.sym} 400 -1040 0 0 {name=vupb1
value=1.2 savecurrent=false}
C {gnd.sym} 400 -1010 0 0 {name=l8 lab=0}
C {vsource.sym} 760 -1040 0 0 {name=vdn1
value="PULSE(0 1.2 0 10p 10p 1.5n 6.67n)" savecurrent=false}
C {gnd.sym} 760 -1010 0 0 {name=l9 lab=0}
C {lab_pin.sym} 400 -1070 0 1 {name=p11 sig_type=std_logic lab=upb}
C {lab_pin.sym} 760 -1070 0 1 {name=p12 sig_type=std_logic lab=dn}
