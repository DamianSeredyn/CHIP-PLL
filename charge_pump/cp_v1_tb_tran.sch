v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 650 -140 650 -110 {lab=vout}
N 480 -180 510 -180 {lab=vp}
N 480 -160 510 -160 {lab=vout}
N 480 -140 510 -140 {lab=0}
N 150 -120 180 -120 {lab=dn}
N 150 -140 180 -140 {lab=dnb}
N 150 -160 180 -160 {lab=upb}
N 150 -180 180 -180 {lab=up}
C {vsource.sym} 100 -570 0 0 {name=Vvp
value=\{Vp\} savecurrent=false}
C {gnd.sym} 100 -540 0 0 {name=l16 lab=0}
C {lab_pin.sym} 100 -600 0 0 {name=p47 sig_type=std_logic lab=vp}
C {devices/code_shown.sym} 920 -560 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} 930 -410 0 0 {name=NGSPICE only_toplevel=true 
value="
.param temp=27
.param l=0.15u
.param Vp=1.2
.control

tran 100p 20u
save all
plot v(vout)
write cp_test.raw
set appendwrite
show all
.endc
"}
C {vsource.sym} 260 -400 0 0 {name=Vup1
value="PULSE(\{Vp\} 0 0 10p 10p 20u 50u)" savecurrent=false}
C {gnd.sym} 260 -370 0 0 {name=l2 lab=0}
C {vsource.sym} 620 -400 0 0 {name=Vdn1
value="PULSE(\{Vp\} 0 30u 10p 10p 20u 50u)" savecurrent=false
}
C {gnd.sym} 620 -370 0 0 {name=l1 lab=0}
C {lab_pin.sym} 260 -430 0 1 {name=p4 sig_type=std_logic lab=up}
C {lab_pin.sym} 620 -430 0 1 {name=p5 sig_type=std_logic lab=dn}
C {capa.sym} 650 -80 0 0 {name=C1
m=1
value=5p
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 650 -50 0 0 {name=l14 lab=0}
C {lab_pin.sym} 650 -140 0 1 {name=p24 sig_type=std_logic lab=vout}
C {vsource.sym} 260 -510 0 0 {name=Vup2
value="PULSE(0 \{Vp\} 0 10p 10p 20u 50u)" savecurrent=false
}
C {gnd.sym} 260 -480 0 0 {name=l3 lab=0}
C {vsource.sym} 620 -510 0 0 {name=Vdn2
value="PULSE(0 \{Vp\} 30u 10p 10p 20u 50u)" savecurrent=false
}
C {gnd.sym} 620 -480 0 0 {name=l6 lab=0}
C {lab_pin.sym} 260 -540 0 1 {name=p11 sig_type=std_logic lab=upb}
C {lab_pin.sym} 620 -540 0 1 {name=p12 sig_type=std_logic lab=dnb}
C {lab_pin.sym} 150 -180 0 0 {name=p1 sig_type=std_logic lab=up}
C {lab_pin.sym} 150 -160 0 0 {name=p2 sig_type=std_logic lab=upb}
C {lab_pin.sym} 150 -140 0 0 {name=p6 sig_type=std_logic lab=dnb}
C {lab_pin.sym} 150 -120 0 0 {name=p7 sig_type=std_logic lab=dn}
C {lab_pin.sym} 510 -180 0 1 {name=p9 sig_type=std_logic lab=vp}
C {lab_pin.sym} 510 -160 0 1 {name=p10 sig_type=std_logic lab=vout}
C {gnd.sym} 510 -140 0 0 {name=l7 lab=0}
C {/foss/designs/CHIP-PLL/charge_pump/cp_v1_no_mirror.sym} 330 -150 0 0 {name=x1}
