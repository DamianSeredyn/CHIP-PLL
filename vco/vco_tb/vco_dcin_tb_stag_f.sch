v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -160 250 -160 290 {lab=0}
N -240 250 -240 290 {lab=0}
N -240 150 -240 190 {lab=vdd}
N -160 150 -160 190 {lab=in}
N 1470 480 1510 480 {lab=out}
N 1610 390 1610 430 {lab=vdd}
N 1610 530 1610 570 {lab=0}
N 1720 480 1760 480 {lab=out_pb}
N 70 40 150 40 {lab=in}
N 150 -130 190 -130 {lab=pgt}
N 190 -130 190 10 {lab=pgt}
N 4240 -70 4310 -70 {lab=out}
N 330 -70 370 -70 {lab=out}
N 330 -110 370 -110 {lab=pgt}
N 330 -30 370 -30 {lab=in}
N 510 -180 510 -130 {lab=vdd}
N 510 -10 510 40 {lab=0}
N 650 -70 690 -70 {lab=1-2}
N 650 -110 690 -110 {lab=pgt}
N 650 -30 690 -30 {lab=in}
N 830 -180 830 -130 {lab=vdd}
N 830 -10 830 40 {lab=0}
N 970 -70 1010 -70 {lab=2-3}
N 970 -110 1010 -110 {lab=pgt}
N 970 -30 1010 -30 {lab=in}
N 1150 -180 1150 -130 {lab=vdd}
N 1150 -10 1150 40 {lab=0}
N 1290 -70 1330 -70 {lab=3-4}
N 1290 -110 1330 -110 {lab=pgt}
N 1290 -30 1330 -30 {lab=in}
N 1470 -180 1470 -130 {lab=vdd}
N 1470 -10 1470 40 {lab=0}
N 3920 -110 3960 -110 {lab=pgt}
N 3920 -30 3960 -30 {lab=in}
N 4100 -180 4100 -130 {lab=vdd}
N 4100 -10 4100 40 {lab=0}
N 190 40 190 120 {lab=gnd}
N 150 -180 150 -130 {lab=pgt}
N 190 -150 190 -130 {lab=pgt}
N 190 -260 190 -180 {lab=vdd}
N 1850 -860 1850 -810 {lab=vdd}
N 1850 -690 1850 -640 {lab=0}
N 1650 -750 1710 -750 {lab=#net1}
N 2190 -860 2190 -810 {lab=vdd}
N 2190 -690 2190 -640 {lab=0}
N 1690 -790 1710 -790 {lab=pgt}
N 1690 -710 1710 -710 {lab=in}
N 2030 -790 2050 -790 {lab=pgt}
N 2030 -710 2050 -710 {lab=in}
N 1990 -750 2050 -750 {lab=#net2}
N 2580 -860 2580 -810 {lab=vdd}
N 2580 -690 2580 -640 {lab=0}
N 2330 -750 2440 -750 {lab=#net3}
N 2920 -860 2920 -810 {lab=vdd}
N 2920 -690 2920 -640 {lab=0}
N 2420 -790 2440 -790 {lab=pgt}
N 2420 -710 2440 -710 {lab=in}
N 2760 -790 2780 -790 {lab=pgt}
N 2760 -710 2780 -710 {lab=in}
N 2720 -750 2780 -750 {lab=#net4}
N 3310 -860 3310 -810 {lab=vdd}
N 3310 -690 3310 -640 {lab=0}
N 3060 -750 3170 -750 {lab=#net5}
N 3650 -860 3650 -810 {lab=vdd}
N 3650 -690 3650 -640 {lab=0}
N 3150 -790 3170 -790 {lab=pgt}
N 3150 -710 3170 -710 {lab=in}
N 3490 -790 3510 -790 {lab=pgt}
N 3490 -710 3510 -710 {lab=in}
N 3450 -750 3510 -750 {lab=#net6}
N 3810 -750 3950 -750 {lab=4-5}
N 3820 -70 3960 -70 {lab=4-5}
N 1650 -750 1650 -70 {lab=#net1}
N 1600 -750 1650 -750 {lab=#net1}
N 1610 -70 1650 -70 {lab=#net1}
N 3810 -750 3820 -70 {lab=4-5}
N 3790 -750 3810 -750 {lab=4-5}
C {vsource.sym} -160 220 0 0 {name=V1 value=\{vin\} savecurrent=false}
C {vsource.sym} -240 220 0 0 {name=V2 value=\{vdd\} savecurrent=false}
C {devices/code_shown.sym} -290 -400 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {lab_wire.sym} -240 150 0 0 {name=p1 sig_type=std_logic lab=vdd
}
C {lab_wire.sym} 1490 480 0 0 {name=p3 sig_type=std_logic lab=out
}
C {gnd.sym} -160 290 0 0 {name=l2 lab=0
}
C {connector.sym} 1760 480 0 1 {name=c2 footprint=connector(1,1)}
C {lab_wire.sym} 1760 480 0 0 {name=p4 sig_type=std_logic lab=out_pb
}
C {/foss/designs/CHIP-PLL/buf/buf.sym} 1610 480 0 0 {name=x1}
C {lab_wire.sym} 1610 390 0 0 {name=p5 sig_type=std_logic lab=vdd
}
C {gnd.sym} -240 290 0 0 {name=l4 lab=0
}
C {lab_wire.sym} -160 150 0 0 {name=p6 sig_type=std_logic lab=in
}
C {gnd.sym} 1610 570 0 0 {name=l1 lab=0
}
C {sg13g2_pr/sg13_lv_nmos.sym} 170 40 0 0 {name=M1
l=\{Lcs\}
w=0.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 170 -180 0 0 {name=q
l=\{Lcs\}
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {ipin.sym} 70 40 0 0 {name=p2 lab=in}
C {opin.sym} 4310 -70 0 0 {name=p7 lab=out}
C {/foss/designs/CHIP-PLL/vco/vco_cell/vco_delay_cell.sym} 510 -70 0 0 {name=x2}
C {lab_wire.sym} 350 -70 0 0 {name=p8 sig_type=std_logic lab=out
}
C {lab_wire.sym} 350 -110 0 0 {name=p10 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 350 -30 0 0 {name=p11 sig_type=std_logic lab=in
}
C {lab_wire.sym} 190 -260 0 0 {name=p12 sig_type=std_logic lab=vdd
}
C {lab_wire.sym} 510 -180 0 0 {name=p13 sig_type=std_logic lab=vdd
}
C {/foss/designs/CHIP-PLL/vco/vco_cell/vco_delay_cell.sym} 830 -70 0 0 {name=x3}
C {lab_wire.sym} 670 -70 0 0 {name=p9 sig_type=std_logic lab=1-2
}
C {lab_wire.sym} 670 -110 0 0 {name=p14 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 670 -30 0 0 {name=p16 sig_type=std_logic lab=in
}
C {lab_wire.sym} 830 -180 0 0 {name=p17 sig_type=std_logic lab=vdd
}
C {/foss/designs/CHIP-PLL/vco/vco_cell/vco_delay_cell.sym} 1150 -70 0 0 {name=x4}
C {lab_wire.sym} 990 -70 0 0 {name=p19 sig_type=std_logic lab=2-3
}
C {lab_wire.sym} 990 -110 0 0 {name=p20 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 990 -30 0 0 {name=p21 sig_type=std_logic lab=in
}
C {lab_wire.sym} 1150 -180 0 0 {name=p22 sig_type=std_logic lab=vdd
}
C {/foss/designs/CHIP-PLL/vco/vco_cell/vco_delay_cell.sym} 1470 -70 0 0 {name=x5}
C {lab_wire.sym} 1310 -70 0 0 {name=p24 sig_type=std_logic lab=3-4
}
C {lab_wire.sym} 1310 -110 0 0 {name=p25 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 1310 -30 0 0 {name=p26 sig_type=std_logic lab=in
}
C {lab_wire.sym} 1470 -180 0 0 {name=p27 sig_type=std_logic lab=vdd
}
C {/foss/designs/CHIP-PLL/vco/vco_cell/vco_delay_cell.sym} 4100 -70 0 0 {name=x6}
C {lab_wire.sym} 3940 -70 0 0 {name=p29 sig_type=std_logic lab=4-5
}
C {lab_wire.sym} 3940 -110 0 0 {name=p30 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 3940 -30 0 0 {name=p31 sig_type=std_logic lab=in
}
C {lab_wire.sym} 4100 -180 0 0 {name=p32 sig_type=std_logic lab=vdd
}
C {lab_wire.sym} 190 120 0 0 {name=p34 sig_type=std_logic lab=gnd
}
C {lab_wire.sym} 190 -60 0 0 {name=p35 sig_type=std_logic lab=pgt
}
C {gnd.sym} 510 40 0 0 {name=l7 lab=0
}
C {gnd.sym} 830 40 0 0 {name=l3 lab=0
}
C {gnd.sym} 1150 40 0 0 {name=l6 lab=0
}
C {gnd.sym} 1470 40 0 0 {name=l8 lab=0
}
C {gnd.sym} 4100 40 0 0 {name=l9 lab=0
}
C {devices/code_shown.sym} -300 -320 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.param vdd=1.2
.param vin=0.4
.param Lcs=0.18*4u
.param Ldrv=0.18*2u

.control

tran 40p 700n
write vco_tb.raw
set appendwrite
plot out
plot out_pb
.endc
"}
C {/foss/designs/CHIP-PLL/vco/vco_cell/vco_delay_cell.sym} 1850 -750 0 0 {name=x7}
C {lab_wire.sym} 1690 -790 0 0 {name=p18 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 1690 -710 0 0 {name=p23 sig_type=std_logic lab=in
}
C {lab_wire.sym} 1850 -860 0 0 {name=p28 sig_type=std_logic lab=vdd
}
C {gnd.sym} 1850 -640 0 0 {name=l5 lab=0
}
C {/foss/designs/CHIP-PLL/vco/vco_cell/vco_delay_cell.sym} 2190 -750 0 0 {name=x8}
C {lab_wire.sym} 2030 -790 0 0 {name=p15 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 2030 -710 0 0 {name=p33 sig_type=std_logic lab=in
}
C {lab_wire.sym} 2190 -860 0 0 {name=p36 sig_type=std_logic lab=vdd
}
C {gnd.sym} 2190 -640 0 0 {name=l10 lab=0
}
C {/foss/designs/CHIP-PLL/vco/vco_cell/vco_delay_cell.sym} 2580 -750 0 0 {name=x9}
C {lab_wire.sym} 2420 -790 0 0 {name=p37 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 2420 -710 0 0 {name=p38 sig_type=std_logic lab=in
}
C {lab_wire.sym} 2580 -860 0 0 {name=p39 sig_type=std_logic lab=vdd
}
C {gnd.sym} 2580 -640 0 0 {name=l11 lab=0
}
C {/foss/designs/CHIP-PLL/vco/vco_cell/vco_delay_cell.sym} 2920 -750 0 0 {name=x10}
C {lab_wire.sym} 2760 -790 0 0 {name=p40 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 2760 -710 0 0 {name=p41 sig_type=std_logic lab=in
}
C {lab_wire.sym} 2920 -860 0 0 {name=p42 sig_type=std_logic lab=vdd
}
C {gnd.sym} 2920 -640 0 0 {name=l12 lab=0
}
C {/foss/designs/CHIP-PLL/vco/vco_cell/vco_delay_cell.sym} 3310 -750 0 0 {name=x11}
C {lab_wire.sym} 3150 -790 0 0 {name=p43 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 3150 -710 0 0 {name=p44 sig_type=std_logic lab=in
}
C {lab_wire.sym} 3310 -860 0 0 {name=p45 sig_type=std_logic lab=vdd
}
C {gnd.sym} 3310 -640 0 0 {name=l13 lab=0
}
C {/foss/designs/CHIP-PLL/vco/vco_cell/vco_delay_cell.sym} 3650 -750 0 0 {name=x12}
C {lab_wire.sym} 3490 -790 0 0 {name=p46 sig_type=std_logic lab=pgt
}
C {lab_wire.sym} 3490 -710 0 0 {name=p47 sig_type=std_logic lab=in
}
C {lab_wire.sym} 3650 -860 0 0 {name=p48 sig_type=std_logic lab=vdd
}
C {gnd.sym} 3650 -640 0 0 {name=l14 lab=0
}
C {noconn.sym} 1600 -750 0 0 {name=l16}
C {noconn.sym} 3950 -750 0 0 {name=l15}
