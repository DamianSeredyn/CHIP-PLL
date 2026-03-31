v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -170 -70 -170 -30 {lab=#net1}
N -170 -70 -0 -70 {lab=#net1}
N -0 -70 0 -30 {lab=#net1}
N 0 30 -0 120 {lab=0}
N -170 120 0 120 {lab=0}
N -170 30 -170 120 {lab=0}
N -90 -0 -90 20 {lab=#net2}
N -90 -0 -20 0 {lab=#net2}
N -90 80 -0 120 {lab=0}
N 50 -0 110 0 {lab=#net3}
N 110 0 110 10 {lab=#net3}
N 0 120 110 70 {lab=0}
C {devices/code_shown.sym} -380 -160 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} 90 -310 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.control

op
print all
save all

tran 50p 20n
write inverter_tb.raw
set appendwrite

.endc
"}
C {/foss/designs/CHIP-PLL/divider/inverter.sym} 0 0 0 0 {name=x1}
C {vsource.sym} -170 0 0 0 {name=V1 value=1.2 savecurrent=false}
C {vsource.sym} -90 50 0 0 {name=V2 value=1.2 savecurrent=false}
C {capa.sym} 110 40 0 0 {name=C1
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 0 120 0 0 {name=l1 lab=0
}
