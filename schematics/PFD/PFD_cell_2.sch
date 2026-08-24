v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -320 -340 -290 -340 {lab=gnd}
N -320 -310 -290 -310 {lab=vp}
N 770 310 780 310 {lab=DOWN}
N -310 -180 -230 -180 {lab=vp}
N -270 70 -230 70 {lab=vp}
N -590 -30 -540 -30 {lab=vp}
N 540 60 540 310 {lab=pre_down}
N 540 -170 540 -70 {lab=pre_up}
N 540 60 550 60 {lab=pre_down}
N -350 100 -230 100 {lab=flip_flop_reset}
N -350 -30 -350 100 {lab=flip_flop_reset}
N -20 10 -20 30 {lab=gnd}
N -20 -90 -20 -70 {lab=vp}
N 570 -140 570 -110 {lab=gnd}
N 180 -70 240 -70 {lab=vp}
N 180 -50 240 -50 {lab=gnd}
N 540 -50 540 60 {lab=pre_down}
N -60 -120 20 -120 {lab=#net1}
N -770 -170 -770 -140 {lab=vp}
N -770 -80 -770 -60 {lab=gnd}
N -520 -90 -520 -60 {lab=vp}
N -520 0 -520 30 {lab=gnd}
N -720 -110 -670 -110 {lab=reset_n}
N -500 -90 -500 -60 {lab=reset_n}
N -500 0 -500 30 {lab=rst}
N -350 -30 -320 -30 {lab=flip_flop_reset}
N 30 -190 30 -170 {lab=pre_up}
N -60 -190 30 -190 {lab=pre_up}
N -150 -250 -150 -230 {lab=vp}
N -150 -80 -150 -60 {lab=gnd}
N -320 -150 -230 -150 {lab=flip_flop_reset}
N -320 -150 -320 -30 {lab=flip_flop_reset}
N -150 -10 -150 20 {lab=vp}
N -160 170 -160 220 {lab=gnd}
N 30 -170 540 -170 {lab=pre_up}
N -340 130 -230 130 {lab=cVco}
N 20 -30 50 -30 {lab=#net2}
N 120 -30 240 -30 {lab=post_nand}
N 100 -90 100 -60 {lab=vp}
N 100 -0 100 30 {lab=gnd}
N 820 -90 870 -90 {lab=gnd}
N 820 -100 820 -90 {lab=gnd}
N 870 -130 870 -90 {lab=gnd}
N 820 -130 870 -130 {lab=gnd}
N 740 -130 780 -130 {lab=rst}
N 820 -170 820 -160 {lab=UP}
N 820 -170 850 -170 {lab=UP}
N 820 -90 820 -80 {lab=gnd}
N 770 440 820 440 {lab=gnd}
N 770 430 770 440 {lab=gnd}
N 820 400 820 440 {lab=gnd}
N 770 400 820 400 {lab=gnd}
N 690 400 730 400 {lab=reset}
N 770 440 770 450 {lab=gnd}
N 770 310 770 370 {lab=DOWN}
N -390 -120 -230 -120 {lab=cRef}
N -460 -30 -350 -30 {lab=flip_flop_reset}
N -320 -30 -270 -30 {lab=flip_flop_reset}
N -250 -90 -250 -60 {lab=vp}
N -250 0 -250 30 {lab=gnd}
N -230 -90 -230 -60 {lab=rst}
N -230 0 -230 30 {lab=reset_n}
N -190 -30 -80 -30 {lab=#net3}
N -60 130 -20 130 {lab=#net4}
N -60 60 540 60 {lab=pre_down}
N -160 170 -150 170 {lab=gnd}
N -860 -110 -790 -110 {lab=rst}
N 570 -230 570 -200 {lab=vp}
N 740 -170 820 -170 {lab=UP}
N 540 -170 550 -170 {lab=pre_up}
N 690 -140 690 -110 {lab=gnd}
N 690 -230 690 -200 {lab=vp}
N 560 340 560 370 {lab=gnd}
N 560 250 560 280 {lab=vp}
N 660 340 660 370 {lab=gnd}
N 660 250 660 280 {lab=vp}
N 710 310 770 310 {lab=DOWN}
N 610 310 640 310 {lab=#net5}
N 620 -170 670 -170 {lab=#net6}
C {iopin.sym} -290 -340 0 0 {name=p1 lab=gnd}
C {iopin.sym} -290 -310 0 0 {name=p2 lab=vp
}
C {ipin.sym} -390 -120 0 0 {name=p5 lab=cRef}
C {ipin.sym} -340 130 0 0 {name=p6 lab=cVco}
C {lab_wire.sym} -310 -180 0 0 {name=p7 sig_type=std_logic lab=vp}
C {lab_wire.sym} -270 70 0 0 {name=p8 sig_type=std_logic lab=vp}
C {lab_wire.sym} -590 -30 0 0 {name=p9 sig_type=std_logic lab=vp}
C {lab_wire.sym} -150 -250 0 0 {name=p10 sig_type=std_logic lab=vp}
C {lab_wire.sym} -150 -10 0 0 {name=p11 sig_type=std_logic lab=vp}
C {lab_wire.sym} -160 220 0 0 {name=p12 sig_type=std_logic lab=gnd}
C {lab_wire.sym} -150 -60 0 0 {name=p13 sig_type=std_logic lab=gnd}
C {lab_wire.sym} -20 -90 0 0 {name=p14 sig_type=std_logic lab=vp}
C {lab_wire.sym} -20 30 0 0 {name=p15 sig_type=std_logic lab=gnd}
C {lab_wire.sym} 570 -110 0 0 {name=p16 sig_type=std_logic lab=gnd}
C {lab_wire.sym} 570 -230 0 0 {name=p17 sig_type=std_logic lab=vp}
C {/foss/designs/CHIP-PLL/schematics/divider/schematics/NAND_2in.sym} 390 -50 0 1 {name=x7}
C {lab_wire.sym} 200 -70 0 0 {name=p20 sig_type=std_logic lab=vp}
C {lab_wire.sym} 200 -50 0 0 {name=p21 sig_type=std_logic lab=gnd}
C {noconn.sym} 20 -120 0 1 {name=l1}
C {noconn.sym} -20 130 0 1 {name=l2}
C {ipin.sym} -860 -110 0 0 {name=p24 lab=rst}
C {/foss/designs/CHIP-PLL/schematics/divider/schematics/inverter_x4.sym} -770 -110 0 0 {name=x9}
C {lab_wire.sym} -520 -90 0 0 {name=p25 sig_type=std_logic lab=vp}
C {lab_wire.sym} -520 30 0 0 {name=p26 sig_type=std_logic lab=gnd}
C {lab_wire.sym} -770 -60 0 0 {name=p27 sig_type=std_logic lab=gnd}
C {lab_wire.sym} -770 -170 0 0 {name=p28 sig_type=std_logic lab=vp}
C {lab_wire.sym} -680 -110 0 0 {name=p29 sig_type=std_logic lab=reset_n}
C {lab_wire.sym} 400 60 0 1 {name=p32 sig_type=std_logic lab=pre_down}
C {lab_wire.sym} 450 -170 0 0 {name=p33 sig_type=std_logic lab=pre_up}
C {lab_wire.sym} 230 -30 0 0 {name=p34 sig_type=std_logic lab=post_nand}
C {lab_wire.sym} -360 -30 0 0 {name=p35 sig_type=std_logic lab=flip_flop_reset}
C {PFD_flip_flop.sym} -80 -180 0 0 {name=xflipFlopCref}
C {PFD_flip_flop.sym} -80 70 0 0 {name=xFlipFlopCvco}
C {lab_wire.sym} 100 30 0 0 {name=p47 sig_type=std_logic lab=gnd}
C {lab_wire.sym} 100 -90 0 0 {name=p48 sig_type=std_logic lab=vp}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 800 -130 0 0 {name=M4
l=0.15u
w=0.45u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_wire.sym} 820 -80 0 0 {name=p52 sig_type=std_logic lab=gnd}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 750 400 0 0 {name=M5
l=0.15u
w=0.45u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_wire.sym} 770 450 0 0 {name=p53 sig_type=std_logic lab=gnd}
C {opin.sym} 850 -170 0 0 {name=p55 lab=UP
}
C {opin.sym} 780 310 0 0 {name=p3 lab=DOWN
}
C {lab_wire.sym} -250 -90 0 0 {name=p4 sig_type=std_logic lab=vp}
C {lab_wire.sym} -250 30 0 0 {name=p22 sig_type=std_logic lab=gnd}
C {lab_wire.sym} -500 -90 0 1 {name=p30 sig_type=std_logic lab=reset_n}
C {lab_wire.sym} -500 30 0 1 {name=p31 sig_type=std_logic lab=rst}
C {lab_wire.sym} -230 -90 0 1 {name=p36 sig_type=std_logic lab=rst}
C {lab_wire.sym} -230 30 0 1 {name=p23 sig_type=std_logic lab=reset_n}
C {lab_wire.sym} 760 -130 0 0 {name=p42 sig_type=std_logic lab=rst}
C {lab_wire.sym} 700 400 0 0 {name=p43 sig_type=std_logic lab=rst}
C {/foss/designs/CHIP-PLL/schematics/divider/schematics/inverter_x4.sym} 690 -170 0 0 {name=x4}
C {lab_wire.sym} 690 -110 0 0 {name=p44 sig_type=std_logic lab=gnd}
C {lab_wire.sym} 690 -230 0 0 {name=p45 sig_type=std_logic lab=vp}
C {lab_wire.sym} 560 370 0 0 {name=p18 sig_type=std_logic lab=gnd}
C {lab_wire.sym} 560 250 0 0 {name=p19 sig_type=std_logic lab=vp}
C {/foss/designs/CHIP-PLL/schematics/divider/schematics/inverter_x4.sym} 660 310 0 0 {name=x6}
C {lab_wire.sym} 660 370 0 0 {name=p46 sig_type=std_logic lab=gnd}
C {lab_wire.sym} 660 250 0 0 {name=p49 sig_type=std_logic lab=vp}
C {/foss/designs/CHIP-PLL/schematics/divider/schematics/inverter_x4.sym} 570 -170 0 0 {name=x2}
C {/foss/designs/CHIP-PLL/schematics/divider/schematics/inverter_x4.sym} 560 310 0 0 {name=x5}
C {PFD_passgate.sym} -500 -30 0 0 {name=x1}
C {PFD_passgate.sym} -230 -30 0 0 {name=x3}
C {PFD_buffor.sym} -130 -30 0 1 {name=x8}
C {/foss/designs/CHIP-PLL/schematics/divider/schematics/inverter_x4.sym} 100 -30 0 1 {name=x11}
