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
N 460 320 520 320 {lab=0}
N 460 420 610 420 {lab=div16}
N 460 400 610 400 {lab=div8}
N 460 380 610 380 {lab=div4}
N 460 360 610 360 {lab=div2}
N -130 760 -130 780 {lab=0}
N -10 760 -10 780 {lab=0}
N 110 760 110 780 {lab=0}
N 700 370 750 370 {lab=d2}
N 700 580 750 580 {lab=0}
N -130 670 -130 700 {lab=d0}
N -10 670 -10 700 {lab=d1}
N 110 670 110 700 {lab=d2}
N -130 510 -130 530 {lab=0}
N -130 430 -130 450 {lab=reset}
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
N 1050 210 1060 210 {lab=VP}
N 1050 230 1060 230 {lab=GND}
N 730 210 750 210 {lab=div2}
N 1050 280 1060 280 {lab=VP}
N 1050 300 1060 300 {lab=GND}
N 730 280 750 280 {lab=div4}
N 1050 350 1060 350 {lab=VP}
N 1050 370 1060 370 {lab=GND}
N 730 350 750 350 {lab=div8}
N 1050 420 1060 420 {lab=VP}
N 1050 440 1060 440 {lab=GND}
N 730 420 750 420 {lab=div16}
N 1050 490 1060 490 {lab=VP}
N 1050 510 1060 510 {lab=GND}
N 730 490 750 490 {lab=div32}
N 1050 560 1060 560 {lab=VP}
N 1050 580 1060 580 {lab=GND}
N 730 560 750 560 {lab=div64}
N 1050 250 1080 250 {lab=y0}
N 1050 320 1080 320 {lab=y1}
N 1050 390 1080 390 {lab=y2}
N 1050 460 1080 460 {lab=y3}
N 1050 530 1080 530 {lab=y4}
N 1050 600 1080 600 {lab=y5}
N 1210 250 1240 250 {lab=y0}
N 1210 270 1240 270 {lab=y1}
N 1210 290 1240 290 {lab=y2}
N 1540 250 1550 250 {lab=VP}
N 1540 270 1550 270 {lab=GND}
N 1210 350 1240 350 {lab=y3}
N 1210 370 1240 370 {lab=y4}
N 1210 390 1240 390 {lab=y5}
N 1540 350 1550 350 {lab=VP}
N 1540 370 1550 370 {lab=GND}
N 1540 290 1670 290 {lab=and012}
N 1540 390 1610 390 {lab=and345}
N 1610 310 1610 390 {lab=and345}
N 1610 310 1670 310 {lab=and345}
N 1960 290 1970 290 {lab=VP}
N 1960 310 1970 310 {lab=GND}
N 1960 330 2000 330 {lab=out}
N 700 510 750 510 {lab=0}
N 700 440 750 440 {lab=0}
N 700 230 750 230 {lab=d0}
N 710 300 750 300 {lab=d1}
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

tran 50p 3u
write pdiv_tb.raw 
set appendwrite

.endc
"}
C {vsource.sym} 110 130 0 0 {name=V1 value=1.2 savecurrent=false}
C {vsource.sym} -130 300 0 0 {name=V2 value="PULSE(0 1.2 0 100p 100p 3.335n 6.67n)" savecurrent=false}
C {gnd.sym} 110 180 0 0 {name=l1 lab=0
}
C {lab_wire.sym} -130 250 0 0 {name=p2 sig_type=std_logic lab=clk
}
C {lab_wire.sym} 110 90 0 0 {name=p8 sig_type=std_logic lab=VP
}
C {gnd.sym} -130 350 0 0 {name=l3 lab=0
}
C {gnd.sym} -130 530 0 0 {name=l4 lab=0
}
C {lab_wire.sym} -130 430 0 0 {name=p4 sig_type=std_logic lab=reset
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
C {vsource.sym} -130 730 0 0 {name=V3 value="PWL(
+ 0 0 
+ 0 1n 1.2 )" savecurrent=false}
C {gnd.sym} -130 780 0 0 {name=l5 lab=0
}
C {vsource.sym} -10 730 0 0 {name=V4 value="PWL(
+ 0 0 
+ 1u 0
+ 1.001u 1.2)" savecurrent=false}
C {gnd.sym} -10 780 0 0 {name=l6 lab=0
}
C {vsource.sym} 110 730 0 0 {name=V6 value="PWL(
+ 0 0 
+ 2u 0
+ 2.001u 1.2)" savecurrent=false}
C {gnd.sym} 110 780 0 0 {name=l7 lab=0
}
C {lab_wire.sym} 710 300 0 0 {name=p15 sig_type=std_logic lab=d1
}
C {lab_wire.sym} 700 370 0 0 {name=p16 sig_type=std_logic lab=d2
}
C {lab_wire.sym} -130 670 1 0 {name=p20 sig_type=std_logic lab=d0
}
C {lab_wire.sym} -10 670 1 0 {name=p21 sig_type=std_logic lab=d1
}
C {lab_wire.sym} 110 670 1 0 {name=p22 sig_type=std_logic lab=d2
}
C {vsource.sym} -130 480 0 0 {name=V5 value="PWL(
+ 0 0 )" savecurrent=false}
C {lab_wire.sym} 130 340 0 0 {name=p1 sig_type=std_logic lab=out
}
C {gnd.sym} 700 580 0 0 {name=l8 lab=0
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
C {lab_pin.sym} 1060 210 2 0 {name=p13 sig_type=std_logic lab=VP}
C {lab_pin.sym} 1060 230 2 0 {name=p17 sig_type=std_logic lab=GND}
C {lab_pin.sym} 1060 280 2 0 {name=p29 sig_type=std_logic lab=VP}
C {lab_pin.sym} 1060 300 2 0 {name=p30 sig_type=std_logic lab=GND}
C {lab_pin.sym} 1060 350 2 0 {name=p33 sig_type=std_logic lab=VP}
C {lab_pin.sym} 1060 370 2 0 {name=p34 sig_type=std_logic lab=GND}
C {lab_pin.sym} 1060 420 2 0 {name=p37 sig_type=std_logic lab=VP}
C {lab_pin.sym} 1060 440 2 0 {name=p38 sig_type=std_logic lab=GND}
C {lab_pin.sym} 1060 490 2 0 {name=p41 sig_type=std_logic lab=VP}
C {lab_pin.sym} 1060 510 2 0 {name=p42 sig_type=std_logic lab=GND}
C {lab_pin.sym} 1060 560 2 0 {name=p45 sig_type=std_logic lab=VP}
C {lab_pin.sym} 1060 580 2 0 {name=p46 sig_type=std_logic lab=GND}
C {lab_pin.sym} 1080 250 2 0 {name=p61 sig_type=std_logic lab=y0}
C {lab_pin.sym} 1080 320 2 0 {name=p62 sig_type=std_logic lab=y1}
C {lab_pin.sym} 1080 390 2 0 {name=p63 sig_type=std_logic lab=y2}
C {lab_pin.sym} 1080 460 2 0 {name=p64 sig_type=std_logic lab=y3}
C {lab_pin.sym} 1080 530 2 0 {name=p65 sig_type=std_logic lab=y4}
C {lab_pin.sym} 1080 600 2 0 {name=p66 sig_type=std_logic lab=y5}
C {lab_pin.sym} 1550 250 2 0 {name=p74 sig_type=std_logic lab=VP}
C {lab_pin.sym} 1550 270 2 0 {name=p75 sig_type=std_logic lab=GND}
C {lab_pin.sym} 1210 250 0 0 {name=p76 sig_type=std_logic lab=y0}
C {lab_pin.sym} 1210 270 0 0 {name=p77 sig_type=std_logic lab=y1}
C {lab_pin.sym} 1210 290 0 0 {name=p78 sig_type=std_logic lab=y2}
C {lab_pin.sym} 1550 350 2 0 {name=p79 sig_type=std_logic lab=VP}
C {lab_pin.sym} 1550 370 2 0 {name=p80 sig_type=std_logic lab=GND}
C {lab_pin.sym} 1210 350 0 0 {name=p81 sig_type=std_logic lab=y3}
C {lab_pin.sym} 1210 370 0 0 {name=p82 sig_type=std_logic lab=y4}
C {lab_pin.sym} 1210 390 0 0 {name=p83 sig_type=std_logic lab=y5}
C {/foss/designs/CHIP-PLL/divider/schematics/XNOR.sym} 900 230 0 0 {name=x2}
C {/foss/designs/CHIP-PLL/divider/schematics/XNOR.sym} 900 300 0 0 {name=x3}
C {/foss/designs/CHIP-PLL/divider/schematics/XNOR.sym} 900 370 0 0 {name=x4}
C {/foss/designs/CHIP-PLL/divider/schematics/XNOR.sym} 900 440 0 0 {name=x5}
C {/foss/designs/CHIP-PLL/divider/schematics/XNOR.sym} 900 510 0 0 {name=x6}
C {/foss/designs/CHIP-PLL/divider/schematics/XNOR.sym} 900 580 0 0 {name=x7}
C {/foss/designs/CHIP-PLL/divider/schematics/NAND_3in.sym} 1390 370 0 0 {name=x18}
C {/foss/designs/CHIP-PLL/divider/schematics/NAND_3in.sym} 1390 270 0 0 {name=x19}
C {/foss/designs/CHIP-PLL/divider/schematics/NOR_2in.sym} 1810 310 0 0 {name=x15}
C {lab_pin.sym} 1970 290 2 0 {name=p94 sig_type=std_logic lab=VP}
C {lab_pin.sym} 1970 310 2 0 {name=p95 sig_type=std_logic lab=GND}
C {lab_pin.sym} 2000 330 2 0 {name=p49 sig_type=std_logic lab=out}
C {lab_pin.sym} 1610 290 0 0 {name=p50 sig_type=std_logic lab=and012}
C {lab_pin.sym} 1610 330 0 0 {name=p51 sig_type=std_logic lab=and345}
C {lab_wire.sym} 730 210 0 0 {name=p26 sig_type=std_logic lab=div2
}
C {lab_wire.sym} 730 280 0 0 {name=p31 sig_type=std_logic lab=div4
}
C {lab_wire.sym} 730 350 0 0 {name=p35 sig_type=std_logic lab=div8
}
C {lab_wire.sym} 730 560 0 0 {name=p39 sig_type=std_logic lab=div64
}
C {lab_wire.sym} 730 490 0 0 {name=p43 sig_type=std_logic lab=div32
}
C {lab_wire.sym} 730 420 0 0 {name=p47 sig_type=std_logic lab=div16
}
C {gnd.sym} 700 510 0 0 {name=l2 lab=0
}
C {gnd.sym} 700 440 0 0 {name=l13 lab=0
}
C {lab_wire.sym} 700 230 0 0 {name=p28 sig_type=std_logic lab=d0
}
