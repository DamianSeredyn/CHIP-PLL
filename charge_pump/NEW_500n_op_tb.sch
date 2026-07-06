v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 850 -350 850 -330 {lab=vout}
N 610 -350 640 -350 {lab=vp}
N 610 -330 640 -330 {lab=up}
N 610 -310 640 -310 {lab=vout}
N 610 -290 640 -290 {lab=dn}
N 610 -270 640 -270 {lab=0}
C {vsource.sym} 620 -500 0 0 {name=Vvp
value=1.2 savecurrent=false}
C {gnd.sym} 620 -470 0 0 {name=l16 lab=0}
C {lab_pin.sym} 620 -530 0 0 {name=p47 sig_type=std_logic lab=vp}
C {devices/code_shown.sym} 10 -440 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} 60 -350 0 0 {name=NGSPICE only_toplevel=true 
value="
.temp 25

.control

op
save all
write mirror_test.raw
set appendwrite
show all
.endc
"}
C {capa.sym} 850 -300 0 0 {name=C1
m=1
value=5p
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 850 -270 0 0 {name=l14 lab=0}
C {lab_pin.sym} 850 -350 2 0 {name=p18 sig_type=std_logic lab=vout}
C {vsource.sym} 410 -500 0 0 {name=Vup2
value=1 savecurrent=false}
C {gnd.sym} 410 -470 0 0 {name=l11 lab=0}
C {vsource.sym} 510 -500 0 0 {name=Vdn2
value=0 savecurrent=false}
C {gnd.sym} 510 -470 0 0 {name=l12 lab=0}
C {lab_pin.sym} 410 -530 0 1 {name=p30 sig_type=std_logic lab=up}
C {lab_pin.sym} 510 -530 0 1 {name=p31 sig_type=std_logic lab=dn}
C {vsource.sym} 790 -300 0 0 {name=Vup1
value=0.8 savecurrent=false}
C {gnd.sym} 790 -270 0 0 {name=l3 lab=0}
C {lab_pin.sym} 790 -330 0 1 {name=p22 sig_type=std_logic lab=vout}
C {/foss/designs/CHIP-PLL/charge_pump/NEW_500n_cp_cell.sym} 460 -310 0 0 {name=x1}
C {gnd.sym} 640 -270 0 0 {name=l1 lab=0}
C {lab_pin.sym} 640 -310 0 1 {name=p1 sig_type=std_logic lab=vout}
C {lab_pin.sym} 640 -330 0 1 {name=p2 sig_type=std_logic lab=up}
C {lab_pin.sym} 640 -290 0 1 {name=p3 sig_type=std_logic lab=dn}
C {lab_pin.sym} 640 -350 0 1 {name=p4 sig_type=std_logic lab=vp}
