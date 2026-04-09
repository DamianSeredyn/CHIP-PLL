v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 260 -520 260 -490 {lab=VH}
N 650 -520 650 -490 {lab=VH}
N 190 -460 220 -460 {lab=upb}
N 190 -360 220 -360 {lab=dnb}
N 690 -460 720 -460 {lab=up}
N 690 -360 720 -360 {lab=dn}
N 260 -330 260 -310 {lab=VF}
N 650 -330 650 -310 {lab=VF}
N 650 -410 890 -410 {lab=vout}
N 650 -430 650 -410 {lab=vout}
N 260 -460 270 -460 {lab=vp}
N 260 -360 270 -360 {lab=gd}
N 640 -460 650 -460 {lab=vp}
N 640 -360 650 -360 {lab=gd}
N 440 -310 650 -310 {lab=VF}
N 440 -520 650 -520 {lab=VH}
N 290 -430 300 -430 {lab=Vamp}
N 260 -410 260 -390 {lab=Vamp}
N 650 -410 650 -390 {lab=vout}
N 290 -410 300 -410 {lab=Vamp}
N 260 -430 260 -410 {lab=Vamp}
N 290 -430 290 -410 {lab=Vamp}
N 260 -410 290 -410 {lab=Vamp}
N 300 -390 300 -360 {lab=vout}
N 300 -360 600 -360 {lab=vout}
N 600 -390 600 -360 {lab=vout}
N 600 -390 640 -390 {lab=vout}
N 640 -410 640 -390 {lab=vout}
N 640 -410 650 -410 {lab=vout}
N 440 -310 440 -250 {lab=VF}
N 260 -310 440 -310 {lab=VF}
N 490 -80 530 -80 {lab=gd}
N 440 -590 440 -520 {lab=VH}
N 260 -520 440 -520 {lab=VH}
N 480 -620 570 -620 {lab=#net1}
N 440 -660 440 -650 {lab=#net2}
N 440 -730 440 -720 {lab=vp}
N 440 -730 800 -730 {lab=vp}
N 360 -730 440 -730 {lab=vp}
N 360 -730 360 -620 {lab=vp}
N 360 -620 440 -620 {lab=vp}
N 570 -560 570 -540 {lab=gd}
N 340 -220 400 -220 {lab=#net3}
N 340 -160 340 -140 {lab=gd}
N 440 -100 440 -80 {lab=gd}
N 440 -190 440 -160 {lab=#net4}
N 440 -220 490 -220 {lab=gd}
N 490 -220 490 -80 {lab=gd}
N 440 -80 490 -80 {lab=gd}
C {sg13g2_pr/sg13_lv_pmos.sym} 240 -460 0 0 {name=M8
l=0.15u
w=2u
ng=1
m=4
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 670 -460 0 1 {name=M9
l=0.15u
w=2u
ng=1
m=4
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 240 -360 0 0 {name=M10
l=0.15u
w=1.8u
ng=1
m=3
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 670 -360 0 1 {name=M11
l=0.15u
w=1.8u
ng=1
m=3
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_wire.sym} 610 -310 0 0 {name=p4 sig_type=std_logic lab=VF}
C {lab_wire.sym} 560 -520 0 0 {name=p7 sig_type=std_logic lab=VH}
C {lab_pin.sym} 270 -460 2 0 {name=p37 sig_type=std_logic lab=vp}
C {lab_pin.sym} 640 -460 2 1 {name=p38 sig_type=std_logic lab=vp}
C {lab_pin.sym} 260 -410 0 0 {name=p1 sig_type=std_logic lab=Vamp}
C {ipin.sym} 190 -460 0 0 {name=p19 lab=upb}
C {ipin.sym} 190 -360 0 0 {name=p13 lab=dnb}
C {ipin.sym} 720 -460 0 1 {name=p14 lab=up}
C {ipin.sym} 720 -360 0 1 {name=p15 lab=dn}
C {iopin.sym} 510 -730 0 0 {name=p16 lab=vp}
C {iopin.sym} 530 -80 0 0 {name=p20 lab=gd}
C {lab_pin.sym} 640 -360 0 0 {name=p31 sig_type=std_logic lab=gd}
C {lab_pin.sym} 270 -360 0 1 {name=p32 sig_type=std_logic lab=gd}
C {opin.sym} 890 -410 0 1 {name=p8 lab=vout}
C {lab_pin.sym} 600 -430 2 0 {name=p2 sig_type=std_logic lab=vp}
C {lab_pin.sym} 600 -410 2 0 {name=p18 sig_type=std_logic lab=gd}
C {/foss/designs/CHIP-PLL/charge_pump/amp_sz.sym} 450 -410 0 0 {name=x1}
C {sg13g2_pr/sg13_lv_pmos.sym} 460 -620 0 1 {name=M1
l=0.15u
w=2u
ng=1
m=2
model=sg13_lv_pmos
spiceprefix=X
}
C {vsource.sym} 440 -690 0 0 {name=Iup
value=0 savecurrent=false}
C {vsource.sym} 570 -590 0 0 {name=Vvp1
value=0.6 savecurrent=false}
C {lab_pin.sym} 570 -540 2 0 {name=p3 sig_type=std_logic lab=gd}
C {sg13g2_pr/sg13_lv_nmos.sym} 420 -220 0 0 {name=M2
l=0.15u
w=1.8u
ng=1
m=3
model=sg13_lv_nmos
spiceprefix=X
}
C {vsource.sym} 340 -190 0 0 {name=Vvp2
value=0.6 savecurrent=false}
C {lab_pin.sym} 340 -140 2 0 {name=p5 sig_type=std_logic lab=gd}
C {vsource.sym} 440 -130 0 0 {name=Idown
value=0 savecurrent=false}
