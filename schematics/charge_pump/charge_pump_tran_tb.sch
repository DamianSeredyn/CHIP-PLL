v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 10 -60 10 -40 {lab=vout}
N -450 -150 -390 -150 {lab=vp}
N -450 -130 -390 -130 {lab=up}
N -450 -110 -80 -110 {lab=vout}
N -450 -90 -370 -90 {lab=dn}
N -450 -70 -410 -70 {lab=0}
N -160 -40 -160 -20 {lab=0}
N -230 -80 -200 -80 {lab=rst}
N -160 -80 -140 -80 {lab=0}
N -140 -80 -140 -40 {lab=0}
N -160 -40 -140 -40 {lab=0}
N -160 -50 -160 -40 {lab=0}
C {vsource.sym} -1120 -80 0 0 {name=Vvp
value=\{Vp\} savecurrent=false}
C {gnd.sym} -1120 -50 0 0 {name=l16 lab=0}
C {lab_pin.sym} -1120 -110 0 0 {name=p47 sig_type=std_logic lab=vp}
C {devices/code_shown.sym} -1010 -410 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
.include /foss/pdks/ihp-sg13cmos5l/libs.tech/ngspice/models/resistors_mod.lib




"}
C {capa.sym} 10 -10 0 0 {name=C1
m=1
value=5p
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 10 20 0 0 {name=l14 lab=0}
C {lab_pin.sym} 10 -60 2 0 {name=p18 sig_type=std_logic lab=vout}
C {vsource.sym} -1000 -80 0 0 {name=Vup2
value="PULSE(0 1.2 5u 10p 10p 5u 20u)" savecurrent=false}
C {gnd.sym} -1000 -50 0 0 {name=l11 lab=0}
C {vsource.sym} -1000 30 0 0 {name=Vdn2
value="PULSE(0 1.2 15u 10p 10p 5u 20u)" savecurrent=false}
C {gnd.sym} -1000 60 0 0 {name=l12 lab=0}
C {lab_pin.sym} -1000 -110 0 1 {name=p30 sig_type=std_logic lab=up}
C {lab_pin.sym} -1000 0 0 1 {name=p31 sig_type=std_logic lab=dn}
C {devices/code_shown.sym} -1250 -490 0 0 {name=NGSPICE1 only_toplevel=true 
value="
.temp -40
.param Vp=1.08
.param rsh_rppd = 509
.control

tran 10n 300u

wrdata cp_test.txt v(vout) v(x1.bias)
write aa_cp_tran.raw

set filetype=ascii

set appendwrite
.endc
"}
C {gnd.sym} -410 -70 0 0 {name=l1 lab=0}
C {lab_pin.sym} -370 -90 0 1 {name=p1 sig_type=std_logic lab=dn}
C {lab_pin.sym} -390 -130 0 1 {name=p2 sig_type=std_logic lab=up}
C {lab_pin.sym} -390 -150 0 0 {name=p3 sig_type=std_logic lab=vp}
C {lab_pin.sym} -80 -110 2 0 {name=p4 sig_type=std_logic lab=vout}
C {gnd.sym} -160 -20 0 0 {name=l2 lab=0}
C {lab_pin.sym} -230 -80 0 0 {name=p5 sig_type=std_logic lab=rst}
C {vsource.sym} -350 20 0 0 {name=Vrst
value="PULSE(0 1.2 0 1n 1n 5u 1)" savecurrent=false}
C {gnd.sym} -350 50 0 0 {name=l3 lab=0}
C {lab_pin.sym} -350 -10 0 0 {name=p6 sig_type=std_logic lab=rst}
C {/foss/designs/CHIP-PLL/charge_pump/charge_pump_cell.sym} -600 -110 0 0 {name=x1}
C {/foss/pdks/ihp-sg13cmos5l/libs.tech/xschem/sg13cmos5l_pr/sg13_lv_nmos.sym} -180 -80 0 0 {name=M2
l=0.6u
w=2.5u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
