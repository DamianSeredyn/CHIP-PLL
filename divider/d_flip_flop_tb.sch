v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -310 360 -310 380 {lab=clk}
N -160 80 -160 90 {lab=VP}
N -280 150 -280 170 {lab=0}
N -280 70 -280 90 {lab=gnd!}
N -160 150 -160 160 {lab=gnd!}
N -310 440 -310 450 {lab=gnd!}
N 320 460 320 480 {lab=gnd!}
N 240 370 280 370 {lab=gnd!}
N 240 350 260 350 {lab=VP}
N -80 330 -60 330 {lab=clk}
N 380 400 380 420 {lab=gnd!}
N 240 390 320 390 {lab=q_}
N 320 390 320 400 {lab=q_}
N 240 330 380 330 {lab=q}
N 380 330 380 340 {lab=q}
N -310 230 -310 250 {lab=d}
N -310 310 -310 320 {lab=gnd!}
N -80 350 -60 350 {lab=q_}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 90 360 0 0 {}
C {devices/code_shown.sym} -290 -20 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} 30 -80 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.control

op
print all
save all

tran 50p 200n
write d_flip_flop_tb.raw
set appendwrite

plot v(clk) v(q)
.endc
"}
C {vsource.sym} -160 120 0 0 {name=V1 value=1.2 savecurrent=false}
C {vsource.sym} -310 410 0 0 {name=V2 value="PULSE(0 1.2 0 10p 10p 3.335n 6.67n)" savecurrent=false}
C {capa.sym} 320 430 0 0 {name=C1
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} -280 170 0 0 {name=l1 lab=0
}
C {lab_wire.sym} -310 360 0 0 {name=p2 sig_type=std_logic lab=clk
}
C {lab_wire.sym} -160 80 0 0 {name=p8 sig_type=std_logic lab=VP
}
C {vsource.sym} -280 120 0 0 {name=V0 value=0 savecurrent=false}
C {lab_wire.sym} -280 80 0 0 {name=p9 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} -310 450 0 0 {name=p13 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} -160 160 0 0 {name=p15 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 320 480 0 0 {name=p22 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 260 370 2 0 {name=p3 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 260 350 2 0 {name=p10 sig_type=std_logic lab=VP
}
C {lab_wire.sym} -80 330 0 0 {name=p7 sig_type=std_logic lab=clk
}
C {capa.sym} 380 370 0 0 {name=C2
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} 380 420 0 0 {name=p1 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} 300 330 2 0 {name=p4 sig_type=std_logic lab=q
}
C {lab_wire.sym} 270 390 2 0 {name=p5 sig_type=std_logic lab=q_
}
C {vsource.sym} -310 280 0 0 {name=V3 value="PULSE(0 1.2 0 10p 10p 10n 20n)" savecurrent=false}
C {lab_wire.sym} -310 230 0 0 {name=p6 sig_type=std_logic lab=d
}
C {lab_wire.sym} -310 320 0 0 {name=p11 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} -80 350 3 0 {name=p14 sig_type=std_logic lab=q_
}
