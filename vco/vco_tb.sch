v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -160 -10 -80 -10 {lab=in}
N -160 50 -160 90 {lab=0}
N -250 -100 -250 -10 {lab=vp}
N -250 50 -250 90 {lab=0}
N -250 90 -160 90 {lab=0}
N 220 -50 220 -10 {lab=vp}
N 220 10 270 10 {lab=out}
C {/foss/designs/CHIP-PLL/vco/vco_cell.sym} 70 10 0 0 {}
C {vsource.sym} -160 20 0 0 {name=V1 value=1 savecurrent=false}
C {gnd.sym} 220 30 0 0 {name=l1 lab=0
}
C {vsource.sym} -250 20 0 0 {name=V2 value=0.9 savecurrent=false}
C {connector.sym} 270 10 0 1 {name=c1 footprint=connector(1,1)}
C {devices/code_shown.sym} 80 -360 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.control

tran 20p 20n
write vco_tb.raw
set appendwrite

.endc
"}
C {devices/code_shown.sym} -350 -350 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {lab_wire.sym} -110 -10 0 0 {name=p9 sig_type=std_logic lab=in
}
C {lab_wire.sym} -250 -100 0 0 {name=p1 sig_type=std_logic lab=vp
}
C {lab_wire.sym} 250 10 0 0 {name=p3 sig_type=std_logic lab=out
}
C {lab_wire.sym} 220 -50 0 0 {name=p2 sig_type=std_logic lab=vp
}
C {gnd.sym} -210 90 0 0 {name=l2 lab=0
}
