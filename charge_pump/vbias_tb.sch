v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -320 90 -180 90 {lab=vb}
N -320 -250 -320 -190 {lab=#net1}
N -320 -250 -240 -250 {lab=#net1}
N -240 -250 -240 40 {lab=#net1}
N -320 50 -240 40 {lab=#net1}
C {vsource.sym} -320 -160 0 0 {name=Vp
value=1.08 savecurrent=false}
C {gnd.sym} -320 -130 0 0 {name=l3 lab=0}
C {lab_pin.sym} -180 90 0 1 {name=p4 sig_type=std_logic lab=vb}
C {devices/code_shown.sym} 90 -450 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} -120 -230 0 0 {name=NGSPICE only_toplevel=true 
value="
.temp -25
.control

.param rsh_rppd = 500

dc Vvp 0 1.32 0.01
plot v(vb)
save all
write vbias.raw
set appendwrite
show all
.endc
"}
C {gnd.sym} -320 70 0 0 {name=l5 lab=0}
C {/foss/designs/CHIP-PLL/charge_pump/vbias.sym} -470 70 0 0 {name=x1}
C {devices/code_shown.sym} -590 190 0 0 {name=MODEL1 only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_ss
.include /foss/pdks/ihp-sg13g2/libs.tech/ngspice/models/resistors_mod.lib
"}
