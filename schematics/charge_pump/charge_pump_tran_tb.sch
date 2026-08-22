v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 10 -60 10 -40 {lab=vout}
N -790 -140 -750 -140 {lab=up}
N -790 -80 -750 -80 {lab=dn}
N -610 -40 -610 -20 {lab=0}
N -610 -190 -610 -180 {lab=vp}
N -120 -110 -80 -110 {lab=vout}
N -360 -400 -330 -400 {lab=vtest}
N -290 -450 -290 -430 {lab=vp}
N -290 -400 -270 -400 {lab=vp}
N -270 -450 -270 -400 {lab=vp}
N -290 -450 -270 -450 {lab=vp}
N -350 -260 -330 -260 {lab=vtest}
N -290 -260 -280 -260 {lab=0}
N -290 -480 -290 -450 {lab=vp}
N -290 -310 -290 -290 {lab=vtest}
N -290 -230 -290 -190 {lab=0}
N -350 -310 -350 -260 {lab=vtest}
N -350 -310 -290 -310 {lab=vtest}
N -290 -330 -290 -310 {lab=vtest}
N -290 -330 -120 -330 {lab=vtest}
N -290 -350 -290 -330 {lab=vtest}
N -180 -260 -160 -260 {lab=rst}
N -120 -330 -120 -290 {lab=vtest}
N -120 -220 -120 -110 {lab=vout}
N -120 -260 -110 -260 {lab=vout}
N -110 -260 -110 -220 {lab=vout}
N -120 -220 -110 -220 {lab=vout}
N -120 -230 -120 -220 {lab=vout}
N -360 -400 -360 -350 {lab=vtest}
N -360 -350 -290 -350 {lab=vtest}
N -290 -370 -290 -350 {lab=vtest}
N -450 -110 -120 -110 {lab=vout}
C {vsource.sym} -1120 -80 0 0 {name=Vvp
value=\{Vp\} savecurrent=false}
C {gnd.sym} -1120 -50 0 0 {name=l16 lab=0}
C {lab_pin.sym} -1120 -110 0 0 {name=p47 sig_type=std_logic lab=vp}
C {devices/code_shown.sym} -1010 -410 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
.lib cornerRES.lib res_typ



"}
C {capa.sym} 10 -10 0 0 {name=C1
m=1
value=10p
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 10 20 0 0 {name=l14 lab=0}
C {lab_pin.sym} 10 -60 2 0 {name=p18 sig_type=std_logic lab=vout}
C {vsource.sym} -960 -60 0 0 {name=Vup2
value="PULSE(0 1.2 5u 10p 10p 5u 20u)" savecurrent=false}
C {gnd.sym} -960 -30 0 0 {name=l11 lab=0}
C {vsource.sym} -960 50 0 0 {name=Vdn2
value="PULSE(0 1.2 15u 10p 10p 5u 20u)" savecurrent=false}
C {gnd.sym} -960 80 0 0 {name=l12 lab=0}
C {devices/code_shown.sym} -1250 -490 0 0 {name=NGSPICE1 only_toplevel=true 
value="
.temp 25
.param Vp=1.2

.control

tran 10n 100u
plot v(vout) v(rst)
wrdata cp_test.txt v(vout) v(x1.bias)
write aa_cp_tran.raw

set filetype=ascii

set appendwrite
.endc
"}
C {lab_pin.sym} -790 -80 0 0 {name=p1 sig_type=std_logic lab=dn}
C {lab_pin.sym} -790 -140 0 0 {name=p2 sig_type=std_logic lab=up}
C {lab_pin.sym} -80 -110 2 0 {name=p4 sig_type=std_logic lab=vout}
C {vsource.sym} -300 60 0 0 {name=Vrst
value="PULSE(0 1.2 0 1n 1n 40u 1)" savecurrent=false}
C {gnd.sym} -300 90 0 0 {name=l3 lab=0}
C {lab_pin.sym} -300 30 0 0 {name=p6 sig_type=std_logic lab=rst}
C {/foss/designs/CHIP-PLL/schematics/charge_pump/charge_pump_cell.sym} -600 -110 0 0 {name=x1}
C {lab_pin.sym} -960 -90 0 1 {name=p7 sig_type=std_logic lab=up}
C {lab_pin.sym} -960 20 0 1 {name=p8 sig_type=std_logic lab=dn}
C {gnd.sym} -610 -20 0 0 {name=l8 lab=0}
C {lab_pin.sym} -610 -190 0 0 {name=p9 sig_type=std_logic lab=vp}
C {/foss/pdks/ihp-sg13cmos5l/libs.tech/xschem/sg13cmos5l_pr/sg13_lv_pmos.sym} -310 -400 0 0 {name=M1
l=1.8u
w=1.8u
ng=1
m=1
mm_ok=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} -180 -260 0 0 {name=p10 sig_type=std_logic lab=rst}
C {lab_pin.sym} -290 -480 0 0 {name=p11 sig_type=std_logic lab=vp}
C {lab_pin.sym} -290 -350 2 0 {name=p12 sig_type=std_logic lab=vtest}
C {/foss/pdks/ihp-sg13cmos5l/libs.tech/xschem/sg13cmos5l_pr/sg13_lv_nmos.sym} -310 -260 0 0 {name=M3
l=1.8u
w=0.6u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {gnd.sym} -280 -260 0 0 {name=l1 lab=0}
C {gnd.sym} -290 -190 0 0 {name=l4 lab=0}
C {/foss/pdks/ihp-sg13cmos5l/libs.tech/xschem/sg13cmos5l_pr/sg13_lv_pmos.sym} -140 -260 0 0 {name=M4
l=0.6u
w=1.8u
ng=1
m=1
mm_ok=1
model=sg13_lv_pmos
spiceprefix=X
}
