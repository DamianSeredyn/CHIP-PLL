v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -910 100 -910 120 {lab=clk}
N -760 -180 -760 -170 {lab=VP}
N -880 -110 -880 -90 {lab=0}
N -880 -190 -880 -170 {lab=gnd!}
N -760 -110 -760 -100 {lab=gnd!}
N -910 180 -910 190 {lab=gnd!}
N -280 200 -280 220 {lab=gnd!}
N -360 110 -320 110 {lab=gnd!}
N -360 90 -340 90 {lab=VP}
N -680 70 -660 70 {lab=clk}
N -220 140 -220 160 {lab=gnd!}
N -360 130 -280 130 {lab=q_}
N -280 130 -280 140 {lab=q_}
N -360 70 -220 70 {lab=q}
N -220 70 -220 80 {lab=q}
N -910 -30 -910 -10 {lab=d}
N -910 50 -910 60 {lab=gnd!}
N -680 90 -660 90 {lab=q_}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} 50 -10 0 0 {}
C {/foss/designs/CHIP-PLL/divider/d_flip_flop.sym} -510 100 0 0 {}
C {devices/code_shown.sym} -890 -280 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} -570 -340 0 0 {name=NGSPICE only_toplevel=false
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
C {vsource.sym} -760 -140 0 0 {name=V1 value=1.2 savecurrent=false}
C {vsource.sym} -910 150 0 0 {name=V2 value="PULSE(0 1.2 0 10p 10p 3.335n 6.67n)" savecurrent=false}
C {capa.sym} -280 170 0 0 {name=C1
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} -880 -90 0 0 {name=l1 lab=0
}
C {lab_wire.sym} -910 100 0 0 {name=p2 sig_type=std_logic lab=clk
}
C {lab_wire.sym} -760 -180 0 0 {name=p8 sig_type=std_logic lab=VP
}
C {vsource.sym} -880 -140 0 0 {name=V0 value=0 savecurrent=false}
C {lab_wire.sym} -880 -180 0 0 {name=p9 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} -910 190 0 0 {name=p13 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} -760 -100 0 0 {name=p15 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} -280 220 0 0 {name=p22 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} -340 110 2 0 {name=p3 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} -340 90 2 0 {name=p10 sig_type=std_logic lab=VP
}
C {lab_wire.sym} -680 70 0 0 {name=p7 sig_type=std_logic lab=clk
}
C {capa.sym} -220 110 0 0 {name=C2
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {lab_wire.sym} -220 160 0 0 {name=p1 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} -300 70 2 0 {name=p4 sig_type=std_logic lab=q
}
C {lab_wire.sym} -330 130 2 0 {name=p5 sig_type=std_logic lab=q_
}
C {vsource.sym} -910 20 0 0 {name=V3 value="PULSE(0 1.2 0 10p 10p 10n 20n)" savecurrent=false}
C {lab_wire.sym} -910 -30 0 0 {name=p6 sig_type=std_logic lab=d
}
C {lab_wire.sym} -910 60 0 0 {name=p11 sig_type=std_logic lab=gnd!
}
C {lab_wire.sym} -680 90 3 0 {name=p14 sig_type=std_logic lab=q_
}
