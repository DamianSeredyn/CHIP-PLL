v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -100 -30 -100 60 {lab=in}
N -60 -30 -60 30 {lab=#net1}
N -140 -30 -100 -30 {lab=in}
N -100 -120 -100 -30 {lab=in}
N -60 -30 10 -30 {lab=#net1}
N -60 -90 -60 -30 {lab=#net1}
N 10 -30 10 60 {lab=#net1}
N 50 -30 50 30 {lab=#net2}
N 10 -120 10 -30 {lab=#net1}
N 50 -30 120 -30 {lab=#net2}
N 50 -90 50 -30 {lab=#net2}
N 120 -30 120 60 {lab=#net2}
N 160 -30 160 30 {lab=#net3}
N 120 -120 120 -30 {lab=#net2}
N 160 -30 230 -30 {lab=#net3}
N 160 -90 160 -30 {lab=#net3}
N 230 -30 230 60 {lab=#net3}
N 270 -30 270 30 {lab=out}
N 230 -120 230 -30 {lab=#net3}
N 270 -30 340 -30 {lab=out}
N 270 -90 270 -30 {lab=out}
N -250 -140 -210 -140 {lab=vp}
N -250 -100 -210 -100 {lab=gnd}
N 50 -190 50 -120 {lab=vp}
N 160 -190 160 -120 {lab=vp}
N 270 -190 270 -120 {lab=vp}
N -60 60 -60 120 {lab=gnd}
N 50 60 50 120 {lab=gnd}
N 160 60 160 120 {lab=gnd}
N 270 60 270 120 {lab=gnd}
N 160 120 270 120 {lab=gnd}
N -60 120 50 120 {lab=gnd}
N 50 120 160 120 {lab=gnd}
N 160 -190 270 -190 {lab=vp}
N -60 -190 50 -190 {lab=vp}
N 50 -190 160 -190 {lab=vp}
N -60 -190 -60 -120 {lab=vp}
C {sg13g2_pr/sg13_lv_pmos.sym} -80 -120 0 0 {name=M24
l=0.16*2u
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -80 60 0 0 {name=M25
l=0.16*2u
w=0.8u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {ipin.sym} -140 -30 0 0 {name=p23 lab=in}
C {opin.sym} 340 -30 0 0 {name=p24 lab=out}
C {sg13g2_pr/sg13_lv_pmos.sym} 30 -120 0 0 {name=M1
l=0.16*2u
w=1.5*1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 30 60 0 0 {name=M2
l=0.16*2u
w=1.5*1u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 140 -120 0 0 {name=M3
l=0.16*2u
w=2*1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 140 60 0 0 {name=M4
l=0.16*2u
w=2*1u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 250 -120 0 0 {name=M5
l=0.16*2u
w=2*1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 250 60 0 0 {name=M6
l=0.16*2u
w=2*1u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {iopin.sym} -250 -140 0 1 {name=p3 lab=vp
}
C {iopin.sym} -250 -100 0 1 {name=p32 lab=gnd}
C {lab_wire.sym} -60 -190 0 0 {name=p9 sig_type=std_logic lab=vp
}
C {lab_wire.sym} -60 120 0 0 {name=p16 sig_type=std_logic lab=gnd
}
