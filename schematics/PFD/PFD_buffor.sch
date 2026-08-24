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
N 40 100 40 190 {lab=gnd}
N 40 -50 100 -50 {lab=well}
N 210 10 210 40 {lab=out}
N 210 100 210 190 {lab=gnd}
N 210 70 280 70 {lab=sub}
N 210 -50 230 -50 {lab=well}
N 170 10 170 70 {lab=out_stage1}
N 170 -50 170 10 {lab=out_stage1}
N -140 -250 -110 -250 {lab=gnd}
N -140 -220 -110 -220 {lab=vp}
N 40 10 170 10 {lab=out_stage1}
N 210 10 430 10 {lab=out}
N 210 -20 210 10 {lab=out}
N 40 70 130 70 {lab=sub}
N 130 190 130 230 {lab=gnd}
N 130 190 210 190 {lab=gnd}
N 130 180 130 190 {lab=gnd}
N 40 190 130 190 {lab=gnd}
N 210 -160 210 -80 {lab=vp}
N 40 -160 210 -160 {lab=vp}
N 40 -160 40 -80 {lab=vp}
N 100 -100 100 -50 {lab=well}
N 130 70 130 120 {lab=sub}
C {sg13g2_pr/sg13_lv_nmos.sym} 20 70 0 0 {name=M1
l=0.5u
w=0.4u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 20 -50 0 0 {name=M4
l=0.5u
w=0.4u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 190 70 0 0 {name=M2
l=0.5u
w=0.4u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 190 -50 0 0 {name=M3
l=0.5u
w=0.4u
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
C {lab_wire.sym} 130 -160 0 0 {name=p7 sig_type=std_logic lab=vp}
C {lab_wire.sym} 130 230 0 0 {name=p12 sig_type=std_logic lab=gnd}
C {iopin.sym} 430 10 0 0 {name=p6 lab=out
}
C {lab_wire.sym} 130 10 0 0 {name=p8 sig_type=std_logic lab=out_stage1}
C {sg13cmos5l_pr/ptap1.sym} 130 150 2 0 {name=R1
model=ptap1
spiceprefix=X
w=0.78e-6
l=0.78e-6
}
C {sg13cmos5l_pr/ntap1.sym} 100 -130 0 0 {name=R2
model=ntap1
spiceprefix=X
w=0.78e-6
l=0.78e-6
}
C {lab_wire.sym} 130 100 0 0 {name=p3 sig_type=std_logic lab=sub
}
C {lab_wire.sym} 280 70 0 0 {name=p9 sig_type=std_logic lab=sub
}
C {lab_wire.sym} 100 -50 0 0 {name=p10 sig_type=std_logic lab=well}
C {lab_wire.sym} 230 -50 0 1 {name=p13 sig_type=std_logic lab=well}
