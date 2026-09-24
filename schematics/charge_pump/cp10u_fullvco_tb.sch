v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 610 -120 730 -120 {lab=vco_in}
N 510 -20 510 10 {lab=#net1}
N 510 -120 510 -80 {lab=vco_in}
N 390 -120 510 -120 {lab=vco_in}
N 510 70 510 100 {lab=0}
N 610 20 610 100 {lab=0}
N 510 100 610 100 {lab=0}
N 610 -120 610 -40 {lab=vco_in}
N 510 -120 610 -120 {lab=vco_in}
N 1190 -210 1370 -210 {lab=voutvco}
N 600 -500 1090 -500 {lab=0}
N 1090 -580 1090 -560 {lab=f5}
N 1030 -580 1030 -560 {lab=f4}
N 980 -580 980 -560 {lab=f3}
N 920 -580 920 -560 {lab=f2}
N 860 -580 860 -560 {lab=f1}
N 810 -580 810 -560 {lab=f0}
N 730 -580 730 -560 {lab=c2}
N 670 -580 670 -560 {lab=c1}
N 600 -580 600 -560 {lab=c0}
N 700 -300 730 -300 {lab=c0}
N 700 -280 730 -280 {lab=c1}
N 700 -260 730 -260 {lab=c2}
N 700 -240 730 -240 {lab=f0}
N 700 -220 730 -220 {lab=f1}
N 700 -200 730 -200 {lab=f2}
N 700 -180 730 -180 {lab=f3}
N 700 -160 730 -160 {lab=f4}
N 700 -140 730 -140 {lab=f5}
N 1370 -140 1370 -90 {lab=0}
N 1370 -210 1370 -200 {lab=voutvco}
C {res.sym} 510 -50 0 0 {name=R2
value=50k
footprint=1206
device=resistor
m=1}
C {capa.sym} 510 40 0 0 {name=C1
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 610 -10 0 0 {name=C2
m=1
value=50p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 240 -30 0 0 {name=l8 lab=0}
C {gnd.sym} 560 100 0 0 {name=l1 lab=0}
C {devices/code_shown.sym} 90 -480 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
.lib cornerRES.lib res_typ



"}
C {devices/code_shown.sym} -150 -560 0 0 {name=NGSPICE1 only_toplevel=true 
value="
.temp 25
.param Vp=1.2

.control

tran 50n 50u
plot v(voutvco) v(rst) v(vco_in)
wrdata cp_vco_tb.txt v(voutvco) v(vco_in)
write aa_cp_vco.raw

set filetype=ascii

set appendwrite
.endc
"}
C {vsource.sym} -140 -20 0 0 {name=Vvp
value=\{Vp\} savecurrent=false}
C {gnd.sym} -140 10 0 0 {name=l16 lab=0}
C {lab_pin.sym} -140 -50 0 0 {name=p47 sig_type=std_logic lab=vp}
C {vsource.sym} -30 30 0 0 {name=Vup2
value=1 savecurrent=false}
C {gnd.sym} -30 60 0 0 {name=l11 lab=0}
C {vsource.sym} -30 140 0 0 {name=Vdn2
value=0 savecurrent=false}
C {lab_pin.sym} -30 0 0 1 {name=p7 sig_type=std_logic lab=up}
C {lab_pin.sym} -30 110 0 1 {name=p8 sig_type=std_logic lab=dn}
C {gnd.sym} -30 170 0 0 {name=l2 lab=0}
C {lab_pin.sym} 240 -190 0 0 {name=p1 sig_type=std_logic lab=vp}
C {lab_pin.sym} 950 -390 0 0 {name=p2 sig_type=std_logic lab=vp}
C {gnd.sym} 950 -30 0 0 {name=l3 lab=0}
C {lab_pin.sym} 1370 -210 0 1 {name=p3 sig_type=std_logic lab=voutvco}
C {vsource.sym} 600 -530 0 0 {name=Vvp1
value=1.2 savecurrent=false}
C {vsource.sym} 670 -530 0 0 {name=Vvp2
value=0 savecurrent=false}
C {vsource.sym} 730 -530 0 0 {name=Vvp3
value=0 savecurrent=false}
C {vsource.sym} 810 -530 0 0 {name=Vvp4
value=0 savecurrent=false}
C {vsource.sym} 860 -530 0 0 {name=Vvp5
value=0 savecurrent=false}
C {vsource.sym} 920 -530 0 0 {name=Vvp6
value=1.2 savecurrent=false}
C {vsource.sym} 980 -530 0 0 {name=Vvp7
value=0 savecurrent=false}
C {vsource.sym} 1030 -530 0 0 {name=Vvp8
value=0 savecurrent=false}
C {gnd.sym} 770 -500 0 0 {name=l4 lab=0}
C {lab_pin.sym} 90 -140 0 0 {name=p23 sig_type=std_logic lab=up}
C {lab_pin.sym} 90 -80 0 0 {name=p24 sig_type=std_logic lab=dn}
C {vsource.sym} 250 120 0 0 {name=Vrst
value="PULSE(1.2 0 0 1n 1n 2u 1)" savecurrent=false}
C {gnd.sym} 250 150 0 0 {name=l5 lab=0}
C {lab_pin.sym} 250 90 0 1 {name=p25 sig_type=std_logic lab=rst}
C {lab_pin.sym} 390 -80 0 1 {name=p26 sig_type=std_logic lab=rst}
C {vsource.sym} 1090 -530 0 0 {name=Vvp9
value=0 savecurrent=false}
C {lab_pin.sym} 440 -120 0 1 {name=p28 sig_type=std_logic lab=vco_in}
C {lab_wire.sym} 700 -300 2 1 {name=p4 sig_type=std_logic lab=c0}
C {lab_wire.sym} 700 -280 2 1 {name=p6 sig_type=std_logic lab=c1}
C {lab_wire.sym} 700 -260 2 1 {name=p10 sig_type=std_logic lab=c2}
C {lab_wire.sym} 700 -240 2 1 {name=p12 sig_type=std_logic lab=f0}
C {lab_wire.sym} 700 -220 2 1 {name=p18 sig_type=std_logic lab=f1}
C {lab_wire.sym} 700 -200 2 1 {name=p19 sig_type=std_logic lab=f2}
C {lab_wire.sym} 700 -180 2 1 {name=p20 sig_type=std_logic lab=f3}
C {lab_wire.sym} 700 -160 2 1 {name=p21 sig_type=std_logic lab=f4}
C {lab_wire.sym} 700 -140 2 1 {name=p22 sig_type=std_logic lab=f5}
C {lab_wire.sym} 600 -580 2 1 {name=p5 sig_type=std_logic lab=c0}
C {lab_wire.sym} 670 -580 2 1 {name=p9 sig_type=std_logic lab=c1}
C {lab_wire.sym} 730 -580 2 1 {name=p11 sig_type=std_logic lab=c2}
C {lab_wire.sym} 810 -580 2 1 {name=p13 sig_type=std_logic lab=f0}
C {lab_wire.sym} 860 -580 2 1 {name=p14 sig_type=std_logic lab=f1}
C {lab_wire.sym} 920 -580 2 1 {name=p15 sig_type=std_logic lab=f2}
C {lab_wire.sym} 980 -580 2 1 {name=p16 sig_type=std_logic lab=f3}
C {lab_wire.sym} 1030 -580 2 1 {name=p17 sig_type=std_logic lab=f4}
C {lab_wire.sym} 1090 -580 2 1 {name=p27 sig_type=std_logic lab=f5}
C {/foss/designs/CHIP-PLL/schematics/vco/vco_cell/vco_top.sym} 870 -210 0 0 {name=x2}
C {capa.sym} 1370 -170 0 0 {name=C3
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 1370 -90 0 0 {name=l6 lab=0}
C {/foss/designs/CHIP-PLL/schematics/charge_pump/charge_pump_cell.sym} 240 -110 0 0 {name=x1}
