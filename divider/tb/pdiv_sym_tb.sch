v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -130 250 -130 270 {lab=clk}
N 110 90 110 100 {lab=VP}
N -130 330 -130 350 {lab=0}
N 110 160 110 180 {lab=0}
N 130 340 160 340 {lab=out}
N 140 320 160 320 {lab=clk}
N 460 460 610 460 {lab=div64}
N 460 440 610 440 {lab=div32}
N 460 340 490 340 {lab=VP}
N 460 320 530 320 {lab=0}
N 460 420 610 420 {lab=div16}
N 460 400 610 400 {lab=div8}
N 460 380 610 380 {lab=div4}
N 460 360 610 360 {lab=div2}
N 910 400 940 400 {lab=0}
N 910 380 970 380 {lab=VP}
N -130 760 -130 780 {lab=0}
N -10 760 -10 780 {lab=0}
N 110 760 110 780 {lab=0}
N 580 480 610 480 {lab=d0}
N 580 500 610 500 {lab=d1}
N 580 520 610 520 {lab=d2}
N -130 670 -130 700 {lab=d0}
N -10 670 -10 700 {lab=d1}
N 110 670 110 700 {lab=d2}
N 480 840 480 860 {lab=0}
N 540 840 540 860 {lab=0}
N 600 840 600 860 {lab=0}
N 660 840 660 860 {lab=0}
N 720 840 720 860 {lab=0}
N 780 840 780 860 {lab=0}
N 480 760 480 780 {lab=div64}
N 460 760 480 760 {lab=div64}
N 460 740 540 740 {lab=div32}
N 540 740 540 780 {lab=div32}
N 600 720 600 780 {lab=div16}
N 460 720 600 720 {lab=div16}
N 460 700 660 700 {lab=div8}
N 660 700 660 780 {lab=div8}
N 460 680 720 680 {lab=div4}
N 720 680 720 780 {lab=div4}
N 460 660 780 660 {lab=div2}
N 780 660 780 780 {lab=div2}
N 580 540 610 540 {lab=d3}
N 1040 290 1060 290 {lab=VP}
N 1040 290 1040 330 {lab=VP}
N 1040 390 1040 420 {lab=0}
N 1130 290 1150 290 {lab=VP}
N 1130 290 1130 330 {lab=VP}
N 1130 390 1130 420 {lab=0}
N 1090 360 1110 360 {lab=#net1}
N 1180 360 1200 360 {lab=out}
N 1420 670 1450 670 {lab=out}
N 1750 730 1760 730 {lab=#net2}
N 1760 730 1760 760 {lab=#net2}
N 1440 760 1760 760 {lab=#net2}
N 1440 690 1440 760 {lab=#net2}
N 1440 690 1450 690 {lab=#net2}
N 1750 710 1780 710 {lab=0}
N 1750 690 1810 690 {lab=VP}
N 1750 670 1790 670 {lab=out_div}
N 580 560 610 560 {lab=d4}
N 580 580 610 580 {lab=d5}
N -130 940 -130 960 {lab=0}
N -10 940 -10 960 {lab=0}
N 110 940 110 960 {lab=0}
N -130 850 -130 880 {lab=d3}
N -10 850 -10 880 {lab=d4}
N 110 850 110 880 {lab=d5}
N 910 360 1020 360 {lab=#net3}
C {devices/code_shown.sym} -20 -10 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} 300 -70 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.control
set maxdata = 1000
op
print all
save all

tran 50p 14u
write pdiv_tb.raw 
set appendwrite

.endc
"}
C {vsource.sym} 110 130 0 0 {name=V1 value=1.2 savecurrent=false}
C {vsource.sym} -130 300 0 0 {name=V2 value="PULSE(0 1.2 0 100p 100p 1.5625n 3.125n)" savecurrent=false}
C {lab_wire.sym} -130 250 0 0 {name=p2 sig_type=std_logic lab=clk
}
C {lab_wire.sym} 110 90 0 0 {name=p8 sig_type=std_logic lab=VP
}
C {gnd.sym} -130 350 0 0 {name=l3 lab=0
}
C {lab_wire.sym} 140 320 0 0 {name=p3 sig_type=std_logic lab=clk
}
C {/foss/designs/CHIP-PLL/divider/schematics/div_with_reset.sym} 310 390 0 0 {name=x1}
C {gnd.sym} 520 320 3 0 {name=l9 lab=0
}
C {lab_wire.sym} 490 340 2 0 {name=p5 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 480 360 2 0 {name=p6 sig_type=std_logic lab=div2
}
C {lab_wire.sym} 480 380 2 0 {name=p7 sig_type=std_logic lab=div4
}
C {lab_wire.sym} 480 400 2 0 {name=p9 sig_type=std_logic lab=div8
}
C {lab_wire.sym} 480 420 2 0 {name=p10 sig_type=std_logic lab=div16
}
C {lab_wire.sym} 480 440 2 0 {name=p11 sig_type=std_logic lab=div32
}
C {lab_wire.sym} 480 460 2 0 {name=p12 sig_type=std_logic lab=div64
}
C {/foss/designs/CHIP-PLL/divider/schematics/count_data_check.sym} 760 470 0 0 {name=x2}
C {gnd.sym} 940 400 3 0 {name=l2 lab=0
}
C {lab_wire.sym} 970 380 2 0 {name=p13 sig_type=std_logic lab=VP
}
C {gnd.sym} -130 780 0 0 {name=l5 lab=0
}
C {gnd.sym} -10 780 0 0 {name=l6 lab=0
}
C {gnd.sym} 110 780 0 0 {name=l7 lab=0
}
C {lab_wire.sym} 580 540 0 0 {name=p14 sig_type=std_logic lab=d3
}
C {lab_wire.sym} 580 500 0 0 {name=p15 sig_type=std_logic lab=d1
}
C {lab_wire.sym} 580 520 0 0 {name=p16 sig_type=std_logic lab=d2
}
C {lab_wire.sym} -130 850 1 0 {name=p20 sig_type=std_logic lab=d3
}
C {lab_wire.sym} -130 670 1 0 {name=p21 sig_type=std_logic lab=d0
}
C {lab_wire.sym} 110 670 1 0 {name=p22 sig_type=std_logic lab=d2
}
C {lab_wire.sym} 1200 360 2 0 {name=p26 sig_type=std_logic lab=out
}
C {capa.sym} 480 810 0 0 {name=C2
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 480 860 0 0 {name=l11 lab=0
}
C {capa.sym} 540 810 0 0 {name=C1
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 540 860 0 0 {name=l14 lab=0
}
C {capa.sym} 600 810 0 0 {name=C3
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 600 860 0 0 {name=l15 lab=0
}
C {capa.sym} 660 810 0 0 {name=C4
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 660 860 0 0 {name=l16 lab=0
}
C {capa.sym} 720 810 0 0 {name=C5
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 720 860 0 0 {name=l17 lab=0
}
C {capa.sym} 780 810 0 0 {name=C6
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 780 860 0 0 {name=l18 lab=0
}
C {lab_wire.sym} 780 660 2 0 {name=p18 sig_type=std_logic lab=div2
}
C {lab_wire.sym} 720 680 2 0 {name=p19 sig_type=std_logic lab=div4
}
C {lab_wire.sym} 660 700 2 0 {name=p23 sig_type=std_logic lab=div8
}
C {lab_wire.sym} 600 720 2 0 {name=p24 sig_type=std_logic lab=div16
}
C {lab_wire.sym} 540 740 2 0 {name=p25 sig_type=std_logic lab=div32
}
C {lab_wire.sym} 480 760 2 0 {name=p27 sig_type=std_logic lab=div64
}
C {gnd.sym} 110 180 0 0 {name=l13 lab=0
}
C {lab_wire.sym} 130 340 0 0 {name=p1 sig_type=std_logic lab=out
}
C {/foss/designs/CHIP-PLL/divider/schematics/inverter_x2.sym} 1050 360 0 0 {name=x7}
C {lab_wire.sym} 1060 290 2 0 {name=p32 sig_type=std_logic lab=VP
}
C {gnd.sym} 1040 420 0 0 {name=l21 lab=0
}
C {/foss/designs/CHIP-PLL/divider/schematics/inverter_x4.sym} 1130 360 0 0 {name=x8}
C {lab_wire.sym} 1150 290 2 0 {name=p33 sig_type=std_logic lab=VP
}
C {gnd.sym} 1130 420 0 0 {name=l22 lab=0
}
C {/foss/designs/CHIP-PLL/divider/schematics/d_flip_flop.sym} 1600 700 0 0 {name=x19}
C {lab_wire.sym} 1420 670 0 0 {name=p44 sig_type=std_logic lab=out
}
C {gnd.sym} 1780 710 3 0 {name=l33 lab=0
}
C {lab_wire.sym} 1810 690 2 0 {name=p45 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 1790 670 0 0 {name=p46 sig_type=std_logic lab=out_div
}
C {lab_wire.sym} 580 480 0 0 {name=p17 sig_type=std_logic lab=d0
}
C {lab_wire.sym} 580 580 0 0 {name=p47 sig_type=std_logic lab=d5
}
C {lab_wire.sym} 580 560 0 0 {name=p48 sig_type=std_logic lab=d4
}
C {gnd.sym} -130 960 0 0 {name=l8 lab=0
}
C {gnd.sym} -10 960 0 0 {name=l10 lab=0
}
C {gnd.sym} 110 960 0 0 {name=l34 lab=0
}
C {lab_wire.sym} 110 850 1 0 {name=p49 sig_type=std_logic lab=d5
}
C {lab_wire.sym} -10 670 1 0 {name=p51 sig_type=std_logic lab=d1
}
C {lab_wire.sym} -10 850 1 0 {name=p50 sig_type=std_logic lab=d4
}
C {vsource.sym} -130 910 0 0 {name=V7 value=0 savecurrent=false}
C {vsource.sym} -10 910 0 0 {name=V8 value=0 savecurrent=false}
C {vsource.sym} 110 910 0 0 {name=V9 value=0 savecurrent=false}
C {vsource.sym} -10 730 0 0 {name=V10 value="PULSE(0 1.2 0 100p 100p 3u 6u)" savecurrent=false}
C {vsource.sym} -130 730 0 0 {name=V11 value="PULSE(0 1.2 0 100p 100p 1.5u 3u)" savecurrent=false}
C {vsource.sym} 110 730 0 0 {name=V12 value="PULSE(0 1.2 0 100p 100p 6u 12u)" savecurrent=false}
