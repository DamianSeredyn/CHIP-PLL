v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -110 0 -110 20 {lab=clk}
N -50 -190 -50 -180 {lab=VP}
N -110 80 -110 100 {lab=0}
N -50 -120 -50 -100 {lab=0}
N -390 430 -390 450 {lab=0}
N -270 430 -270 450 {lab=0}
N -150 430 -150 450 {lab=0}
N -390 340 -390 370 {lab=d0}
N -270 340 -270 370 {lab=d1}
N -150 340 -150 370 {lab=d2}
N -390 610 -390 630 {lab=0}
N -270 610 -270 630 {lab=0}
N -150 610 -150 630 {lab=0}
N -390 520 -390 550 {lab=d3}
N -270 520 -270 550 {lab=d4}
N -150 520 -150 550 {lab=d5}
N -80 450 -80 470 {lab=a1}
N -80 530 -80 550 {lab=0}
N -80 300 -80 320 {lab=a0}
N -80 380 -80 400 {lab=0}
N -80 600 -80 620 {lab=a2}
N -80 680 -80 700 {lab=0}
N 510 170 560 170 {lab=VP}
N 510 150 530 150 {lab=0}
N 560 370 560 390 {lab=0}
N 560 190 560 310 {lab=out_div}
N 510 190 560 190 {lab=out_div}
N 210 130 210 150 {lab=clk}
N 180 170 210 170 {lab=d0}
N 180 190 210 190 {lab=d1}
N 180 210 210 210 {lab=d2}
N 180 230 210 230 {lab=d3}
N 180 250 210 250 {lab=d4}
N 180 270 210 270 {lab=d5}
N 180 290 210 290 {lab=a0}
N 180 310 210 310 {lab=a1}
N 180 330 210 330 {lab=a2}
C {vsource.sym} -50 -150 0 0 {name=V1 value=1.2 savecurrent=false}
C {vsource.sym} -110 50 0 0 {name=V2 value="PULSE(0 1.2 0 100p 100p 1.5625n 3.125n)" savecurrent=false}
C {lab_wire.sym} -110 0 0 0 {name=p2 sig_type=std_logic lab=clk
}
C {lab_wire.sym} -50 -190 0 0 {name=p8 sig_type=std_logic lab=VP
}
C {gnd.sym} -110 100 0 0 {name=l3 lab=0
}
C {gnd.sym} -390 450 0 0 {name=l5 lab=0
}
C {gnd.sym} -270 450 0 0 {name=l6 lab=0
}
C {gnd.sym} -150 450 0 0 {name=l7 lab=0
}
C {lab_wire.sym} -390 520 1 0 {name=p20 sig_type=std_logic lab=d3
}
C {lab_wire.sym} -390 340 1 0 {name=p21 sig_type=std_logic lab=d0
}
C {lab_wire.sym} -150 340 1 0 {name=p22 sig_type=std_logic lab=d2
}
C {gnd.sym} -50 -100 0 0 {name=l13 lab=0
}
C {gnd.sym} -390 630 0 0 {name=l8 lab=0
}
C {gnd.sym} -270 630 0 0 {name=l10 lab=0
}
C {gnd.sym} -150 630 0 0 {name=l34 lab=0
}
C {lab_wire.sym} -150 520 1 0 {name=p49 sig_type=std_logic lab=d5
}
C {lab_wire.sym} -270 340 1 0 {name=p51 sig_type=std_logic lab=d1
}
C {lab_wire.sym} -270 520 1 0 {name=p50 sig_type=std_logic lab=d4
}
C {vsource.sym} -270 580 0 0 {name=V8 value=0 savecurrent=false}
C {vsource.sym} -150 580 0 0 {name=V9 value=0 savecurrent=false}
C {vsource.sym} -390 400 0 0 {name=V11 value=1.2 savecurrent=false}
C {vsource.sym} -270 400 0 0 {name=V10 value=1.2  savecurrent=false}
C {vsource.sym} -150 400 0 0 {name=V12 value=0 savecurrent=false}
C {vsource.sym} -390 580 0 0 {name=V7 value=0 savecurrent=false}
C {vsource.sym} -80 500 0 0 {name=V5 value=1.2 savecurrent=false}
C {lab_wire.sym} -80 450 0 0 {name=p24 sig_type=std_logic lab=a1
}
C {gnd.sym} -80 550 0 0 {name=l15 lab=0
}
C {vsource.sym} -80 350 0 0 {name=V6 value=1.2 savecurrent=false}
C {lab_wire.sym} -80 300 0 0 {name=p25 sig_type=std_logic lab=a0
}
C {gnd.sym} -80 400 0 0 {name=l16 lab=0
}
C {vsource.sym} -80 650 0 0 {name=V13 value=1.2 savecurrent=false}
C {lab_wire.sym} -80 600 0 0 {name=p27 sig_type=std_logic lab=a2
}
C {gnd.sym} -80 700 0 0 {name=l17 lab=0
}
C {/foss/designs/CHIP-PLL/divider/schematics/Divider_top.sym} 360 240 0 0 {name=x1}
C {lab_wire.sym} 560 170 0 0 {name=p1 sig_type=std_logic lab=VP
}
C {gnd.sym} 530 150 3 1 {name=l2 lab=0
}
C {capa.sym} 560 340 0 0 {name=C6
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 560 390 0 0 {name=l18 lab=0
}
C {lab_wire.sym} 560 190 0 0 {name=p3 sig_type=std_logic lab=out_div
}
C {lab_wire.sym} 210 130 0 0 {name=p4 sig_type=std_logic lab=clk
}
C {lab_wire.sym} 180 170 1 0 {name=p5 sig_type=std_logic lab=d0
}
C {lab_wire.sym} 180 190 1 0 {name=p6 sig_type=std_logic lab=d1
}
C {lab_wire.sym} 180 210 1 0 {name=p7 sig_type=std_logic lab=d2
}
C {lab_wire.sym} 180 230 1 0 {name=p9 sig_type=std_logic lab=d3
}
C {lab_wire.sym} 180 250 1 0 {name=p10 sig_type=std_logic lab=d4
}
C {lab_wire.sym} 180 270 1 0 {name=p11 sig_type=std_logic lab=d5
}
C {lab_wire.sym} 180 290 0 0 {name=p12 sig_type=std_logic lab=a0
}
C {lab_wire.sym} 180 310 0 0 {name=p13 sig_type=std_logic lab=a1
}
C {lab_wire.sym} 180 330 0 0 {name=p14 sig_type=std_logic lab=a2
}
C {devices/code_shown.sym} -500 -80 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.control
set maxdata = 1000
op
print all
save all

tran 50p 1u
write divider_top_tb.raw 
set appendwrite

.endc
"}
C {devices/code_shown.sym} -530 210 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
