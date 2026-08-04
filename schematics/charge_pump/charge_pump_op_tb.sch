v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -20 -200 -20 -180 {lab=vout}
N -260 -200 -230 -200 {lab=vp}
N -260 -180 -230 -180 {lab=up}
N -260 -160 -230 -160 {lab=vout}
N -260 -140 -230 -140 {lab=dn}
N -260 -120 -230 -120 {lab=0}
C {vsource.sym} -250 -350 0 0 {name=Vvp
value=1.2 savecurrent=false}
C {gnd.sym} -250 -320 0 0 {name=l16 lab=0}
C {lab_pin.sym} -250 -380 0 0 {name=p47 sig_type=std_logic lab=vp}
C {devices/code_shown.sym} -810 -200 0 0 {name=NGSPICE only_toplevel=true 
value="
.temp 25

.control

op
save all
write aa_cp_lay_op.raw
set appendwrite
show all
.endc
"}
C {capa.sym} -20 -150 0 0 {name=C1
m=1
value=10p
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} -20 -120 0 0 {name=l14 lab=0}
C {lab_pin.sym} -20 -200 2 0 {name=p18 sig_type=std_logic lab=vout}
C {vsource.sym} -460 -350 0 0 {name=Vup2
value=1 savecurrent=false}
C {gnd.sym} -460 -320 0 0 {name=l11 lab=0}
C {vsource.sym} -360 -350 0 0 {name=Vdn2
value=1 savecurrent=false}
C {gnd.sym} -360 -320 0 0 {name=l12 lab=0}
C {lab_pin.sym} -460 -380 0 1 {name=p30 sig_type=std_logic lab=up}
C {lab_pin.sym} -360 -380 0 1 {name=p31 sig_type=std_logic lab=dn}
C {vsource.sym} -80 -150 0 0 {name=Vup1
value=0.6 savecurrent=false}
C {gnd.sym} -80 -120 0 0 {name=l3 lab=0}
C {lab_pin.sym} -80 -180 0 1 {name=p22 sig_type=std_logic lab=vout}
C {gnd.sym} -230 -120 0 0 {name=l1 lab=0}
C {lab_pin.sym} -230 -160 0 1 {name=p1 sig_type=std_logic lab=vout}
C {lab_pin.sym} -230 -180 0 1 {name=p2 sig_type=std_logic lab=up}
C {lab_pin.sym} -230 -140 0 1 {name=p3 sig_type=std_logic lab=dn}
C {lab_pin.sym} -230 -200 0 1 {name=p4 sig_type=std_logic lab=vp}
C {/foss/designs/CHIP-PLL/schematics/charge_pump/charge_pump_cell.sym} -410 -160 0 0 {name=x1}
C {devices/code_shown.sym} -530 -50 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
.lib cornerRES.lib res_typ



"}
