v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -380 110 -380 130 {lab=clk}
N -270 -20 -270 -10 {lab=VP}
N -270 50 -270 60 {lab=0}
N -380 190 -380 200 {lab=0}
N -380 -20 -380 0 {lab=d}
N -380 60 -380 70 {lab=0}
N 270 20 290 20 {lab=0}
N 270 0 320 -0 {lab=VP}
N 270 260 350 260 {lab=d11}
N 270 220 410 220 {lab=d9}
N 270 180 470 180 {lab=d7}
N 270 140 530 140 {lab=d5}
N 270 100 590 100 {lab=d3}
N -40 20 -30 20 {lab=d}
N -40 -0 -30 0 {lab=clk}
N 350 380 350 390 {lab=0}
N 320 460 320 470 {lab=0}
N 410 380 410 390 {lab=0}
N 380 460 380 470 {lab=0}
N 470 380 470 390 {lab=0}
N 440 460 440 470 {lab=0}
N 530 380 530 390 {lab=0}
N 500 460 500 470 {lab=0}
N 590 380 590 390 {lab=0}
N 650 380 650 390 {lab=0}
N 620 460 620 470 {lab=0}
N 680 460 680 470 {lab=0}
N 270 280 320 280 {lab=d12}
N 320 280 320 400 {lab=d12}
N 350 260 350 320 {lab=d11}
N 270 240 380 240 {lab=d10}
N 380 240 380 400 {lab=d10}
N 410 220 410 320 {lab=d9}
N 440 200 440 400 {lab=d8}
N 270 200 440 200 {lab=d8}
N 470 180 470 320 {lab=d7}
N 270 160 500 160 {lab=d6}
N 500 160 500 400 {lab=d6}
N 530 140 530 320 {lab=d5}
N 270 120 560 120 {lab=d4}
N 560 120 560 400 {lab=d4}
N 590 100 590 320 {lab=d3}
N 270 80 620 80 {lab=d2}
N 620 80 620 400 {lab=d2}
N 650 60 650 320 {lab=d1}
N 270 60 650 60 {lab=d1}
N 270 40 680 40 {lab=d0}
N 680 40 680 400 {lab=d0}
C {devices/code_shown.sym} -400 -120 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} 60 -540 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.control

op
print all
save all

tran 500p 15u
write input_register_tb.raw
set appendwrite

plot v(d0)
plot v(d1)
plot v(d2)
plot v(d3)
plot v(d4)
plot v(d5)
plot v(d6)
plot v(d7)
plot v(d8)
plot v(d9)
plot v(d10)
plot v(d11)
plot v(d12)
.endc
"}
C {vsource.sym} -270 20 0 0 {name=V1 value=1.2 savecurrent=false}
C {vsource.sym} -380 160 0 0 {name=V2 value="PULSE(0 1.2 0 100n 100n 500n 1u)" savecurrent=false}
C {lab_wire.sym} -380 110 0 0 {name=p2 sig_type=std_logic lab=clk
}
C {lab_wire.sym} -270 -20 0 0 {name=p8 sig_type=std_logic lab=VP
}
C {lab_wire.sym} -380 -20 0 0 {name=p6 sig_type=std_logic lab=d
}
C {vsource.sym} -380 30 0 0 {name=V3 value="PULSE(0 1.2 0 1n 1n 50m 100m)" savecurrent=false}
C {gnd.sym} -380 70 0 0 {name=l2 lab=0
}
C {gnd.sym} -380 200 0 0 {name=l3 lab=0
}
C {gnd.sym} -270 60 0 0 {name=l4 lab=0
}
C {lab_wire.sym} 320 0 2 0 {name=p3 sig_type=std_logic lab=VP
}
C {gnd.sym} 290 20 3 0 {name=l5 lab=0
}
C {lab_wire.sym} -40 0 0 0 {name=p1 sig_type=std_logic lab=clk
}
C {lab_wire.sym} -40 20 0 0 {name=p4 sig_type=std_logic lab=d
}
C {lab_wire.sym} 680 40 2 0 {name=p5 sig_type=std_logic lab=d0
}
C {capa.sym} 350 350 2 0 {name=C1
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 350 390 0 0 {name=l1 lab=0
}
C {capa.sym} 320 430 2 0 {name=C2
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 320 470 0 0 {name=l6 lab=0
}
C {capa.sym} 410 350 2 0 {name=C3
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 410 390 0 0 {name=l7 lab=0
}
C {capa.sym} 380 430 2 0 {name=C4
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 380 470 0 0 {name=l8 lab=0
}
C {capa.sym} 470 350 2 0 {name=C5
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 470 390 0 0 {name=l9 lab=0
}
C {capa.sym} 440 430 2 0 {name=C6
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 440 470 0 0 {name=l10 lab=0
}
C {capa.sym} 530 350 2 0 {name=C7
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 530 390 0 0 {name=l11 lab=0
}
C {capa.sym} 500 430 2 0 {name=C9
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 500 470 0 0 {name=l13 lab=0
}
C {capa.sym} 590 350 2 0 {name=C10
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 590 390 0 0 {name=l14 lab=0
}
C {capa.sym} 560 430 2 0 {name=C11
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 560 470 0 0 {name=l15 lab=0
}
C {capa.sym} 650 350 2 0 {name=C12
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 650 390 0 0 {name=l16 lab=0
}
C {capa.sym} 620 430 2 0 {name=C13
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 620 470 0 0 {name=l17 lab=0
}
C {capa.sym} 680 430 2 0 {name=C15
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 680 470 0 0 {name=l19 lab=0
}
C {lab_wire.sym} 650 60 2 0 {name=p7 sig_type=std_logic lab=d1
}
C {lab_wire.sym} 620 80 2 0 {name=p9 sig_type=std_logic lab=d2
}
C {lab_wire.sym} 590 100 2 0 {name=p10 sig_type=std_logic lab=d3
}
C {lab_wire.sym} 560 120 2 0 {name=p11 sig_type=std_logic lab=d4
}
C {lab_wire.sym} 530 140 2 0 {name=p12 sig_type=std_logic lab=d5
}
C {lab_wire.sym} 500 160 2 0 {name=p13 sig_type=std_logic lab=d6
}
C {lab_wire.sym} 470 180 2 0 {name=p14 sig_type=std_logic lab=d7
}
C {lab_wire.sym} 440 200 2 0 {name=p15 sig_type=std_logic lab=d8
}
C {lab_wire.sym} 410 220 2 0 {name=p16 sig_type=std_logic lab=d9
}
C {lab_wire.sym} 380 240 2 0 {name=p17 sig_type=std_logic lab=d10
}
C {lab_wire.sym} 350 260 2 0 {name=p18 sig_type=std_logic lab=d11
}
C {lab_wire.sym} 320 280 2 0 {name=p19 sig_type=std_logic lab=d12
}
C {/foss/designs/CHIP-PLL/divider/input_register.sym} 120 140 0 0 {name=x1}
