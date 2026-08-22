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
N 430 -80 430 -50 {lab=vp}
N 430 70 430 90 {lab=gd}
N 580 40 630 40 {lab=DOWN}
N 580 -20 630 -20 {lab=UP}
N 780 -100 780 -70 {lab=vp}
N 780 90 780 110 {lab=gd}
N 930 0 1010 0 {lab=vout_preRC}
N 1150 50 1150 90 {lab=gd}
N 1190 0 1280 0 {lab=vout_aftRC}
N 1950 20 2060 20 {lab=vco_out_buffered}
N 1840 -60 1840 -30 {lab=vp}
N 1840 70 1840 100 {lab=gd}
N 2060 20 2060 130 {lab=vco_out_buffered}
N 2250 110 2390 110 {lab=out}
N 2170 230 2170 250 {lab=gd}
N 2140 40 2140 70 {lab=vp}
N 2190 40 2190 70 {lab=vph}
N 1670 20 1740 20 {lab=vco_out_prebuff}
N 200 180 910 180 {lab=cvco}
N 2010 250 2020 250 {lab=#net1}
N 2020 250 2020 270 {lab=#net1}
N 1700 270 2020 270 {lab=#net1}
N 1700 210 1700 270 {lab=#net1}
N 1700 210 1710 210 {lab=#net1}
N 2010 210 2030 210 {lab=vp}
N 2010 230 2030 230 {lab=gd}
N 2010 190 2080 190 {lab=#net2}
N 1020 90 1020 120 {lab=gd}
N 1040 90 1040 120 {lab=vp}
N 1700 190 1710 190 {lab=vco_out_buffered}
N 1700 130 1700 190 {lab=vco_out_buffered}
N 1700 130 2060 130 {lab=vco_out_buffered}
N 1180 180 1670 180 {lab=vco_out_prebuff}
N 950 270 950 310 {lab=a0}
N 970 270 970 310 {lab=a1}
N 990 270 990 310 {lab=a2}
N 1040 270 1040 310 {lab=d0}
N 1060 270 1060 310 {lab=d1}
N 1080 270 1080 310 {lab=d2}
N 1100 270 1100 310 {lab=d3}
N 1120 270 1120 310 {lab=d4}
N 1140 270 1140 310 {lab=d5}
N 200 10 280 10 {lab=rst}
N 930 40 970 40 {lab=rst_n}
N 1460 -140 1460 -90 {lab=vp}
N 1460 90 1460 120 {lab=gd}
N 1670 20 1670 180 {lab=vco_out_prebuff}
N 1670 -0 1670 20 {lab=vco_out_prebuff}
N 1640 0 1670 -0 {lab=vco_out_prebuff}
N 880 160 910 160 {lab=rst}
N 1300 260 1330 260 {lab=rst}
N 1400 260 1460 260 {lab=rst_n}
N 1350 210 1350 230 {lab=vp}
N 1350 290 1350 310 {lab=gd}
C {ipin.sym} 40 -20 0 0 {name=p1 lab=clk_ref}
C {lab_wire.sym} 120 -80 0 0 {name=p2 sig_type=std_logic lab=vp}
C {lab_wire.sym} 120 40 0 0 {name=p3 sig_type=std_logic lab=gd}
C {lab_wire.sym} 430 -80 0 0 {name=p4 sig_type=std_logic lab=vp}
C {lab_wire.sym} 430 90 0 0 {name=p5 sig_type=std_logic lab=gd}
C {lab_wire.sym} 780 110 0 0 {name=p6 sig_type=std_logic lab=gd}
C {lab_wire.sym} 780 -100 0 0 {name=p7 sig_type=std_logic lab=vp}
C {lab_wire.sym} 1150 90 0 0 {name=p8 sig_type=std_logic lab=gd}
C {lab_wire.sym} 1840 90 0 0 {name=p9 sig_type=std_logic lab=gd}
C {lab_wire.sym} 1840 -50 0 0 {name=p10 sig_type=std_logic lab=vp}
C {lab_wire.sym} 2140 40 0 0 {name=p11 sig_type=std_logic lab=vp}
C {lab_wire.sym} 2190 40 0 0 {name=p12 sig_type=std_logic lab=vph}
C {lab_wire.sym} 2170 250 0 0 {name=p13 sig_type=std_logic lab=gd}
C {lab_wire.sym} 610 -20 0 0 {name=p14 sig_type=std_logic lab=UP}
C {lab_wire.sym} 610 40 0 0 {name=p15 sig_type=std_logic lab=DOWN}
C {lab_wire.sym} 1000 0 0 0 {name=p16 sig_type=std_logic lab=vout_preRC}
C {lab_wire.sym} 1280 0 0 0 {name=p17 sig_type=std_logic lab=vout_aftRC}
C {lab_wire.sym} 260 -20 0 0 {name=p18 sig_type=std_logic lab=cref}
C {lab_wire.sym} 260 40 0 0 {name=p19 sig_type=std_logic lab=cvco}
C {opin.sym} 2390 110 0 0 {name=p20 lab=out}
C {ipin.sym} 100 -180 0 0 {name=p21 lab=gd}
C {ipin.sym} 100 -210 0 0 {name=p22 lab=vph}
C {ipin.sym} 100 -240 0 0 {name=p23 lab=vp}
C {/foss/designs/CHIP-PLL/schematics/misc/RC_filter.sym} 1160 10 0 0 {name=xRC}
C {lab_wire.sym} 2050 20 0 0 {name=p24 sig_type=std_logic lab=vco_out_buffered}
C {lab_pin.sym} 2030 230 2 0 {name=p41 sig_type=std_logic lab=gd}
C {lab_pin.sym} 2030 210 2 0 {name=p42 sig_type=std_logic lab=vp}
C {lab_wire.sym} 1040 100 0 0 {name=p26 sig_type=std_logic lab=vp}
C {lab_wire.sym} 1020 100 0 0 {name=p27 sig_type=std_logic lab=gd}
C {lab_wire.sym} 1460 -140 0 0 {name=p25 sig_type=std_logic lab=vp}
C {lab_wire.sym} 1460 120 0 0 {name=p28 sig_type=std_logic lab=gd}
C {lab_wire.sym} 1620 180 0 0 {name=p29 sig_type=std_logic lab=vco_out_prebuff}
C {ipin.sym} 950 310 3 0 {name=p30 lab=a0}
C {ipin.sym} 970 310 3 0 {name=p31 lab=a1}
C {ipin.sym} 990 310 3 0 {name=p32 lab=a2}
C {ipin.sym} 1040 310 3 0 {name=p33 lab=d0}
C {ipin.sym} 1060 310 3 0 {name=p34 lab=d1}
C {ipin.sym} 1080 310 3 0 {name=p35 lab=d2}
C {ipin.sym} 1100 310 3 0 {name=p36 lab=d3}
C {ipin.sym} 1120 310 3 0 {name=p37 lab=d4}
C {ipin.sym} 1140 310 3 0 {name=p38 lab=d5}
C {/foss/designs/CHIP-PLL/schematics/misc/buffer_hv.sym} 210 -20 0 0 {name=x2}
C {/foss/designs/CHIP-PLL/schematics/PFD/PFD_cell_2.sym} 430 10 0 0 {name=xPFD}
C {ipin.sym} 100 -150 0 0 {name=p39 lab=rst}
C {lab_wire.sym} 260 10 0 0 {name=p40 sig_type=std_logic lab=rst}
C {/foss/designs/CHIP-PLL/schematics/charge_pump/charge_pump_cell.sym} 780 10 0 0 {name=xCP}
C {/foss/designs/CHIP-PLL/schematics/buf/buf.sym} 1840 20 0 0 {name=xBUF}
C {/foss/designs/CHIP-PLL/schematics/divider/schematics/Divider_top.sym} 1030 180 0 0 {name=xDiv}
C {/foss/designs/CHIP-PLL/schematics/vco/vco_cell/vco_core_0.sym} 1460 0 0 0 {name=xVCO}
C {/foss/designs/CHIP-PLL/schematics/divider/schematics/d_flip_flop.sym} 1860 220 0 0 {name=x5}
C {/foss/designs/CHIP-PLL/schematics/misc/level_shifter.sym} 2230 130 0 0 {name=xLS}
C {lab_wire.sym} 880 160 0 0 {name=p44 sig_type=std_logic lab=rst}
C {/foss/designs/CHIP-PLL/schematics/divider/schematics/inverter_x4.sym} 1350 260 0 0 {name=x10}
C {lab_wire.sym} 1300 260 0 0 {name=p45 sig_type=std_logic lab=rst}
C {lab_wire.sym} 1460 260 0 0 {name=p46 sig_type=std_logic lab=rst_n}
C {lab_wire.sym} 970 40 0 0 {name=p43 sig_type=std_logic lab=rst_n}
C {lab_wire.sym} 1350 210 0 0 {name=p47 sig_type=std_logic lab=vp}
C {lab_wire.sym} 1350 310 0 0 {name=p48 sig_type=std_logic lab=gd}
