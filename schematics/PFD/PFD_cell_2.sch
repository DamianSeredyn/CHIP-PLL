v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -320 -340 -290 -340 {lab=gnd}
N -320 -310 -290 -310 {lab=vp}
N 750 310 760 310 {lab=UP}
N -310 -180 -230 -180 {lab=vp}
N -270 70 -230 70 {lab=vp}
N -590 -30 -540 -30 {lab=vp}
N 540 60 540 310 {lab=pre_up}
N 540 310 610 310 {lab=pre_up}
N 540 -170 590 -170 {lab=pre_down}
N 540 -170 540 -70 {lab=pre_down}
N 540 60 550 60 {lab=pre_up}
N -350 100 -230 100 {lab=flip_flop_reset}
N -350 -30 -350 100 {lab=flip_flop_reset}
N -20 10 -20 30 {lab=gnd}
N -20 -90 -20 -70 {lab=vp}
N 630 -130 630 -100 {lab=gnd}
N 630 -230 630 -210 {lab=vp}
N 650 230 650 270 {lab=vp}
N 650 350 650 380 {lab=gnd}
N 180 -70 240 -70 {lab=vp}
N 180 -50 240 -50 {lab=gnd}
N 540 -50 540 60 {lab=pre_up}
N -60 -120 20 -120 {lab=#net1}
N -770 -170 -770 -140 {lab=vp}
N -770 -80 -770 -60 {lab=gnd}
N -520 -90 -520 -60 {lab=vp}
N -520 0 -520 30 {lab=gnd}
N -720 -110 -670 -110 {lab=reset_n}
N -500 -90 -500 -60 {lab=reset_n}
N -500 0 -500 30 {lab=reset}
N -350 -30 -320 -30 {lab=flip_flop_reset}
N 30 -190 30 -170 {lab=pre_down}
N -60 -190 30 -190 {lab=pre_down}
N -150 -250 -150 -230 {lab=vp}
N -150 -80 -150 -60 {lab=gnd}
N -320 -150 -230 -150 {lab=flip_flop_reset}
N -320 -150 -320 -30 {lab=flip_flop_reset}
N -150 -10 -150 20 {lab=vp}
N -160 170 -160 220 {lab=gnd}
N 30 -170 540 -170 {lab=pre_down}
N -340 130 -230 130 {lab=cVco}
N 20 -30 50 -30 {lab=#net2}
N 120 -30 240 -30 {lab=post_nand}
N 100 -90 100 -60 {lab=vp}
N 100 -0 100 30 {lab=gnd}
N 780 -90 830 -90 {lab=gnd}
N 780 -100 780 -90 {lab=gnd}
N 830 -130 830 -90 {lab=gnd}
N 780 -130 830 -130 {lab=gnd}
N 700 -130 740 -130 {lab=reset}
N 780 -170 780 -160 {lab=DOWN}
N 780 -170 810 -170 {lab=DOWN}
N 690 -170 780 -170 {lab=DOWN}
N 780 -90 780 -80 {lab=gnd}
N 750 440 800 440 {lab=gnd}
N 750 430 750 440 {lab=gnd}
N 800 400 800 440 {lab=gnd}
N 750 400 800 400 {lab=gnd}
N 670 400 710 400 {lab=reset}
N 750 440 750 450 {lab=gnd}
N 750 310 750 370 {lab=UP}
N 710 310 750 310 {lab=UP}
N -390 -120 -230 -120 {lab=cRef}
N -460 -30 -350 -30 {lab=flip_flop_reset}
N -320 -30 -270 -30 {lab=flip_flop_reset}
N -250 -90 -250 -60 {lab=vp}
N -250 0 -250 30 {lab=gnd}
N -230 -90 -230 -60 {lab=reset}
N -230 0 -230 30 {lab=reset_n}
N -190 -30 -80 -30 {lab=#net3}
N -60 130 -20 130 {lab=#net4}
N -60 60 540 60 {lab=pre_up}
N -160 170 -150 170 {lab=gnd}
N -860 -110 -790 -110 {lab=reset}
N -1080 -100 -1030 -100 {lab=rst}
N -1080 -40 -1030 -40 {lab=cRef}
N -860 -40 -820 -40 {lab=#net5}
N -1080 -70 -1030 -70 {lab=gnd}
N -950 -180 -950 -150 {lab=vp}
N -950 0 -950 30 {lab=gnd}
C {iopin.sym} -290 -340 0 0 {name=p1 lab=gnd}
C {iopin.sym} -290 -310 0 0 {name=p2 lab=vp
}
C {ipin.sym} -390 -120 0 0 {name=p5 lab=cRef}
C {ipin.sym} -340 130 0 0 {name=p6 lab=cVco}
C {lab_wire.sym} -310 -180 0 0 {name=p7 sig_type=std_logic lab=vp}
C {lab_wire.sym} -270 70 0 0 {name=p8 sig_type=std_logic lab=vp}
C {lab_wire.sym} -590 -30 0 0 {name=p9 sig_type=std_logic lab=vp}
C {PFD_buffor.sym} -130 -30 0 1 {name=x4}
C {PFD_buffor.sym} 740 -170 0 0 {name=x5}
C {PFD_buffor.sym} 760 310 0 0 {name=x6}
C {lab_wire.sym} -150 -250 0 0 {name=p10 sig_type=std_logic lab=vp}
C {lab_wire.sym} -150 -10 0 0 {name=p11 sig_type=std_logic lab=vp}
C {lab_wire.sym} -160 220 0 0 {name=p12 sig_type=std_logic lab=gnd}
C {lab_wire.sym} -150 -60 0 0 {name=p13 sig_type=std_logic lab=gnd}
C {lab_wire.sym} -20 -90 0 0 {name=p14 sig_type=std_logic lab=vp}
C {lab_wire.sym} -20 30 0 0 {name=p15 sig_type=std_logic lab=gnd}
C {lab_wire.sym} 630 -100 0 0 {name=p16 sig_type=std_logic lab=gnd}
C {lab_wire.sym} 630 -230 0 0 {name=p17 sig_type=std_logic lab=vp}
C {lab_wire.sym} 650 230 0 0 {name=p18 sig_type=std_logic lab=vp}
C {lab_wire.sym} 650 380 0 0 {name=p19 sig_type=std_logic lab=gnd}
C {/foss/designs/CHIP-PLL/schematics/divider/schematics/NAND_2in.sym} 390 -50 0 1 {name=x7}
C {lab_wire.sym} 200 -70 0 0 {name=p20 sig_type=std_logic lab=vp}
C {lab_wire.sym} 200 -50 0 0 {name=p21 sig_type=std_logic lab=gnd}
C {noconn.sym} 20 -120 0 1 {name=l1}
C {noconn.sym} -20 130 0 1 {name=l2}
C {ipin.sym} -1080 -100 0 0 {name=p24 lab=rst}
C {/foss/designs/CHIP-PLL/schematics/divider/schematics/inverter_x4.sym} -770 -110 0 0 {name=x9}
C {lab_wire.sym} -520 -90 0 0 {name=p25 sig_type=std_logic lab=vp}
C {lab_wire.sym} -520 30 0 0 {name=p26 sig_type=std_logic lab=gnd}
C {lab_wire.sym} -770 -60 0 0 {name=p27 sig_type=std_logic lab=gnd}
C {lab_wire.sym} -770 -170 0 0 {name=p28 sig_type=std_logic lab=vp}
C {lab_wire.sym} -680 -110 0 0 {name=p29 sig_type=std_logic lab=reset_n}
C {lab_wire.sym} 390 -170 0 0 {name=p32 sig_type=std_logic lab=pre_down}
C {lab_wire.sym} 400 60 0 0 {name=p33 sig_type=std_logic lab=pre_up}
C {lab_wire.sym} 230 -30 0 0 {name=p34 sig_type=std_logic lab=post_nand}
C {lab_wire.sym} -360 -30 0 0 {name=p35 sig_type=std_logic lab=flip_flop_reset}
C {PFD_flip_flop.sym} -80 -180 0 0 {name=xflipFlopCref}
C {PFD_flip_flop.sym} -80 70 0 0 {name=xFlipFlopCvco}
C {PFD_passgate.sym} -500 -30 0 0 {name=x1}
C {/foss/designs/CHIP-PLL/schematics/divider/inverter_x4.sym} 100 -30 0 1 {name=x11}
C {lab_wire.sym} 100 30 0 0 {name=p47 sig_type=std_logic lab=gnd}
C {lab_wire.sym} 100 -90 0 0 {name=p48 sig_type=std_logic lab=vp}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 760 -130 0 0 {name=M4
l=0.13u
w=0.15u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_wire.sym} 780 -80 0 0 {name=p52 sig_type=std_logic lab=gnd}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 730 400 0 0 {name=M5
l=0.13u
w=0.15u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_wire.sym} 750 450 0 0 {name=p53 sig_type=std_logic lab=gnd}
C {opin.sym} 760 310 0 0 {name=p55 lab=UP
}
C {opin.sym} 810 -170 0 0 {name=p3 lab=DOWN
}
C {lab_wire.sym} -250 -90 0 0 {name=p4 sig_type=std_logic lab=vp}
C {lab_wire.sym} -250 30 0 0 {name=p22 sig_type=std_logic lab=gnd}
C {PFD_passgate.sym} -230 -30 0 0 {name=x8}
C {lab_wire.sym} -950 30 0 0 {name=p37 sig_type=std_logic lab=gnd}
C {lab_wire.sym} -950 -180 0 0 {name=p38 sig_type=std_logic lab=vp}
C {noconn.sym} -820 -40 0 1 {name=l3}
C {lab_wire.sym} -1080 -40 0 0 {name=p39 sig_type=std_logic lab=cRef}
C {lab_wire.sym} -810 -110 0 0 {name=p40 sig_type=std_logic lab=reset}
C {lab_wire.sym} -500 -90 0 1 {name=p30 sig_type=std_logic lab=reset_n}
C {lab_wire.sym} -500 30 0 1 {name=p31 sig_type=std_logic lab=reset}
C {lab_wire.sym} -230 -90 0 1 {name=p36 sig_type=std_logic lab=reset}
C {lab_wire.sym} -230 30 0 1 {name=p23 sig_type=std_logic lab=reset_n}
C {lab_wire.sym} -1080 -70 0 0 {name=p41 sig_type=std_logic lab=gnd}
C {lab_wire.sym} 720 -130 0 0 {name=p42 sig_type=std_logic lab=reset}
C {lab_wire.sym} 680 400 0 0 {name=p43 sig_type=std_logic lab=reset}
C {PFD_flip_flop.sym} -880 -100 0 0 {name=xResetFlipFlop}
