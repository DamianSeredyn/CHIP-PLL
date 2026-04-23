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
N 210 10 210 40 {lab=out_stage2}
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
N 380 10 380 40 {lab=out_stage3}
N 380 120 380 140 {lab=gnd}
N 380 120 400 120 {lab=gnd}
N 380 100 380 120 {lab=gnd}
N 400 70 400 120 {lab=gnd}
N 380 70 400 70 {lab=gnd}
N 380 -50 400 -50 {lab=vp}
N 400 -130 400 -50 {lab=vp}
N 380 -130 400 -130 {lab=vp}
N 380 -130 380 -80 {lab=vp}
N 340 10 340 70 {lab=out_stage2}
N 340 -50 340 10 {lab=out_stage2}
N 210 10 340 10 {lab=out_stage2}
N 210 -20 210 10 {lab=out_stage2}
N 550 10 550 40 {lab=out}
N 550 120 550 140 {lab=gnd}
N 550 120 570 120 {lab=gnd}
N 550 100 550 120 {lab=gnd}
N 570 70 570 120 {lab=gnd}
N 550 70 570 70 {lab=gnd}
N 550 -50 570 -50 {lab=vp}
N 570 -130 570 -50 {lab=vp}
N 550 -130 570 -130 {lab=vp}
N 550 -130 550 -80 {lab=vp}
N 510 10 510 70 {lab=out_stage3}
N 510 -50 510 10 {lab=out_stage3}
N 380 10 510 10 {lab=out_stage3}
N 380 -20 380 10 {lab=out_stage3}
N 550 10 640 10 {lab=out}
N 550 -20 550 10 {lab=out}
C {sg13g2_pr/sg13_lv_nmos.sym} 20 70 0 0 {name=M1
l=0.15u
w=0.3u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 20 -50 0 0 {name=M4
l=0.15u
w=0.3u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 190 70 0 0 {name=M2
l=0.15u
w=0.6u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 190 -50 0 0 {name=M3
l=0.15u
w=0.6u
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
C {iopin.sym} 640 10 0 0 {name=p6 lab=out
}
C {lab_wire.sym} 130 10 0 0 {name=p8 sig_type=std_logic lab=out_stage1}
C {sg13g2_pr/sg13_lv_nmos.sym} 360 70 0 0 {name=M5
l=0.15u
w=0.9u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 360 -50 0 0 {name=M6
l=0.15u
w=0.9u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_wire.sym} 390 -130 0 0 {name=p9 sig_type=std_logic lab=vp}
C {lab_wire.sym} 380 140 0 0 {name=p10 sig_type=std_logic lab=gnd}
C {lab_wire.sym} 310 10 0 0 {name=p11 sig_type=std_logic lab=out_stage2}
C {sg13g2_pr/sg13_lv_nmos.sym} 530 70 0 0 {name=M7
l=0.15u
w=1.2u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 530 -50 0 0 {name=M8
l=0.15u
w=1.2u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_wire.sym} 560 -130 0 0 {name=p13 sig_type=std_logic lab=vp}
C {lab_wire.sym} 550 140 0 0 {name=p14 sig_type=std_logic lab=gnd}
C {lab_wire.sym} 490 10 0 0 {name=p15 sig_type=std_logic lab=out_stage3}
