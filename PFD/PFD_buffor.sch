v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -40 70 -0 70 {lab=in}
N -40 10 -40 70 {lab=in}
N -40 -50 -0 -50 {lab=in}
N -90 10 -40 10 {lab=in}
N -40 -50 -40 10 {lab=in}
N 40 10 40 40 {lab=out_stage1}
N 40 -20 40 10 {lab=out_stage1}
N 40 120 40 140 {lab=gnd}
N 40 120 60 120 {lab=gnd}
N 40 100 40 120 {lab=gnd}
N 60 70 60 120 {lab=gnd}
N 40 70 60 70 {lab=gnd}
N 40 -50 60 -50 {lab=vp}
N 60 -130 60 -50 {lab=vp}
N 40 -130 60 -130 {lab=vp}
N 40 -130 40 -80 {lab=vp}
N 210 10 210 40 {lab=out}
N 210 10 290 10 {lab=out}
N 210 -20 210 10 {lab=out}
N 210 120 210 140 {lab=gnd}
N 210 120 230 120 {lab=gnd}
N 210 100 210 120 {lab=gnd}
N 230 70 230 120 {lab=gnd}
N 210 70 230 70 {lab=gnd}
N 210 -50 230 -50 {lab=vp}
N 230 -130 230 -50 {lab=vp}
N 210 -130 230 -130 {lab=vp}
N 210 -130 210 -80 {lab=vp}
N 170 10 170 70 {lab=out_stage1}
N 170 -50 170 10 {lab=out_stage1}
N -140 -250 -110 -250 {lab=gnd}
N -140 -220 -110 -220 {lab=vp}
N 40 10 170 10 {lab=out_stage1}
C {sg13g2_pr/sg13_lv_nmos.sym} 20 70 0 0 {name=M1
l=0.15u
w=0.6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 20 -50 0 0 {name=M4
l=0.15u
w=0.6u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 190 70 0 0 {name=M2
l=0.15u
w=1u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 190 -50 0 0 {name=M3
l=0.15u
w=1u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {iopin.sym} -110 -250 0 0 {name=p1 lab=gnd}
C {iopin.sym} -110 -220 0 0 {name=p2 lab=vp
}
C {ipin.sym} -90 10 0 0 {name=p5 lab=in
}
C {lab_wire.sym} 50 -130 0 0 {name=p7 sig_type=std_logic lab=vp}
C {lab_wire.sym} 220 -130 0 0 {name=p3 sig_type=std_logic lab=vp}
C {lab_wire.sym} 40 140 0 0 {name=p12 sig_type=std_logic lab=gnd}
C {lab_wire.sym} 210 140 0 0 {name=p4 sig_type=std_logic lab=gnd}
C {iopin.sym} 290 10 0 0 {name=p6 lab=out
}
C {lab_wire.sym} 130 10 0 0 {name=p8 sig_type=std_logic lab=out_stage1}
