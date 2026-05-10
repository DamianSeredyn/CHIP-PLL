v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 110 -450 110 -410 {lab=vp}
N 270 -450 270 -410 {lab=vp}
N 110 -450 270 -450 {lab=vp}
N 270 -290 270 -270 {lab=#net1}
N 110 -210 110 -150 {lab=#net2}
N 170 -380 230 -380 {lab=#net3}
N 210 -240 230 -240 {lab=#net1}
N 170 -350 170 -330 {lab=#net3}
N 150 -380 170 -380 {lab=#net3}
N 110 -90 110 -50 {lab=0}
N 110 -50 270 -50 {lab=0}
N 270 -210 270 -50 {lab=0}
N 210 -290 210 -240 {lab=#net1}
N 150 -240 210 -240 {lab=#net1}
N 210 -290 270 -290 {lab=#net1}
N 270 -350 270 -290 {lab=#net1}
N 100 -380 110 -380 {lab=vp}
N 270 -380 280 -380 {lab=vp}
N 270 -240 280 -240 {lab=0}
N 100 -240 110 -240 {lab=0}
N 110 -350 110 -270 {lab=#net3}
N 110 -350 170 -330 {lab=#net3}
N 170 -350 420 -370 {lab=#net3}
N 170 -380 170 -350 {lab=#net3}
N 460 -410 460 -400 {lab=vp}
N 460 -370 470 -370 {lab=vp}
N 470 -410 470 -370 {lab=vp}
N 460 -410 470 -410 {lab=vp}
N 460 -420 460 -410 {lab=vp}
N 460 -340 460 -260 {lab=#net4}
N 460 -200 460 -150 {lab=vout}
N 550 -150 550 -120 {lab=vout}
C {sg13g2_pr/sg13_lv_pmos.sym} 130 -380 0 1 {name=M4
l=0.15u
w=2.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 250 -380 0 0 {name=M2
l=0.15u
w=3u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 130 -240 0 1 {name=M6
l=0.15u
w=3u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 250 -240 0 0 {name=M7
l=0.15u
w=2.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {res.sym} 110 -120 0 0 {name=R2
value=500
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 100 -380 0 0 {name=p7 sig_type=std_logic lab=vp}
C {lab_pin.sym} 280 -380 0 1 {name=p8 sig_type=std_logic lab=vp}
C {gnd.sym} 280 -240 0 0 {name=l7 lab=0}
C {gnd.sym} 100 -240 0 0 {name=l1 lab=0}
C {vsource.sym} 30 -610 0 0 {name=Vvp
value=1.2 savecurrent=false}
C {gnd.sym} 30 -580 0 0 {name=l16 lab=0}
C {lab_pin.sym} 30 -640 0 0 {name=p47 sig_type=std_logic lab=vp}
C {devices/code_shown.sym} 350 -860 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} 420 -680 0 0 {name=NGSPICE only_toplevel=true 
value="
.param temp=125
.param wp=2.5u
.param wn=1.6u
.param l=0.15u
.control

op
save all
write cr_src.raw
set appendwrite
show all
.endc
"}
C {vsource.sym} 460 -230 0 0 {name=Viref1
value=0 savecurrent=false}
C {lab_pin.sym} 200 -450 0 0 {name=p1 sig_type=std_logic lab=vp}
C {gnd.sym} 210 -50 0 0 {name=l2 lab=0}
C {sg13g2_pr/sg13_lv_pmos.sym} 440 -370 0 0 {name=M1
l=0.15u
w=4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 460 -420 0 0 {name=p2 sig_type=std_logic lab=vp}
C {lab_pin.sym} 460 -150 0 0 {name=p3 sig_type=std_logic lab=vout}
C {capa.sym} 550 -90 0 0 {name=C1
m=1
value=5p
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 550 -60 0 0 {name=l14 lab=0}
C {lab_pin.sym} 550 -150 0 1 {name=p24 sig_type=std_logic lab=vout}
C {vsource.sym} 630 -90 0 0 {name=Vout
value=0.1 savecurrent=false}
C {gnd.sym} 630 -60 0 0 {name=l3 lab=0}
C {lab_pin.sym} 630 -120 0 1 {name=p4 sig_type=std_logic lab=vout}
