v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -40 -160 -40 -110 {lab=#net1}
N -400 -160 -40 -160 {lab=#net1}
N -400 -160 -400 -120 {lab=#net1}
N -320 -80 -320 -70 {lab=CRef}
N -320 -80 -190 -80 {lab=CRef}
N -260 -20 -190 -20 {lab=CVco}
N -400 -60 -400 60 {lab=0}
N -320 -10 -320 60 {lab=0}
N -260 40 -260 60 {lab=0}
N -40 10 -40 60 {lab=0}
N 110 -80 220 -80 {lab=UP}
N 110 -20 220 -20 {lab=DOWN}
N -400 60 -320 60 {lab=0}
N -320 60 -260 60 {lab=0}
N -260 60 -40 60 {lab=0}
N -40 60 -40 80 {lab=0}
C {PFD_cell.sym} -40 -50 0 0 {name=x1}
C {devices/code_shown.sym} -580 -320 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
"}
C {devices/code_shown.sym} -110 -470 0 0 {name=NGSPICE only_toplevel=false
value="
.param temp=27
.control

op
print all
save all

tran 50p 20n
write PFD_tb.raw
set appendwrite

.endc
"}
C {vsource.sym} -400 -90 0 0 {name=V1 value=1.2 savecurrent=false}
C {vsource.sym} -320 -40 0 0 {name=V2 value=1.2 savecurrent=false}
C {vsource.sym} -260 10 0 0 {name=V3 value=0 savecurrent=false}
C {gnd.sym} -40 80 0 0 {name=l1 lab=0
}
C {connector.sym} 220 -20 0 1 {name=c1 footprint=connector(1,1)}
C {connector.sym} 220 -80 0 1 {name=c2 footprint=connector(1,1)}
C {lab_wire.sym} -230 -80 0 0 {name=p1 sig_type=std_logic lab=CRef}
C {lab_wire.sym} -220 -20 0 0 {name=p2 sig_type=std_logic lab=CVco}
C {lab_wire.sym} 200 -80 0 0 {name=p3 sig_type=std_logic lab=UP
}
C {lab_wire.sym} 200 -20 0 0 {name=p4 sig_type=std_logic lab=DOWN

}
