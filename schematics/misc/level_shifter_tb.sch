v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -120 40 -60 40 {lab=in}
N -0 -130 -0 -80 {lab=vp}
N -180 -130 -0 -130 {lab=vp}
N 50 -130 50 -80 {lab=vph}
N 50 -130 210 -130 {lab=vph}
N 210 -130 210 -70 {lab=vph}
N -180 -130 -180 -70 {lab=vp}
N -180 -10 -180 110 {lab=GND}
N 0 110 30 110 {lab=GND}
N 30 80 30 110 {lab=GND}
N 140 110 210 110 {lab=GND}
N 210 -10 210 110 {lab=GND}
N 110 -40 170 -40 {lab=out}
N 140 20 140 110 {lab=GND}
N 30 110 140 110 {lab=GND}
N 0 110 0 150 {lab=GND}
N -120 110 0 110 {lab=GND}
N -120 100 -120 110 {lab=GND}
N -180 110 -120 110 {lab=GND}
C {level_shifter.sym} 90 -20 0 0 {name=x1}
C {vsource.sym} -180 -40 0 0 {name=V1 value=\{Vp\} savecurrent=false}
C {vsource.sym} 210 -40 0 0 {name=V2 value=\{Vph\} savecurrent=false}
C {capa.sym} 140 -10 0 0 {name=C1
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {devices/vsource.sym} -120 70 0 0 {name=Vco value="dc 0 ac 0 pulse(1u \{Vp\} 0 10p 10p \{T/2\} \{T\}) "}
C {gnd.sym} 0 150 0 0 {name=l1 lab=GND
}
C {lab_wire.sym} -30 -130 0 0 {name=p2 sig_type=std_logic lab=vp}
C {lab_wire.sym} 70 -130 0 0 {name=p3 sig_type=std_logic lab=vph}
C {lab_wire.sym} -70 40 0 0 {name=p4 sig_type=std_logic lab=in}
C {lab_wire.sym} 170 -40 0 0 {name=p5 sig_type=std_logic lab=out}
C {devices/code_shown.sym} -610 -230 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt 
"}
C {devices/code_shown.sym} -580 -700 0 0 {name=NGSPICE only_toplevel=false
value="
.temp=25
.param T = 20n
.param Vp=1.2
.param Vph=3.3
.control
save all

tran 0.5n 100n

meas tran VOUT_MAX MAX v(out) from=75n to=100n

meas tran VOUT_AVG AVG v(out) from=75n to=100n


plot v(VOUT_MAX) v(VOUT_AVG)
write level_shifter.raw
.endc
"}
C {devices/code_shown.sym} -620 -170 0 0 {name=MODEL1 only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOShv.lib mos_tt
"}
