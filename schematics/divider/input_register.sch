v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 150 -10 170 -10 {lab=GND}
N 150 10 170 10 {lab=VP}
N -190 -30 -150 -30 {lab=clk_in}
N -190 -10 -150 -10 {lab=serial_data_in}
N 310 -30 350 -30 {lab=clk_in}
N 150 -30 230 -30 {lab=d0}
N 230 -30 230 -10 {lab=d0}
N 230 -10 350 -10 {lab=d0}
N 230 -50 230 -30 {lab=d0}
N 650 -10 670 -10 {lab=GND}
N 650 10 670 10 {lab=VP}
N 810 -30 850 -30 {lab=clk_in}
N 650 -30 730 -30 {lab=d1}
N 730 -30 730 -10 {lab=d1}
N 730 -10 850 -10 {lab=d1}
N 730 -50 730 -30 {lab=d1}
N 1150 -10 1170 -10 {lab=GND}
N 1150 10 1170 10 {lab=VP}
N 1310 -30 1350 -30 {lab=clk_in}
N 1150 -30 1230 -30 {lab=d2}
N 1230 -30 1230 -10 {lab=d2}
N 1230 -10 1350 -10 {lab=d2}
N 1230 -50 1230 -30 {lab=d2}
N 1650 -10 1670 -10 {lab=GND}
N 1650 10 1670 10 {lab=VP}
N 1650 -30 1730 -30 {lab=d3}
N 1730 -50 1730 -30 {lab=d3}
N 150 120 170 120 {lab=GND}
N 150 140 170 140 {lab=VP}
N -190 100 -150 100 {lab=clk_in}
N -190 120 -150 120 {lab=d3}
N 310 100 350 100 {lab=clk_in}
N 150 100 230 100 {lab=d4}
N 230 100 230 120 {lab=d4}
N 230 120 350 120 {lab=d4}
N 230 80 230 100 {lab=d4}
N 650 120 670 120 {lab=GND}
N 650 140 670 140 {lab=VP}
N 810 100 850 100 {lab=clk_in}
N 650 100 730 100 {lab=d5}
N 730 100 730 120 {lab=d5}
N 730 120 850 120 {lab=d5}
N 730 80 730 100 {lab=d5}
N 1150 120 1170 120 {lab=GND}
N 1150 140 1170 140 {lab=VP}
N 1310 100 1350 100 {lab=clk_in}
N 1150 100 1230 100 {lab=d6}
N 1230 100 1230 120 {lab=d6}
N 1230 120 1350 120 {lab=d6}
N 1230 80 1230 100 {lab=d6}
N 1650 120 1670 120 {lab=GND}
N 1650 140 1670 140 {lab=VP}
N 1650 100 1730 100 {lab=d7}
N 1730 80 1730 100 {lab=d7}
N 150 250 170 250 {lab=GND}
N 150 270 170 270 {lab=VP}
N -190 230 -150 230 {lab=clk_in}
N -190 250 -150 250 {lab=d7}
N 310 230 350 230 {lab=clk_in}
N 150 230 230 230 {lab=d8}
N 230 230 230 250 {lab=d8}
N 230 250 350 250 {lab=d8}
N 230 210 230 230 {lab=d8}
N 650 250 670 250 {lab=GND}
N 650 270 670 270 {lab=VP}
N 810 230 850 230 {lab=clk_in}
N 650 230 730 230 {lab=d9}
N 730 230 730 250 {lab=d9}
N 730 250 850 250 {lab=d9}
N 730 210 730 230 {lab=d9}
N 1150 250 1170 250 {lab=GND}
N 1150 270 1170 270 {lab=VP}
N 1310 230 1350 230 {lab=clk_in}
N 1150 230 1230 230 {lab=d10}
N 1230 230 1230 250 {lab=d10}
N 1230 250 1350 250 {lab=d10}
N 1230 210 1230 230 {lab=d10}
N 1650 250 1670 250 {lab=GND}
N 1650 270 1670 270 {lab=VP}
N 1650 230 1730 230 {lab=d11}
N 1730 210 1730 230 {lab=d11}
N 150 380 170 380 {lab=GND}
N 150 400 170 400 {lab=VP}
N -190 360 -150 360 {lab=clk_in}
N -190 380 -150 380 {lab=d11}
N 150 360 230 360 {lab=d12}
N 230 340 230 360 {lab=d12}
N -220 -180 -200 -180 {lab=VP}
N -220 -160 -200 -160 {lab=GND}
N -220 -140 -200 -140 {lab=clk_in}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 0 0 0 0 {name=x1}
C {ipin.sym} -190 -10 0 0 {name=p1 lab=serial_data_in}
C {iopin.sym} -220 -180 2 0 {name=p2 lab=VP}
C {opin.sym} 230 -50 3 0 {name=p3 lab=d0}
C {ipin.sym} -220 -140 0 0 {name=p4 lab=clk_in}
C {iopin.sym} -220 -160 2 0 {name=p5 lab=GND}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 500 0 0 0 {name=x2}
C {opin.sym} 730 -50 3 0 {name=p7 lab=d1}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 1000 0 0 0 {name=x3}
C {opin.sym} 1230 -50 3 0 {name=p12 lab=d2
}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 1500 0 0 0 {name=x4}
C {opin.sym} 1730 -50 3 0 {name=p16 lab=d3
}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 0 130 0 0 {name=x5}
C {opin.sym} 230 80 3 0 {name=p20 lab=d4}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 500 130 0 0 {name=x6}
C {opin.sym} 730 80 3 0 {name=p25 lab=d5}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 1000 130 0 0 {name=x7}
C {opin.sym} 1230 80 3 0 {name=p29 lab=d6
}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 1500 130 0 0 {name=x8}
C {opin.sym} 1730 80 3 0 {name=p33 lab=d7
}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 0 260 0 0 {name=x9}
C {opin.sym} 230 210 3 0 {name=p36 lab=d8}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 500 260 0 0 {name=x10}
C {opin.sym} 730 210 3 0 {name=p41 lab=d9}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 1000 260 0 0 {name=x11}
C {opin.sym} 1230 210 3 0 {name=p45 lab=d10
}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 1500 260 0 0 {name=x12}
C {opin.sym} 1730 210 3 0 {name=p49 lab=d11
}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 0 390 0 0 {name=x13}
C {opin.sym} 230 340 3 0 {name=p53 lab=d12}
C {lab_pin.sym} 170 -10 2 0 {name=p60 sig_type=std_logic lab=GND}
C {lab_pin.sym} 170 10 2 0 {name=p61 sig_type=std_logic lab=VP}
C {lab_pin.sym} 170 120 2 0 {name=p6 sig_type=std_logic lab=GND}
C {lab_pin.sym} 170 140 2 0 {name=p9 sig_type=std_logic lab=VP}
C {lab_pin.sym} 170 250 2 0 {name=p11 sig_type=std_logic lab=GND}
C {lab_pin.sym} 170 270 2 0 {name=p13 sig_type=std_logic lab=VP}
C {lab_pin.sym} 170 380 2 0 {name=p15 sig_type=std_logic lab=GND}
C {lab_pin.sym} 170 400 2 0 {name=p17 sig_type=std_logic lab=VP}
C {lab_pin.sym} 670 -10 2 0 {name=p19 sig_type=std_logic lab=GND}
C {lab_pin.sym} 670 10 2 0 {name=p22 sig_type=std_logic lab=VP}
C {lab_pin.sym} 670 120 2 0 {name=p24 sig_type=std_logic lab=GND}
C {lab_pin.sym} 670 140 2 0 {name=p26 sig_type=std_logic lab=VP}
C {lab_pin.sym} 670 250 2 0 {name=p28 sig_type=std_logic lab=GND}
C {lab_pin.sym} 670 270 2 0 {name=p30 sig_type=std_logic lab=VP}
C {lab_pin.sym} 1170 -10 2 0 {name=p35 sig_type=std_logic lab=GND}
C {lab_pin.sym} 1170 10 2 0 {name=p38 sig_type=std_logic lab=VP}
C {lab_pin.sym} 1170 120 2 0 {name=p40 sig_type=std_logic lab=GND}
C {lab_pin.sym} 1170 140 2 0 {name=p42 sig_type=std_logic lab=VP}
C {lab_pin.sym} 1170 250 2 0 {name=p44 sig_type=std_logic lab=GND}
C {lab_pin.sym} 1170 270 2 0 {name=p46 sig_type=std_logic lab=VP}
C {lab_pin.sym} 1670 -10 2 0 {name=p52 sig_type=std_logic lab=GND}
C {lab_pin.sym} 1670 10 2 0 {name=p55 sig_type=std_logic lab=VP}
C {lab_pin.sym} 1670 120 2 0 {name=p57 sig_type=std_logic lab=GND}
C {lab_pin.sym} 1670 140 2 0 {name=p59 sig_type=std_logic lab=VP}
C {lab_pin.sym} 1670 250 2 0 {name=p62 sig_type=std_logic lab=GND}
C {lab_pin.sym} 1670 270 2 0 {name=p63 sig_type=std_logic lab=VP}
C {lab_pin.sym} -190 -30 0 0 {name=p8 sig_type=std_logic lab=clk_in}
C {lab_pin.sym} -200 -160 2 0 {name=p10 sig_type=std_logic lab=GND}
C {lab_pin.sym} -200 -180 2 0 {name=p14 sig_type=std_logic lab=VP}
C {lab_pin.sym} -200 -140 2 0 {name=p21 sig_type=std_logic lab=clk_in}
C {lab_pin.sym} -190 100 0 0 {name=p23 sig_type=std_logic lab=clk_in}
C {lab_pin.sym} -190 230 0 0 {name=p27 sig_type=std_logic lab=clk_in}
C {lab_pin.sym} -190 360 0 0 {name=p31 sig_type=std_logic lab=clk_in}
C {lab_pin.sym} 310 -30 0 0 {name=p37 sig_type=std_logic lab=clk_in}
C {lab_pin.sym} 310 100 0 0 {name=p39 sig_type=std_logic lab=clk_in}
C {lab_pin.sym} 310 230 0 0 {name=p43 sig_type=std_logic lab=clk_in}
C {lab_pin.sym} 810 -30 0 0 {name=p48 sig_type=std_logic lab=clk_in}
C {lab_pin.sym} 810 100 0 0 {name=p50 sig_type=std_logic lab=clk_in}
C {lab_pin.sym} 810 230 0 0 {name=p54 sig_type=std_logic lab=clk_in}
C {lab_pin.sym} 1310 -30 0 0 {name=p56 sig_type=std_logic lab=clk_in}
C {lab_pin.sym} 1310 100 0 0 {name=p64 sig_type=std_logic lab=clk_in}
C {lab_pin.sym} 1310 230 0 0 {name=p65 sig_type=std_logic lab=clk_in}
C {lab_pin.sym} 1730 -30 2 0 {name=p66 sig_type=std_logic lab=d3}
C {lab_pin.sym} 1730 100 2 0 {name=p67 sig_type=std_logic lab=d7}
C {lab_pin.sym} 1730 230 2 0 {name=p69 sig_type=std_logic lab=d11}
C {lab_pin.sym} -190 120 0 0 {name=p70 sig_type=std_logic lab=d3}
C {lab_pin.sym} -190 250 0 0 {name=p71 sig_type=std_logic lab=d7}
C {lab_pin.sym} -190 380 0 0 {name=p72 sig_type=std_logic lab=d11}
