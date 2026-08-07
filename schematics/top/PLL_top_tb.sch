v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 140 10 260 10 {lab=out}
N -50 -100 -50 -60 {lab=GND}
N -550 350 -550 370 {lab=GND}
N -440 350 -440 370 {lab=GND}
N -50 -100 -30 -100 {lab=GND}
N -550 250 -550 290 {lab=Vp}
N -330 350 -330 370 {lab=GND}
N -330 250 -330 290 {lab=clk_ref}
N -440 250 -440 290 {lab=Vph}
N -120 10 -100 10 {lab=clk_ref}
N 60 -90 60 -60 {lab=Vph}
N 80 -90 80 -60 {lab=Vp}
N 210 70 210 90 {lab=GND}
N 20 330 20 350 {lab=GND}
N 90 330 90 350 {lab=GND}
N 170 330 170 350 {lab=GND}
N 20 240 20 270 {lab=d0}
N 90 240 90 270 {lab=d1}
N 170 240 170 270 {lab=d2}
N 240 330 240 350 {lab=GND}
N 300 330 300 350 {lab=GND}
N 390 330 390 350 {lab=GND}
N 240 240 240 270 {lab=d3}
N 300 240 300 270 {lab=d4}
N 390 240 390 270 {lab=d5}
N 90 410 90 430 {lab=a1}
N 90 490 90 510 {lab=GND}
N 20 410 20 430 {lab=a0}
N 20 490 20 510 {lab=GND}
N 160 410 160 430 {lab=a2}
N 160 490 160 510 {lab=GND}
N -70 80 -70 110 {lab=a2}
N -50 80 -50 110 {lab=a1}
N -30 80 -30 110 {lab=a0}
N 0 80 0 110 {lab=d5}
N 20 80 20 110 {lab=d4}
N 40 80 40 110 {lab=d3}
N 60 80 60 110 {lab=d2}
N 80 80 80 110 {lab=d1}
N 100 80 100 110 {lab=d0}
C {CHIP-PLL/schematics/top/PLL_top.sym} 50 -70 0 0 {name=x1}
C {devices/code_shown.sym} -220 -330 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerRES.lib res_typ

"}
C {devices/code_shown.sym} -760 -780 0 0 {name=NGSPICE only_toplevel=false
value="
.temp=25
.param T = 31.25u

.param Vp=1.2
.param Vph=3.3
.control
save all
tran 1p 10m

meas tran t1 WHEN v(out)=1.65 RISE=1 FROM=9m
meas tran t2 WHEN v(out)=1.65 RISE=2 FROM=9m
meas tran period PARAM='t2-t1'
meas tran freq PARAM='1/period'

write PLL_top_tb.raw
.endc
"}
C {devices/vsource.sym} -330 320 0 0 {name=Vref value="dc 0 ac 0 pulse(0 \{Vph\} \{T/2\} 10n 10n \{T/2\} \{T\}) "}
C {devices/vsource.sym} -550 320 0 0 {name=Vp value="dc \{Vp\}"}
C {gnd.sym} -550 370 0 0 {name=l1 lab=GND
}
C {devices/vsource.sym} -440 320 0 0 {name=Vph value="dc \{Vph\}"}
C {gnd.sym} -440 370 0 0 {name=l2 lab=GND
}
C {gnd.sym} -30 -100 0 0 {name=l3 lab=GND
}
C {gnd.sym} -330 370 0 0 {name=l4 lab=GND
}
C {lab_wire.sym} -550 250 0 0 {name=p6 sig_type=std_logic lab=Vp}
C {lab_wire.sym} -440 250 0 0 {name=p1 sig_type=std_logic lab=Vph}
C {lab_wire.sym} -330 250 0 0 {name=p2 sig_type=std_logic lab=clk_ref}
C {lab_wire.sym} -120 10 0 0 {name=p3 sig_type=std_logic lab=clk_ref}
C {lab_wire.sym} 80 -90 0 1 {name=p4 sig_type=std_logic lab=Vp}
C {lab_wire.sym} 60 -90 0 0 {name=p5 sig_type=std_logic lab=Vph}
C {lab_wire.sym} 260 10 0 0 {name=p7 sig_type=std_logic lab=out}
C {capa.sym} 210 40 0 0 {name=C1
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 210 90 0 0 {name=l5 lab=GND
}
C {lab_wire.sym} 240 240 1 0 {name=p20 sig_type=std_logic lab=d3
}
C {lab_wire.sym} 20 240 1 0 {name=p21 sig_type=std_logic lab=d0
}
C {lab_wire.sym} 170 240 1 0 {name=p22 sig_type=std_logic lab=d2
}
C {lab_wire.sym} 390 240 1 0 {name=p49 sig_type=std_logic lab=d5
}
C {lab_wire.sym} 90 240 1 0 {name=p51 sig_type=std_logic lab=d1
}
C {lab_wire.sym} 300 240 1 0 {name=p50 sig_type=std_logic lab=d4
}
C {vsource.sym} 300 300 0 0 {name=V8 value=0 savecurrent=false}
C {vsource.sym} 390 300 0 0 {name=V9 value=0 savecurrent=false}
C {vsource.sym} 20 300 0 0 {name=V11 value=1.2 savecurrent=false}
C {vsource.sym} 90 300 0 0 {name=V10 value=1.2  savecurrent=false}
C {vsource.sym} 170 300 0 0 {name=V12 value=0 savecurrent=false}
C {vsource.sym} 240 300 0 0 {name=V7 value=0 savecurrent=false}
C {vsource.sym} 90 460 0 0 {name=V5 value=1.2 savecurrent=false}
C {lab_wire.sym} 90 410 0 0 {name=p24 sig_type=std_logic lab=a1
}
C {vsource.sym} 20 460 0 0 {name=V6 value=1.2 savecurrent=false}
C {lab_wire.sym} 20 410 0 0 {name=p25 sig_type=std_logic lab=a0
}
C {vsource.sym} 160 460 0 0 {name=V13 value=1.2 savecurrent=false}
C {lab_wire.sym} 160 410 0 0 {name=p27 sig_type=std_logic lab=a2
}
C {gnd.sym} 20 350 0 0 {name=l6 lab=GND
}
C {gnd.sym} 90 350 0 0 {name=l7 lab=GND
}
C {gnd.sym} 170 350 0 0 {name=l8 lab=GND
}
C {gnd.sym} 240 350 0 0 {name=l9 lab=GND
}
C {gnd.sym} 300 350 0 0 {name=l10 lab=GND
}
C {gnd.sym} 160 510 0 0 {name=l11 lab=GND
}
C {gnd.sym} 90 510 0 0 {name=l12 lab=GND
}
C {gnd.sym} 20 510 0 0 {name=l13 lab=GND
}
C {gnd.sym} 390 350 0 0 {name=l14 lab=GND
}
C {lab_wire.sym} 100 110 1 0 {name=p8 sig_type=std_logic lab=d0
}
C {lab_wire.sym} 80 110 1 0 {name=p9 sig_type=std_logic lab=d1
}
C {lab_wire.sym} 60 110 1 0 {name=p10 sig_type=std_logic lab=d2
}
C {lab_wire.sym} 40 110 1 0 {name=p11 sig_type=std_logic lab=d3
}
C {lab_wire.sym} 20 110 1 0 {name=p12 sig_type=std_logic lab=d4
}
C {lab_wire.sym} 0 110 1 0 {name=p13 sig_type=std_logic lab=d5
}
C {lab_wire.sym} -30 110 0 0 {name=p14 sig_type=std_logic lab=a0
}
C {lab_wire.sym} -50 110 0 0 {name=p15 sig_type=std_logic lab=a1
}
C {lab_wire.sym} -70 110 0 0 {name=p16 sig_type=std_logic lab=a2
}
