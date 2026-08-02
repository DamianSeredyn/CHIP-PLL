v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -350 -30 -350 -10 {lab=clk}
N -200 -310 -200 -300 {lab=VP}
N -320 -240 -320 -220 {lab=0}
N -320 -320 -320 -300 {lab=gnd!}
N -200 -240 -200 -230 {lab=gnd!}
N -350 50 -350 60 {lab=gnd!}
N 650 -20 690 -20 {lab=gnd!}
N 650 -40 670 -40 {lab=VP}
N 560 -250 560 -230 {lab=gnd!}
N 420 -320 560 -320 {lab=div256}
N 560 -320 560 -310 {lab=div256}
N -350 -160 -350 -140 {lab=d}
N -350 -80 -350 -70 {lab=gnd!}
N 330 -40 350 -40 {lab=#net1}
N 330 -40 330 30 {lab=#net1}
N 330 30 660 30 {lab=#net1}
N 660 0 660 30 {lab=#net1}
N 650 0 660 0 {lab=#net1}
N 260 -60 350 -60 {lab=div2}
N 260 0 280 0 {lab=#net2}
N -60 30 280 30 {lab=#net2}
N -60 -40 -40 -40 {lab=#net2}
N -60 -60 -40 -60 {lab=clk}
N 260 -20 300 -20 {lab=gnd!}
N 260 -40 280 -40 {lab=VP}
N 1040 -20 1080 -20 {lab=gnd!}
N 1040 -40 1060 -40 {lab=VP}
N 720 -40 740 -40 {lab=#net3}
N 720 -40 720 30 {lab=#net3}
N 720 30 1050 30 {lab=#net3}
N 1050 0 1050 30 {lab=#net3}
N 1040 0 1050 0 {lab=#net3}
N 650 -60 740 -60 {lab=div4}
N 1430 -20 1470 -20 {lab=gnd!}
N 1430 -40 1450 -40 {lab=VP}
N 1110 -40 1130 -40 {lab=#net4}
N 1110 -40 1110 30 {lab=#net4}
N 1110 30 1440 30 {lab=#net4}
N 1440 0 1440 30 {lab=#net4}
N 1430 0 1440 0 {lab=#net4}
N 1040 -60 1130 -60 {lab=div8}
N -60 -40 -60 30 {lab=#net2}
N 280 0 280 30 {lab=#net2}
N 260 130 280 130 {lab=#net5}
N -60 160 280 160 {lab=#net5}
N -60 90 -40 90 {lab=#net5}
N 260 110 300 110 {lab=gnd!}
N 260 90 280 90 {lab=VP}
N -60 90 -60 160 {lab=#net5}
N 280 130 280 160 {lab=#net5}
N 1430 -60 1500 -60 {lab=div16}
N -110 70 -40 70 {lab=div16}
N 650 70 740 70 {lab=div64}
N 650 130 670 130 {lab=#net6}
N 330 160 670 160 {lab=#net6}
N 330 90 350 90 {lab=#net6}
N 650 110 690 110 {lab=gnd!}
N 650 90 670 90 {lab=VP}
N 330 90 330 160 {lab=#net6}
N 670 130 670 160 {lab=#net6}
N 260 70 350 70 {lab=div32}
N 1040 70 1130 70 {lab=div128}
N 1040 130 1060 130 {lab=#net7}
N 720 160 1060 160 {lab=#net7}
N 720 90 740 90 {lab=#net7}
N 1040 110 1080 110 {lab=gnd!}
N 1040 90 1060 90 {lab=VP}
N 720 90 720 160 {lab=#net7}
N 1060 130 1060 160 {lab=#net7}
N 1430 70 1520 70 {lab=div256}
N 1430 130 1450 130 {lab=#net8}
N 1110 160 1450 160 {lab=#net8}
N 1110 90 1130 90 {lab=#net8}
N 1430 110 1470 110 {lab=gnd!}
N 1430 90 1450 90 {lab=VP}
N 1110 90 1110 160 {lab=#net8}
N 1450 130 1450 160 {lab=#net8}
C {devices/code_shown.sym} -330 -410 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} -10 -470 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.control

op
print all
save all

tran 50p 5u
write divider_tb.raw
set appendwrite

plot v(div16)
plot v(div256)
.endc
"}
C {vsource.sym} -200 -270 0 0 {name=V1 value=1.2 savecurrent=false}
C {vsource.sym} -350 20 0 0 {name=V2 value="PULSE(0 1.2 0 100p 100p 3.335n 6.67n)" savecurrent=false}
C {gnd.sym} -320 -220 0 0 {name=l1 lab=0
}
C {lab_wire.sym} -350 -30 0 0 {name=p2 sig_type=std_logic lab=clk
}
C {lab_wire.sym} -200 -310 0 0 {name=p8 sig_type=std_logic lab=VP
}
C {vsource.sym} -320 -270 0 0 {name=V0 value=0 savecurrent=false}
C {lab_wire.sym} -320 -310 0 0 {name=p9 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} -350 60 0 0 {name=p13 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} -200 -230 0 0 {name=p15 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 670 -20 2 0 {name=p3 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 670 -40 2 0 {name=p10 sig_type=std_logic lab=VP
}
C {capa.sym} 560 -280 0 0 {name=C2
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} 560 -230 0 0 {name=p1 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} -350 -160 0 0 {name=p6 sig_type=std_logic lab=d
}
C {lab_wire.sym} -350 -70 0 0 {name=p11 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} -60 -60 0 0 {name=p7 sig_type=std_logic lab=clk
}
C {lab_wire.sym} 280 -20 2 0 {name=p12 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 280 -40 2 0 {name=p14 sig_type=std_logic lab=VP
}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 110 -30 0 0 {name=x1}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 500 -30 0 0 {name=x2}
C {lab_wire.sym} 1060 -20 2 0 {name=p16 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 1060 -40 2 0 {name=p17 sig_type=std_logic lab=VP
}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 890 -30 0 0 {name=x3}
C {lab_wire.sym} 1450 -20 2 0 {name=p18 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 1450 -40 2 0 {name=p19 sig_type=std_logic lab=VP
}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 1280 -30 0 0 {name=x4}
C {lab_wire.sym} 300 -60 2 0 {name=p20 sig_type=std_logic lab=div2
}
C {lab_wire.sym} 680 -60 2 0 {name=p21 sig_type=std_logic lab=div4
}
C {lab_wire.sym} 1070 -60 2 0 {name=p23 sig_type=std_logic lab=div8
}
C {lab_wire.sym} 1500 -60 2 0 {name=p24 sig_type=std_logic lab=div16
}
C {lab_wire.sym} 280 110 2 0 {name=p26 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 280 90 2 0 {name=p27 sig_type=std_logic lab=VP
}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 110 100 0 0 {name=x5}
C {lab_wire.sym} 300 70 2 0 {name=p32 sig_type=std_logic lab=div32
}
C {vsource.sym} -350 -110 0 0 {name=V3 value="PULSE(0 1.2 0 10p 10p 3.335n 6.67n)" savecurrent=false}
C {lab_wire.sym} -110 70 0 0 {name=p47 sig_type=std_logic lab=div16
}
C {lab_wire.sym} 440 -320 2 0 {name=p4 sig_type=std_logic lab=div256
}
C {lab_wire.sym} 670 110 2 0 {name=p5 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 670 90 2 0 {name=p22 sig_type=std_logic lab=VP
}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 500 100 0 0 {name=x6}
C {lab_wire.sym} 690 70 2 0 {name=p25 sig_type=std_logic lab=div64
}
C {lab_wire.sym} 1060 110 2 0 {name=p28 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 1060 90 2 0 {name=p29 sig_type=std_logic lab=VP
}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 890 100 0 0 {name=x7}
C {lab_wire.sym} 1080 70 2 0 {name=p30 sig_type=std_logic lab=div128
}
C {lab_wire.sym} 1450 110 2 0 {name=p31 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 1450 90 2 0 {name=p33 sig_type=std_logic lab=VP
}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 1280 100 0 0 {name=x8}
C {lab_wire.sym} 1470 70 2 0 {name=p34 sig_type=std_logic lab=div256
}
