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
N 770 -90 770 -60 {lab=vp}
N 770 80 770 100 {lab=gd}
N 930 10 1010 10 {lab=vout_preRC}
N 1150 60 1150 100 {lab=gd}
N 1190 10 1280 10 {lab=vout_aftRC}
N 1860 20 1970 20 {lab=vco_out_buffered}
N 1750 -60 1750 -30 {lab=vp}
N 1750 70 1750 100 {lab=gd}
N 1970 20 1970 130 {lab=vco_out_buffered}
N 2160 110 2300 110 {lab=out}
N 2080 230 2080 250 {lab=gd}
N 2050 40 2050 70 {lab=vp}
N 2100 40 2100 70 {lab=vph}
N 1580 20 1650 20 {lab=#net1}
N 200 180 910 180 {lab=cvco}
N 1180 180 1320 180 {lab=vco_out_buffered}
N 1920 250 1930 250 {lab=#net2}
N 1930 250 1930 270 {lab=#net2}
N 1610 270 1930 270 {lab=#net2}
N 1610 210 1610 270 {lab=#net2}
N 1610 210 1620 210 {lab=#net2}
N 1920 210 1940 210 {lab=vp}
N 1920 230 1940 230 {lab=gd}
N 1580 190 1620 190 {lab=vco_out_buffered}
N 1920 190 1990 190 {lab=#net3}
N 1580 130 1580 190 {lab=vco_out_buffered}
N 1580 130 1970 130 {lab=vco_out_buffered}
N 1020 90 1020 120 {lab=vp}
N 1040 90 1040 120 {lab=gd}
C {ipin.sym} 40 -20 0 0 {name=p1 lab=clk_ref}
C {lab_wire.sym} 120 -80 0 0 {name=p2 sig_type=std_logic lab=vp}
C {lab_wire.sym} 120 40 0 0 {name=p3 sig_type=std_logic lab=gd}
C {lab_wire.sym} 430 -80 0 0 {name=p4 sig_type=std_logic lab=vp}
C {lab_wire.sym} 430 90 0 0 {name=p5 sig_type=std_logic lab=gd}
C {lab_wire.sym} 770 100 0 0 {name=p6 sig_type=std_logic lab=gd}
C {lab_wire.sym} 770 -90 0 0 {name=p7 sig_type=std_logic lab=vp}
C {lab_wire.sym} 1150 100 0 0 {name=p8 sig_type=std_logic lab=gd}
C {lab_wire.sym} 1750 90 0 0 {name=p9 sig_type=std_logic lab=gd}
C {lab_wire.sym} 1750 -50 0 0 {name=p10 sig_type=std_logic lab=vp}
C {lab_wire.sym} 2050 40 0 0 {name=p11 sig_type=std_logic lab=vp}
C {lab_wire.sym} 2100 40 0 0 {name=p12 sig_type=std_logic lab=vph}
C {lab_wire.sym} 2080 250 0 0 {name=p13 sig_type=std_logic lab=gd}
C {lab_wire.sym} 610 -20 0 0 {name=p14 sig_type=std_logic lab=UP}
C {lab_wire.sym} 610 40 0 0 {name=p15 sig_type=std_logic lab=DOWN}
C {lab_wire.sym} 1000 10 0 0 {name=p16 sig_type=std_logic lab=vout_preRC}
C {lab_wire.sym} 1280 10 0 0 {name=p17 sig_type=std_logic lab=vout_aftRC}
C {lab_wire.sym} 260 -20 0 0 {name=p18 sig_type=std_logic lab=cref}
C {lab_wire.sym} 260 40 0 0 {name=p19 sig_type=std_logic lab=cvco}
C {opin.sym} 2300 110 0 0 {name=p20 lab=out}
C {ipin.sym} 100 -180 0 0 {name=p21 lab=gd}
C {ipin.sym} 100 -210 0 0 {name=p22 lab=vph}
C {ipin.sym} 100 -240 0 0 {name=p23 lab=vp}
C {/foss/designs/CHIP-PLL/schematics/PFD/PFD_cell.sym} 430 10 0 0 {name=x7}
C {/foss/designs/CHIP-PLL/schematics/charge_pump/charge_pump_cell.sym} 780 10 0 0 {name=x8}
C {/foss/designs/CHIP-PLL/schematics/misc/RC_filter.sym} 1160 20 0 0 {name=x9}
C {/foss/designs/CHIP-PLL/schematics/misc/buffer_hv.sym} 210 -20 0 0 {name=x2}
C {/foss/designs/CHIP-PLL/schematics/misc/level_shifter.sym} 2140 130 0 0 {name=x1}
C {/foss/designs/CHIP-PLL/schematics/buf/buf.sym} 1750 20 0 0 {name=x3}
C {/foss/designs/CHIP-PLL/schematics/divider/schematics/Divider_top.sym} 1030 180 0 0 {name=x4}
C {lab_wire.sym} 1960 20 0 0 {name=p24 sig_type=std_logic lab=vco_out_buffered}
C {lab_wire.sym} 1320 180 0 0 {name=p25 sig_type=std_logic lab=vco_out_buffered}
C {lab_pin.sym} 1940 230 2 0 {name=p41 sig_type=std_logic lab=gd}
C {lab_pin.sym} 1940 210 2 0 {name=p42 sig_type=std_logic lab=vp}
C {/foss/designs/CHIP-PLL/schematics/divider/schematics/d_flip_flop.sym} 1770 220 0 0 {name=x5}
C {lab_wire.sym} 1020 100 0 0 {name=p26 sig_type=std_logic lab=vp}
C {lab_wire.sym} 1040 110 0 0 {name=p27 sig_type=std_logic lab=gd}
