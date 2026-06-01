v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 370 -660 1170 -260 {flags=graph
y1=0.52
y2=1.82
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=2.6991355e-05
x2=0.00022699131
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
autoload=1
color="4 7"
node="cvco
cref"
legend=1}
B 2 -1050 220 -250 620 {flags=graph
y1=0
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=2.6991355e-05
x2=0.00022699131
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=up
color=7
dataset=-1
unitx=1
logx=0
logy=0
y2=1.3}
B 2 -170 220 630 620 {flags=graph
y1=1.04
y2=2.34
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=2.6991355e-05
x2=0.00022699131
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=down
color=12
dataset=-1
unitx=1
logx=0
logy=0
}
B 2 710 220 1510 620 {flags=graph
y1=2
y2=4
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=2.6991355e-05
x2=0.00022699131
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
color=4
node="v(up) - v(down)"}
N -40 -160 -40 -110 {lab=#net1}
N -400 -160 -400 -120 {lab=#net1}
N -320 -80 -320 -70 {lab=CRef}
N -320 -80 -190 -80 {lab=CRef}
N -260 -20 -190 -20 {lab=CVco}
N -400 -60 -400 60 {lab=GND}
N -320 -10 -320 60 {lab=GND}
N -260 40 -260 60 {lab=GND}
N -40 10 -40 60 {lab=GND}
N 310 -80 330 -80 {lab=UP}
N 200 -20 220 -20 {lab=DOWN}
N -400 60 -320 60 {lab=GND}
N -320 60 -260 60 {lab=GND}
N -260 60 -40 60 {lab=GND}
N -40 60 -40 80 {lab=GND}
N 310 60 340 60 {lab=GND}
N 200 50 200 60 {lab=GND}
N -40 60 200 60 {lab=GND}
N 200 -20 200 -10 {lab=DOWN}
N 110 -20 200 -20 {lab=DOWN}
N 310 -80 310 -10 {lab=UP}
N 110 -80 310 -80 {lab=UP}
N 310 50 310 60 {lab=GND}
N 200 60 310 60 {lab=GND}
N -400 -160 -40 -160 {lab=#net1}
C {devices/code_shown.sym} -580 -320 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} -860 -1000 0 0 {name=NGSPICE only_toplevel=false
value="
.temp=-25
.param T = 31.25u
.param dly=1u
.param Vp=1.08
.control
save all
tran 25n 200u

meas tran pw_up avg v(UP) from=100u to=200u
meas tran pw_down avg v(DOWN) from=100u to=200u
plot v(pw_up) v(pw_down)
write PFD_tb.raw
.endc
"}
C {gnd.sym} -40 80 0 0 {name=l1 lab=GND
}
C {lab_wire.sym} -230 -80 0 0 {name=p1 sig_type=std_logic lab=CRef}
C {lab_wire.sym} -220 -20 0 0 {name=p2 sig_type=std_logic lab=CVco}
C {lab_wire.sym} 200 -80 0 0 {name=p3 sig_type=std_logic lab=UP
}
C {lab_wire.sym} 200 -20 0 0 {name=p4 sig_type=std_logic lab=DOWN

}
C {devices/vsource.sym} -320 -40 0 0 {name=Vref value="dc 0 ac 0 pulse(0 \{Vp\} \{T/2\} 10n 10n \{T/2\} \{T\}) "}
C {devices/vsource.sym} -260 10 0 0 {name=Vco value="dc 0 ac 0 pulse(1u \{Vp\} \{dly\} 10n 10n \{T/2\} \{T\}) "}
C {launcher.sym} 580 -210 0 0 {name=h5
descr="load waves"
tclcommand="xschem raw_read $netlist_dir/PFD_tb.raw tran"
}
C {devices/vsource.sym} -400 -90 0 0 {name=Vp value="dc \{Vp\}"}
C {capa.sym} 310 20 0 0 {name=C1
m=1
value=5p
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 200 20 0 0 {name=C2
m=1
value=5p
footprint=1206
device="ceramic capacitor"}
C {PFD_cell.sym} -40 -50 0 0 {name=x1}
