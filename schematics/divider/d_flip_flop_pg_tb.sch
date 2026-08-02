v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -420 -10 -420 10 {lab=clk}
N -310 -180 -310 -170 {lab=VP}
N -430 -110 -430 -90 {lab=0}
N -430 -190 -430 -170 {lab=gnd!}
N -310 -110 -310 -100 {lab=gnd!}
N -420 70 -420 80 {lab=gnd!}
N 180 140 180 160 {lab=gnd!}
N 140 80 180 80 {lab=#net1}
N 90 120 90 160 {lab=gnd!}
N 90 100 110 100 {lab=VP}
N -420 130 -420 150 {lab=clk_}
N -420 210 -420 220 {lab=gnd!}
N -230 80 -210 80 {lab=clk}
N -230 100 -210 100 {lab=clk_}
N -230 120 -210 120 {lab=q_}
N 230 10 250 10 {lab=q_}
N 140 10 160 10 {lab=#net1}
N 180 -40 180 -20 {lab=VP}
N 180 40 180 60 {lab=gnd!}
N 140 10 140 80 {lab=#net1}
N 90 80 140 80 {lab=#net1}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} -60 100 0 0 {}
C {devices/code_shown.sym} -440 -280 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} -120 -340 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.control

op
print all
save all

tran 50p 200n
write d_flip_flop_tb.raw
set appendwrite
plot v(clk) v(q_) 

.endc
"}
C {vsource.sym} -310 -140 0 0 {name=V1 value=1.2 savecurrent=false}
C {vsource.sym} -420 40 0 0 {name=V2 value="PULSE(0 1.2 0 10p 10p 3.335n 6.67n)" savecurrent=false}
C {capa.sym} 180 110 0 0 {name=C1
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} -430 -90 0 0 {name=l1 lab=0
}
C {lab_wire.sym} -420 -10 0 0 {name=p2 sig_type=std_logic lab=clk
}
C {lab_wire.sym} -310 -180 0 0 {name=p8 sig_type=std_logic lab=VP
}
C {vsource.sym} -430 -140 0 0 {name=V0 value=0 savecurrent=false}
C {lab_wire.sym} -430 -180 0 0 {name=p9 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} -420 80 0 0 {name=p13 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} -310 -100 0 0 {name=p15 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 180 160 0 0 {name=p22 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 90 160 0 0 {name=p3 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 110 100 2 0 {name=p10 sig_type=std_logic lab=VP
}
C {vsource.sym} -420 180 0 0 {name=V4 value="PULSE(1.2 0 0 10p 10p 3.335n 6.67n)" savecurrent=false}
C {lab_wire.sym} -420 130 0 0 {name=p1 sig_type=std_logic lab=clk_
}
C {lab_wire.sym} -420 220 0 0 {name=p5 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} -230 100 0 0 {name=p6 sig_type=std_logic lab=clk_
}
C {lab_wire.sym} -230 80 0 0 {name=p7 sig_type=std_logic lab=clk
}
C {/foss/designs/CHIP-PLL/divider/inverter.sym} 180 10 0 0 {name=x3}
C {lab_wire.sym} 180 -40 0 0 {name=p18 sig_type=std_logic lab=VP
}
C {lab_wire.sym} 180 60 0 0 {name=p19 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 250 10 2 0 {name=p14 sig_type=std_logic lab=q_
}
C {lab_wire.sym} -230 120 2 0 {name=p4 sig_type=std_logic lab=q_
}
