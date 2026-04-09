v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -100 -80 -100 -60 {lab=1}
N -20 -80 70 -80 {lab=1}
N 70 -80 70 -60 {lab=1}
N -100 -0 -100 40 {lab=2}
N -20 40 70 40 {lab=2}
N 70 -0 70 40 {lab=2}
N -20 -190 -20 -80 {lab=1}
N -100 -80 -20 -80 {lab=1}
N -20 40 -20 80 {lab=2}
N -100 40 -20 40 {lab=2}
N -20 -30 70 -30 {lab=gnd}
N -20 -30 -20 -10 {lab=gnd}
N -100 -30 -20 -30 {lab=gnd
}
N -20 170 -20 190 {lab=gnd}
N -20 170 0 170 {lab=gnd}
N -20 140 -20 170 {lab=gnd}
N 0 110 -0 170 {lab=gnd}
N -20 110 -0 110 {lab=gnd}
N -20 -190 20 -190 {lab=1}
N -60 -190 -20 -190 {lab=1}
N -90 -260 -90 -230 {lab=cRef}
N -90 -260 50 -260 {lab=cRef}
N 50 -260 50 -230 {lab=cRef}
N -190 -260 -90 -260 {lab=cRef}
N -190 -260 -190 110 {lab=cRef}
N -190 110 -60 110 {lab=cRef}
N -140 -190 -120 -190 {lab=vp}
N -140 -190 -140 -140 {lab=vp}
N -160 -190 -140 -190 {lab=vp}
N -90 -190 -90 -140 {lab=vp}
N -140 -140 -90 -140 {lab=vp}
N 50 -190 50 -140 {lab=gnd}
N -280 -260 -190 -260 {lab=cRef}
N -160 -220 -160 -190 {lab=vp}
N 350 -190 390 -190 {lab=UP}
N -110 400 -110 420 {lab=3}
N -30 400 60 400 {lab=3}
N 60 400 60 420 {lab=3}
N -110 480 -110 520 {lab=4}
N -30 520 60 520 {lab=4}
N 60 480 60 520 {lab=4}
N -30 290 -30 400 {lab=3}
N -110 400 -30 400 {lab=3}
N -30 520 -30 560 {lab=4}
N -110 520 -30 520 {lab=4}
N -30 450 60 450 {lab=gnd}
N -30 450 -30 470 {lab=gnd}
N -110 450 -30 450 {lab=gnd
}
N -30 650 -30 670 {lab=gnd}
N -30 650 -10 650 {lab=gnd}
N -30 620 -30 650 {lab=gnd}
N -10 590 -10 650 {lab=gnd}
N -30 590 -10 590 {lab=gnd}
N -30 290 10 290 {lab=3}
N -70 290 -30 290 {lab=3}
N -100 220 -100 250 {lab=cVco}
N 40 220 40 250 {lab=cVco}
N -150 290 -130 290 {lab=vp}
N -150 290 -150 340 {lab=vp}
N -170 290 -150 290 {lab=vp}
N -100 290 -100 340 {lab=vp}
N -150 340 -100 340 {lab=vp}
N 40 290 40 340 {lab=gnd}
N -170 260 -170 290 {lab=vp}
N -100 220 40 220 {lab=cVco}
N -140 -30 -140 220 {lab=cVco}
N -140 220 -100 220 {lab=cVco}
N -250 220 -250 590 {lab=cVco}
N 110 -30 350 -30 {lab=DOWN}
N 350 -30 350 290 {lab=DOWN}
N 100 450 140 450 {lab=UP}
N 140 -120 140 450 {lab=UP}
N 140 -120 350 -120 {lab=UP}
N 350 -190 350 -120 {lab=UP}
N -190 110 -190 450 {lab=cRef}
N -190 450 -150 450 {lab=cRef}
N -250 590 -70 590 {lab=cVco}
N -250 220 -140 220 {lab=cVco}
N -270 -360 -240 -360 {lab=gnd}
N -270 -330 -240 -330 {lab=vp}
N -270 590 -250 590 {lab=cVco}
N 80 -190 140 -190 {lab=pre_up}
N 180 -250 180 -230 {lab=vp}
N 180 -150 180 -130 {lab=gnd}
N 230 230 230 250 {lab=vp}
N 230 330 230 350 {lab=gnd}
N 290 290 350 290 {lab=DOWN}
N 350 290 400 290 {lab=DOWN}
N 70 290 190 290 {lab=pre_down}
N 240 -190 350 -190 {lab=UP}
C {sg13g2_pr/sg13_lv_nmos.sym} -120 -30 0 0 {name=M1
l=0.13u
w=0.5u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 90 -30 0 1 {name=M2
l=0.13u
w=0.5u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -40 110 0 0 {name=M3
l=0.13u
w=0.25u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {iopin.sym} -240 -360 0 0 {name=p1 lab=gnd}
C {iopin.sym} -240 -330 0 0 {name=p2 lab=vp
}
C {sg13g2_pr/sg13_lv_pmos.sym} -90 -210 3 1 {name=M4
l=0.13u
w=0.75u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -130 450 0 0 {name=M6
l=0.13u
w=0.5u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 80 450 0 1 {name=M7
l=0.13u
w=0.5u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} -50 590 0 0 {name=M8
l=0.13u
w=0.25u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -100 270 3 1 {name=M9
l=0.13u
w=0.75u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {iopin.sym} 400 290 0 0 {name=p3 lab=DOWN}
C {iopin.sym} 390 -190 0 0 {name=p4 lab=UP
}
C {ipin.sym} -280 -260 0 0 {name=p5 lab=cRef}
C {ipin.sym} -270 590 0 0 {name=p6 lab=cVco}
C {lab_wire.sym} -160 -220 0 0 {name=p7 sig_type=std_logic lab=vp}
C {lab_wire.sym} -170 260 0 0 {name=p8 sig_type=std_logic lab=vp}
C {lab_wire.sym} -20 190 0 0 {name=p9 sig_type=std_logic lab=gnd}
C {lab_wire.sym} -30 670 0 0 {name=p10 sig_type=std_logic lab=gnd}
C {lab_wire.sym} -30 470 0 0 {name=p11 sig_type=std_logic lab=gnd}
C {lab_wire.sym} -20 -10 0 0 {name=p12 sig_type=std_logic lab=gnd}
C {lab_wire.sym} -50 -80 0 0 {name=p13 sig_type=std_logic lab=1
}
C {lab_wire.sym} 10 40 0 0 {name=p14 sig_type=std_logic lab=2
}
C {lab_wire.sym} -50 400 0 0 {name=p15 sig_type=std_logic lab=3}
C {lab_wire.sym} -10 520 0 0 {name=p16 sig_type=std_logic lab=4}
C {PFD_buffor.sym} 290 -190 0 0 {name=x1}
C {lab_wire.sym} 180 -250 0 0 {name=p17 sig_type=std_logic lab=vp}
C {lab_wire.sym} 180 -130 0 0 {name=p18 sig_type=std_logic lab=gnd}
C {PFD_buffor.sym} 340 290 0 0 {name=x2}
C {lab_wire.sym} 230 230 0 0 {name=p19 sig_type=std_logic lab=vp}
C {lab_wire.sym} 230 350 0 0 {name=p20 sig_type=std_logic lab=gnd}
C {lab_wire.sym} 140 -190 0 0 {name=p21 sig_type=std_logic lab=pre_up
}
C {lab_wire.sym} 170 290 0 0 {name=p22 sig_type=std_logic lab=pre_down
}
C {sg13g2_pr/sg13_lv_nmos.sym} 50 -210 3 1 {name=M5
l=0.13u
w=0.75u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 40 270 3 1 {name=M10
l=0.13u
w=0.75u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_wire.sym} 40 340 0 0 {name=p23 sig_type=std_logic lab=gnd}
C {lab_wire.sym} 50 -140 0 0 {name=p24 sig_type=std_logic lab=gnd}
