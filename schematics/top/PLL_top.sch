v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 40 -20 100 -20 {lab=clk_ref}
N 120 -80 120 -50 {lab=vp}
N 120 10 120 40 {lab=gd}
N 180 -20 280 -20 {lab=cref}
N 200 40 280 40 {lab=cvco}
N 200 40 200 180 {lab=cvco}
N 200 180 390 180 {lab=cvco}
N 430 -80 430 -50 {lab=vp}
N 430 70 430 90 {lab=gd}
N 580 40 630 40 {lab=DOWN}
N 580 -20 630 -20 {lab=UP}
N 770 -90 770 -60 {lab=vp}
N 770 80 770 100 {lab=gd}
N 930 10 1010 10 {lab=vout_preRC}
N 1150 60 1150 100 {lab=gd}
N 1190 10 1280 10 {lab=vout_aftRC}
N 1860 20 1970 20 {lab=#net1}
N 1750 -60 1750 -30 {lab=vp}
N 1750 70 1750 100 {lab=gd}
N 1970 20 1970 50 {lab=#net1}
N 2140 -30 2280 -30 {lab=out}
N 2060 90 2060 110 {lab=gd}
N 2030 -100 2030 -70 {lab=vp}
N 2080 -100 2080 -70 {lab=vph}
N 1580 20 1650 20 {lab=#net2}
C {CHIP-PLL/schematics/misc/buffer_hv.sym} 210 -20 0 0 {name=x1}
C {CHIP-PLL/schematics/PFD/PFD_cell.sym} 430 10 0 0 {name=x2}
C {ipin.sym} 40 -20 0 0 {name=p1 lab=clk_ref}
C {lab_wire.sym} 120 -80 0 0 {name=p2 sig_type=std_logic lab=vp}
C {lab_wire.sym} 120 40 0 0 {name=p3 sig_type=std_logic lab=gd}
C {lab_wire.sym} 430 -80 0 0 {name=p4 sig_type=std_logic lab=vp}
C {lab_wire.sym} 430 90 0 0 {name=p5 sig_type=std_logic lab=gd}
C {CHIP-PLL/schematics/charge_pump/charge_pump_cell.sym} 780 10 0 0 {name=x3}
C {lab_wire.sym} 770 100 0 0 {name=p6 sig_type=std_logic lab=gd}
C {lab_wire.sym} 770 -90 0 0 {name=p7 sig_type=std_logic lab=vp}
C {CHIP-PLL/schematics/misc/RC_filter.sym} 1160 20 0 0 {name=x4}
C {lab_wire.sym} 1150 100 0 0 {name=p8 sig_type=std_logic lab=gd}
C {CHIP-PLL/schematics/buf/buf.sym} 1750 20 0 0 {name=x5}
C {lab_wire.sym} 1750 90 0 0 {name=p9 sig_type=std_logic lab=gd}
C {lab_wire.sym} 1750 -50 0 0 {name=p10 sig_type=std_logic lab=vp}
C {CHIP-PLL/schematics/misc/level_shifter.sym} 2120 -10 0 0 {name=x6}
C {lab_wire.sym} 2030 -100 0 0 {name=p11 sig_type=std_logic lab=vp}
C {lab_wire.sym} 2080 -100 0 0 {name=p12 sig_type=std_logic lab=vph}
C {lab_wire.sym} 2060 110 0 0 {name=p13 sig_type=std_logic lab=gd}
C {lab_wire.sym} 610 -20 0 0 {name=p14 sig_type=std_logic lab=UP}
C {lab_wire.sym} 610 40 0 0 {name=p15 sig_type=std_logic lab=DOWN}
C {lab_wire.sym} 1000 10 0 0 {name=p16 sig_type=std_logic lab=vout_preRC}
C {lab_wire.sym} 1280 10 0 0 {name=p17 sig_type=std_logic lab=vout_aftRC}
C {lab_wire.sym} 260 -20 0 0 {name=p18 sig_type=std_logic lab=cref}
C {lab_wire.sym} 260 40 0 0 {name=p19 sig_type=std_logic lab=cvco}
C {opin.sym} 2280 -30 0 0 {name=p20 lab=out}
C {ipin.sym} 100 -180 0 0 {name=p21 lab=gd}
C {ipin.sym} 100 -210 0 0 {name=p22 lab=vph}
C {ipin.sym} 100 -240 0 0 {name=p23 lab=vp}
