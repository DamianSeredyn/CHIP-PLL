v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -310 70 -310 80 {lab=VP}
N -310 -20 -310 -10 {lab=0}
N 240 370 280 370 {lab=0}
N 240 350 260 350 {lab=VP}
N -80 330 -60 330 {lab=clk}
N -310 230 -310 250 {lab=d}
N -310 310 -310 320 {lab=0}
N -80 350 -60 350 {lab=d}
N 240 330 320 330 {lab=d0}
N 320 350 320 400 {lab=d0}
N 320 350 410 350 {lab=d0}
N 320 330 320 350 {lab=d0}
N 390 330 410 330 {lab=clk}
N 710 330 790 330 {lab=d1}
N 790 360 790 400 {lab=d1}
N 710 370 750 370 {lab=0}
N 710 350 730 350 {lab=VP}
N 790 360 880 360 {lab=d1}
N 860 340 880 340 {lab=clk}
N 1180 340 1260 340 {lab=d2}
N 1260 360 1260 410 {lab=d2}
N 1180 380 1220 380 {lab=0}
N 1180 360 1200 360 {lab=VP}
N 790 330 790 360 {lab=d1}
N 1260 360 1350 360 {lab=d2}
N 1330 340 1350 340 {lab=clk}
N 1650 340 1730 340 {lab=d3}
N 1730 340 1730 410 {lab=d3}
N 1650 380 1690 380 {lab=#net1}
N 1650 360 1670 360 {lab=VP}
N 1260 340 1260 360 {lab=d2}
N 320 650 320 670 {lab=0}
N 240 560 280 560 {lab=0}
N 240 540 260 540 {lab=VP}
N -80 520 -60 520 {lab=clk}
N -80 540 -60 540 {lab=d3}
N 240 520 320 520 {lab=d4}
N 320 540 320 590 {lab=d4}
N 320 540 410 540 {lab=d4}
N 320 520 320 540 {lab=d4}
N 390 520 410 520 {lab=clk}
N 790 650 790 670 {lab=0}
N 710 520 790 520 {lab=d5}
N 790 550 790 590 {lab=d5}
N 710 560 750 560 {lab=0}
N 710 540 730 540 {lab=VP}
N 790 550 880 550 {lab=d5}
N 860 530 880 530 {lab=clk}
N 1260 660 1260 680 {lab=0}
N 1180 530 1260 530 {lab=d6}
N 1260 550 1260 600 {lab=d6}
N 1180 570 1220 570 {lab=0}
N 1180 550 1200 550 {lab=VP}
N 790 520 790 550 {lab=d5}
N 1260 550 1350 550 {lab=d6}
N 1330 530 1350 530 {lab=clk}
N 1730 660 1730 680 {lab=0}
N 1650 530 1730 530 {lab=d7}
N 1730 530 1730 600 {lab=d7}
N 1650 570 1690 570 {lab=#net2}
N 1650 550 1670 550 {lab=VP}
N 1260 530 1260 550 {lab=d6}
N 320 460 320 480 {lab=0}
N 790 460 790 480 {lab=0}
N 1260 470 1260 490 {lab=0}
N 1730 470 1730 490 {lab=0}
N -310 140 -310 150 {lab=0}
N 800 50 890 50 {lab=_clk_un}
N 410 30 500 30 {lab=clk_in}
N 800 30 840 30 {lab=0}
N 800 10 820 10 {lab=VP}
N -310 430 -310 450 {lab=data_en}
N -310 510 -310 520 {lab=0}
N -310 -100 -310 -80 {lab=clk_in}
N 410 10 500 10 {lab=data_en}
N 960 50 1030 50 {lab=clk_buf}
N 910 -10 910 20 {lab=VP}
N 910 80 910 100 {lab=0}
N 1250 50 1270 50 {lab=clk}
N 1100 50 1180 50 {lab=_clk_buf}
N 1050 -10 1050 20 {lab=VP}
N 1200 -10 1200 20 {lab=VP}
N 1050 80 1050 100 {lab=0}
N 1200 80 1200 100 {lab=0}
C {devices/code_shown.sym} -60 -10 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} -50 -290 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.control

op
print all
save all

tran 50p 200n
write d_flip_flop_tb.raw
set appendwrite

meas tran v_d0 AVG v(d0) FROM=170n TO=180n


print d0_logic

.endc
"}
C {vsource.sym} -310 110 0 0 {name=V1 value=1.2 savecurrent=false}
C {vsource.sym} -310 -50 0 0 {name=V2 value="PULSE(1.2 0 0 10p 10p 5n 10n)" savecurrent=false}
C {capa.sym} 320 430 0 0 {name=C1
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} 1270 50 2 0 {name=p2 sig_type=std_logic lab=clk
}
C {lab_wire.sym} -310 70 0 0 {name=p8 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 260 350 2 0 {name=p10 sig_type=std_logic lab=VP
}
C {lab_wire.sym} -80 330 0 0 {name=p7 sig_type=std_logic lab=clk
}
C {lab_wire.sym} 300 330 2 0 {name=p4 sig_type=std_logic lab=d0
}
C {vsource.sym} -310 280 0 0 {name=V3 value="PWL(
+ 0 0 
+ 92.5n 0 
+ 92.51n 1.2
+ 112.5n 1.2 
+ 112.51n 0
+ 122.5n 0
+ 122.51n 1.2
+ 132.5n 1.2
+ 132.51n 0
+ 162.5n 0
+ 162.51n 1.2
+ 172.5n 1.2
+ 172.51n 0)" savecurrent=false}
C {lab_wire.sym} -310 230 0 0 {name=p6 sig_type=std_logic lab=d
}
C {lab_wire.sym} 390 330 0 0 {name=p1 sig_type=std_logic lab=clk
}
C {capa.sym} 790 430 0 0 {name=C2
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} 770 330 2 0 {name=p14 sig_type=std_logic lab=d1
}
C {lab_wire.sym} 730 350 2 0 {name=p17 sig_type=std_logic lab=VP
}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 560 360 0 0 {name=x1}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 90 360 0 0 {name=x2}
C {lab_wire.sym} 860 340 0 0 {name=p18 sig_type=std_logic lab=clk
}
C {lab_wire.sym} 1240 340 2 0 {name=p20 sig_type=std_logic lab=d2
}
C {lab_wire.sym} 1200 360 2 0 {name=p23 sig_type=std_logic lab=VP
}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 1030 370 0 0 {name=x3}
C {lab_wire.sym} 1330 340 0 0 {name=p24 sig_type=std_logic lab=clk
}
C {lab_wire.sym} 1710 340 2 0 {name=p26 sig_type=std_logic lab=d3
}
C {lab_wire.sym} 1670 360 2 0 {name=p28 sig_type=std_logic lab=VP
}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 1500 370 0 0 {name=x4}
C {capa.sym} 320 620 0 0 {name=C5
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} 260 540 2 0 {name=p31 sig_type=std_logic lab=VP
}
C {lab_wire.sym} -80 520 0 0 {name=p32 sig_type=std_logic lab=clk
}
C {lab_wire.sym} 300 520 2 0 {name=p33 sig_type=std_logic lab=d4

}
C {lab_wire.sym} 390 520 0 0 {name=p35 sig_type=std_logic lab=clk
}
C {capa.sym} 790 620 0 0 {name=C6
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} 770 520 2 0 {name=p37 sig_type=std_logic lab=d5
}
C {lab_wire.sym} 730 540 2 0 {name=p39 sig_type=std_logic lab=VP
}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 560 550 0 0 {name=x5}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 90 550 0 0 {name=x6}
C {lab_wire.sym} 860 530 0 0 {name=p40 sig_type=std_logic lab=clk
}
C {capa.sym} 1260 630 0 0 {name=C7
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} 1240 530 2 0 {name=p42 sig_type=std_logic lab=d6
}
C {lab_wire.sym} 1200 550 2 0 {name=p44 sig_type=std_logic lab=VP
}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 1030 560 0 0 {name=x7}
C {lab_wire.sym} 1330 530 0 0 {name=p45 sig_type=std_logic lab=clk
}
C {capa.sym} 1730 630 0 0 {name=C8
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} 1710 530 2 0 {name=p47 sig_type=std_logic lab=d7
}
C {lab_wire.sym} 1670 550 2 0 {name=p49 sig_type=std_logic lab=VP
}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 1500 560 0 0 {name=x8}
C {lab_wire.sym} -80 540 2 0 {name=p34 sig_type=std_logic lab=d3
}
C {lab_wire.sym} -80 350 0 0 {name=p12 sig_type=std_logic lab=d
}
C {gnd.sym} 320 670 0 0 {name=l2 lab=0
}
C {gnd.sym} 790 670 0 0 {name=l3 lab=0
}
C {gnd.sym} 1260 680 0 0 {name=l4 lab=0
}
C {gnd.sym} 1730 680 0 0 {name=l5 lab=0
}
C {capa.sym} 1260 440 0 0 {name=C9
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 1730 440 0 0 {name=C10
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 320 480 0 0 {name=l6 lab=0
}
C {gnd.sym} 790 480 0 0 {name=l7 lab=0
}
C {gnd.sym} 1260 490 0 0 {name=l8 lab=0
}
C {gnd.sym} 1730 490 0 0 {name=l9 lab=0
}
C {gnd.sym} 280 560 0 0 {name=l1 lab=0
}
C {gnd.sym} 280 370 0 0 {name=l10 lab=0
}
C {gnd.sym} 750 560 0 0 {name=l11 lab=0
}
C {gnd.sym} 750 370 0 0 {name=l12 lab=0
}
C {gnd.sym} 1220 570 0 0 {name=l13 lab=0
}
C {gnd.sym} 1220 380 0 0 {name=l14 lab=0
}
C {gnd.sym} 1690 560 0 0 {name=l15 lab=0
}
C {gnd.sym} 1690 370 0 0 {name=l16 lab=0
}
C {gnd.sym} -310 -10 0 0 {name=l17 lab=0
}
C {gnd.sym} -310 320 0 0 {name=l18 lab=0
}
C {gnd.sym} -310 150 0 0 {name=l19 lab=0
}
C {/foss/designs/CHIP-PLL/divider/NAND_2in.sym} 650 30 0 0 {name=x9}
C {lab_wire.sym} 820 10 2 0 {name=p3 sig_type=std_logic lab=VP
}
C {gnd.sym} 840 30 0 0 {name=l20 lab=0
}
C {vsource.sym} -310 480 0 0 {name=V4 value="PWL(
+ 0 1.2 
+ 172.6n 1.2
+ 172.61n 0)" savecurrent=false}
C {lab_wire.sym} -310 430 0 0 {name=p5 sig_type=std_logic lab=data_en
}
C {gnd.sym} -310 520 0 0 {name=l21 lab=0
}
C {lab_wire.sym} 410 30 0 0 {name=p9 sig_type=std_logic lab=clk_in
}
C {lab_wire.sym} 410 10 0 0 {name=p11 sig_type=std_logic lab=data_en
}
C {lab_wire.sym} -310 -100 0 0 {name=p13 sig_type=std_logic lab=clk_in
}
C {lab_wire.sym} 910 -10 2 0 {name=p15 sig_type=std_logic lab=VP
}
C {gnd.sym} 910 100 0 0 {name=l22 lab=0
}
C {lab_wire.sym} 1050 -10 2 0 {name=p16 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 1200 -10 2 0 {name=p19 sig_type=std_logic lab=VP
}
C {gnd.sym} 1050 100 0 0 {name=l23 lab=0
}
C {gnd.sym} 1200 100 0 0 {name=l24 lab=0
}
C {lab_wire.sym} 840 50 2 0 {name=p21 sig_type=std_logic lab=_clk_un
}
C {lab_wire.sym} 970 50 2 0 {name=p22 sig_type=std_logic lab=clk_buf
}
C {lab_wire.sym} 1110 50 2 0 {name=p25 sig_type=std_logic lab=_clk_buf
}
C {/foss/designs/CHIP-PLL/divider/inverter_x2.sym} 920 50 0 0 {name=x11}
C {/foss/designs/CHIP-PLL/divider/inverter_x8.sym} 1060 50 0 0 {name=x12}
C {/foss/designs/CHIP-PLL/divider/inverter_x16.sym} 1210 50 0 0 {}
