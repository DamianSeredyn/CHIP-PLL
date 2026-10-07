v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -100 -30 -100 60 {lab=in}
N -60 -30 -60 30 {lab=1_stg}
N -140 -30 -100 -30 {lab=in}
N -100 -120 -100 -30 {lab=in}
N -60 -30 10 -30 {lab=1_stg}
N -60 -90 -60 -30 {lab=1_stg}
N 10 -30 10 60 {lab=1_stg}
N 50 -30 50 30 {lab=2_stg}
N 10 -120 10 -30 {lab=1_stg}
N 50 -30 120 -30 {lab=2_stg}
N 50 -90 50 -30 {lab=2_stg}
N 120 -30 120 60 {lab=2_stg}
N 160 -30 160 30 {lab=3_stg}
N 120 -120 120 -30 {lab=2_stg}
N 160 -30 250 -30 {lab=3_stg}
N 160 -90 160 -30 {lab=3_stg}
N -250 -140 -210 -140 {lab=vp}
N -250 -100 -210 -100 {lab=gnd}
N 50 -190 50 -120 {lab=vp}
N 160 -190 160 -120 {lab=vp}
N -60 60 -60 120 {lab=gnd}
N 50 60 50 120 {lab=gnd}
N 160 60 160 120 {lab=gnd}
N 160 120 290 120 {lab=gnd}
N -60 120 50 120 {lab=gnd}
N 50 120 160 120 {lab=gnd}
N -60 -190 50 -190 {lab=vp}
N 50 -190 160 -190 {lab=vp}
N -60 -190 -60 -120 {lab=vp}
N 250 -120 250 -30 {lab=3_stg}
N 250 -30 250 50 {lab=3_stg}
N 290 50 290 120 {lab=gnd}
N 290 -190 290 -120 {lab=vp}
N 160 -190 290 -190 {lab=vp}
N 290 -30 290 20 {lab=out}
N 290 -30 340 -30 {lab=out}
N 290 -90 290 -30 {lab=out}
C {sg13g2_pr/sg13_lv_pmos.sym} -80 -120 0 0 {name=M24
l=0.40u
w=5u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -80 60 0 0 {name=M25
l=0.45u
w=5u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {ipin.sym} -140 -30 0 0 {name=p23 lab=in}
C {opin.sym} 340 -30 0 0 {name=p24 lab=out}
C {sg13g2_pr/sg13_lv_pmos.sym} 30 -120 0 0 {name=M1
l=0.40u
w=10u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 30 60 0 0 {name=M2
l=0.45u
w=10u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} 140 -120 0 0 {name=M3
l=0.40u
w=10u
ng=1
m=2
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 140 60 0 0 {name=M4
l=0.45u
w=10u
ng=1
m=2
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
C {lab_wire.sym} -10 -30 0 0 {name=p1 sig_type=std_logic lab=1_stg
}
C {lab_wire.sym} 100 -30 0 0 {name=p2 sig_type=std_logic lab=2_stg
}
C {sg13g2_pr/sg13_lv_pmos.sym} 270 -120 0 0 {name=M5
l=0.40u
w=10u
ng=1
m=2
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 270 50 0 0 {name=M6
l=0.45u
w=10u
ng=1
m=2
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_wire.sym} 220 -30 0 0 {name=p4 sig_type=std_logic lab=3_stg
}
