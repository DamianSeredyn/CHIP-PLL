v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -320 -640 -320 -620 {lab=vout}
N -780 -730 -720 -730 {lab=vp}
N -780 -710 -720 -710 {lab=up}
N -780 -690 -410 -690 {lab=vout}
N -780 -670 -700 -670 {lab=dn}
N -780 -650 -740 -650 {lab=0}
N -490 -620 -490 -600 {lab=0}
N -560 -660 -530 -660 {lab=rst}
N -490 -660 -470 -660 {lab=0}
N -470 -660 -470 -620 {lab=0}
N -490 -620 -470 -620 {lab=0}
N -490 -630 -490 -620 {lab=0}
C {vsource.sym} -1450 -660 0 0 {name=Vvp
value=\{Vp\} savecurrent=false}
C {gnd.sym} -1450 -630 0 0 {name=l16 lab=0}
C {lab_pin.sym} -1450 -690 0 0 {name=p47 sig_type=std_logic lab=vp}
C {devices/code_shown.sym} -1340 -990 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_ss
.include /foss/pdks/ihp-sg13g2/libs.tech/ngspice/models/resistors_mod.lib
"}
C {capa.sym} -320 -590 0 0 {name=C1
m=1
value=5p
ic=0.8
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} -320 -560 0 0 {name=l14 lab=0}
C {lab_pin.sym} -320 -640 2 0 {name=p18 sig_type=std_logic lab=vout}
C {vsource.sym} -1330 -660 0 0 {name=Vup2
value="PULSE(1.2 0 5u 10p 10p 5u 20u)" savecurrent=false}
C {gnd.sym} -1330 -630 0 0 {name=l11 lab=0}
C {vsource.sym} -1330 -550 0 0 {name=Vdn2
value="PULSE(0 1.2 15u 10p 10p 5u 20u)" savecurrent=false}
C {gnd.sym} -1330 -520 0 0 {name=l12 lab=0}
C {lab_pin.sym} -1330 -690 0 1 {name=p30 sig_type=std_logic lab=up}
C {lab_pin.sym} -1330 -580 0 1 {name=p31 sig_type=std_logic lab=dn}
C {devices/code_shown.sym} -1580 -1070 0 0 {name=NGSPICE1 only_toplevel=true 
value="
.temp -25
.param Vp=1.08
.param rsh_rhigh=1000
.control

op
tran 10n 300u
save all
wrdata cp_test.txt v(vout) v(x1.biasn) v(x1.biasp) i(v.x1.Viup) i(v.x1.Vidn)
write cp_test.raw

set filetype=ascii

set appendwrite
.endc
"}
C {/foss/designs/CHIP-PLL/charge_pump/NEW_500n_cp_cell.sym} -930 -690 0 0 {name=x1}
C {gnd.sym} -740 -650 0 0 {name=l1 lab=0}
C {lab_pin.sym} -700 -670 0 1 {name=p1 sig_type=std_logic lab=dn}
C {lab_pin.sym} -720 -710 0 1 {name=p2 sig_type=std_logic lab=up}
C {lab_pin.sym} -720 -730 0 0 {name=p3 sig_type=std_logic lab=vp}
C {lab_pin.sym} -410 -690 2 0 {name=p4 sig_type=std_logic lab=vout}
C {sg13g2_pr/sg13_lv_nmos.sym} -510 -660 0 0 {name=M1
l=0.15u
w=2.5u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {gnd.sym} -490 -600 0 0 {name=l2 lab=0}
C {lab_pin.sym} -560 -660 0 0 {name=p5 sig_type=std_logic lab=rst}
C {vsource.sym} -680 -560 0 0 {name=Vrst
value="PULSE(0 1.2 0 1n 1n 5u 1)" savecurrent=false}
C {gnd.sym} -680 -530 0 0 {name=l3 lab=0}
C {lab_pin.sym} -680 -590 0 0 {name=p6 sig_type=std_logic lab=rst}
