v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -160 -100 -120 -100 {lab=q}
N -160 -180 -160 -100 {lab=q}
N -160 -180 180 -180 {lab=q}
N 180 -180 180 -100 {lab=q}
N 160 -100 180 -100 {lab=q}
N 60 50 70 50 {lab=#net1}
N 70 -100 90 -100 {lab=#net1}
N -50 50 -20 50 {lab=#net2}
N 70 -100 70 50 {lab=#net1}
N 60 -100 70 -100 {lab=#net1}
N -0 -70 0 20 {lab=clk_}
N -50 -100 -20 -100 {lab=#net3}
N -100 -140 -100 -130 {lab=VP}
N 40 -140 40 -130 {lab=VP}
N 110 -140 110 -130 {lab=VP}
N 40 10 40 20 {lab=VP}
N -100 10 -100 20 {lab=VP}
N -100 -70 -100 -50 {lab=GND}
N 40 -70 40 -50 {lab=GND}
N 110 -70 110 -50 {lab=GND}
N 40 80 40 100 {lab=GND}
N -0 80 -0 110 {lab=clk}
N -0 -140 -0 -130 {lab=clk}
N 180 -100 190 -100 {lab=q}
N -130 50 -120 50 {lab=d}
N -100 80 -100 100 {lab=GND}
N -240 -80 -230 -80 {lab=xxx}
N -240 -60 -230 -60 {lab=GND}
N -240 -40 -230 -40 {lab=clk}
N -240 -20 -230 -20 {lab=clk_}
C {/foss/designs/CHIP-PLL/divider/passgate.sym} 0 70 0 0 {name=x1}
C {/foss/designs/CHIP-PLL/divider/passgate.sym} 0 -80 0 0 {name=x2}
C {/foss/designs/CHIP-PLL/divider/inverter.sym} -100 50 0 0 {name=x3}
C {/foss/designs/CHIP-PLL/divider/inverter.sym} -100 -100 0 0 {name=x4}
C {/foss/designs/CHIP-PLL/divider/inverter.sym} 110 -100 0 0 {name=x5}
C {lab_wire.sym} -100 -140 0 0 {name=p18 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 40 -140 0 0 {name=p1 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 110 -140 0 0 {name=p2 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 40 10 0 0 {name=p3 sig_type=std_logic lab=VP
}
C {lab_wire.sym} -100 10 0 0 {name=p4 sig_type=std_logic lab=VP
}
C {lab_wire.sym} -100 -50 0 0 {name=p5 sig_type=std_logic lab=GND
}
C {lab_wire.sym} 40 -50 0 0 {name=p6 sig_type=std_logic lab=GND
}
C {lab_wire.sym} 110 -50 0 0 {name=p7 sig_type=std_logic lab=GND
}
C {lab_wire.sym} 40 100 0 0 {name=p8 sig_type=std_logic lab=GND
}
C {lab_wire.sym} 0 110 0 0 {name=p9 sig_type=std_logic lab=clk
}
C {lab_wire.sym} 0 -140 0 0 {name=p10 sig_type=std_logic lab=clk
}
C {lab_wire.sym} 0 -20 0 0 {name=p11 sig_type=std_logic lab=clk_
}
C {ipin.sym} -130 50 0 0 {name=p12 lab=d}
C {ipin.sym} -240 -40 0 0 {name=p13 lab=clk}
C {ipin.sym} -240 -20 0 0 {name=p14 lab=clk_}
C {iopin.sym} -240 -60 2 0 {name=p15 lab=GND}
C {iopin.sym} -240 -80 2 0 {name=p16 lab=VP
}
C {opin.sym} 190 -100 0 0 {name=p17 lab=q}
C {lab_wire.sym} -100 100 0 0 {name=p19 sig_type=std_logic lab=GND
}
C {lab_wire.sym} -230 -20 2 0 {name=p20 sig_type=std_logic lab=clk_
}
C {lab_wire.sym} -230 -40 2 0 {name=p21 sig_type=std_logic lab=clk
}
C {lab_wire.sym} -230 -80 2 0 {name=p22 sig_type=std_logic lab=VP
}
C {lab_wire.sym} -230 -60 2 0 {name=p23 sig_type=std_logic lab=GND
}
