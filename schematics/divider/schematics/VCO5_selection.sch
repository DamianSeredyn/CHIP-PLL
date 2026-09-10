v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 4 300 -690 300 -350 {}
L 4 300 -740 300 -400 {}
L 4 300 -740 640 -740 {}
L 4 620 -740 960 -740 {}
L 4 950 -740 1290 -740 {}
L 4 1270 -740 1610 -740 {}
L 4 300 -350 640 -350 {}
L 4 620 -350 960 -350 {}
L 4 950 -350 1290 -350 {}
L 4 1270 -350 1610 -350 {}
L 4 1770 -690 1770 -350 {}
L 4 1770 -740 1770 -400 {}
L 4 1430 -740 1770 -740 {}
L 4 1430 -350 1770 -350 {}
T {VCO5 selection} 300 -770 0 0 0.4 0.4 {}
N 740 -430 760 -430 {lab=gd}
N 740 -450 760 -450 {lab=VP}
N 420 -450 440 -450 {lab=010}
N 420 -410 440 -410 {lab=f1_n}
N 420 -430 440 -430 {lab=after_000011_n}
N 740 -550 760 -550 {lab=gd}
N 740 -570 760 -570 {lab=VP}
N 810 -500 810 -490 {lab=gd}
N 810 -570 810 -560 {lab=VP}
N 740 -530 790 -530 {lab=#net1}
N 860 -530 940 -530 {lab=#net2}
N 420 -570 440 -570 {lab=000}
N 420 -550 440 -550 {lab=after_000011_n}
N 1290 -660 1310 -660 {lab=gd}
N 1290 -680 1310 -680 {lab=VP}
N 1360 -610 1360 -600 {lab=gd}
N 1360 -680 1360 -670 {lab=VP}
N 1290 -640 1340 -640 {lab=#net3}
N 970 -680 990 -680 {lab=001}
N 970 -640 990 -640 {lab=after_000011_n}
N 740 -680 760 -680 {lab=gd}
N 740 -700 760 -700 {lab=VP}
N 810 -630 810 -620 {lab=gd}
N 810 -700 810 -690 {lab=VP}
N 740 -660 790 -660 {lab=#net4}
N 420 -700 440 -700 {lab=f0}
N 420 -680 440 -680 {lab=f1}
N 860 -660 990 -660 {lab=#net5}
N 1240 -530 1260 -530 {lab=gd}
N 1240 -550 1260 -550 {lab=VP}
N 1600 -490 1620 -490 {lab=gd}
N 1600 -510 1620 -510 {lab=VP}
N 1600 -470 1650 -470 {lab=VCO5_11_sel}
N 1240 -510 1300 -510 {lab=#net6}
N 940 -490 1300 -490 {lab=#net7}
N 930 -550 940 -550 {lab=#net8}
N 930 -580 930 -550 {lab=#net8}
N 930 -580 1430 -580 {lab=#net8}
N 1430 -640 1430 -580 {lab=#net8}
N 1410 -640 1430 -640 {lab=#net8}
N 940 -490 940 -410 {lab=#net7}
N 740 -410 940 -410 {lab=#net7}
N 460 -1260 480 -1260 {lab=gd}
N 460 -1240 480 -1240 {lab=VP}
N 460 -1140 480 -1140 {lab=f0}
N 460 -1120 480 -1120 {lab=f1}
N 760 -1160 780 -1160 {lab=VCO5_11_sel}
N 460 -1100 480 -1100 {lab=000}
N 460 -1080 480 -1080 {lab=after_000011_n}
N 460 -1060 480 -1060 {lab=010}
N 460 -1040 480 -1040 {lab=f1_n}
N 460 -1010 480 -1010 {lab=001}
C {NAND_3in.sym} 590 -430 0 0 {name=x41}
C {lab_wire.sym} 760 -450 2 0 {name=p213 sig_type=std_logic lab=VP}
C {lab_wire.sym} 760 -430 2 0 {name=p214 sig_type=std_logic lab=gd}
C {lab_wire.sym} 760 -570 2 0 {name=p217 sig_type=std_logic lab=VP}
C {lab_wire.sym} 760 -550 2 0 {name=p218 sig_type=std_logic lab=gd}
C {inverter.sym} 810 -530 0 0 {name=x44}
C {lab_wire.sym} 810 -570 0 1 {name=p219 sig_type=std_logic lab=VP}
C {lab_wire.sym} 810 -490 2 0 {name=p220 sig_type=std_logic lab=gd}
C {NAND_2in.sym} 590 -550 0 0 {name=x43}
C {NAND_3in.sym} 1140 -660 0 0 {name=x95}
C {lab_wire.sym} 1310 -680 2 0 {name=p390 sig_type=std_logic lab=VP}
C {lab_wire.sym} 1310 -660 2 0 {name=p391 sig_type=std_logic lab=gd}
C {inverter.sym} 1360 -640 0 0 {name=x101}
C {lab_wire.sym} 1360 -680 0 1 {name=p392 sig_type=std_logic lab=VP}
C {lab_wire.sym} 1360 -600 2 0 {name=p393 sig_type=std_logic lab=gd}
C {lab_wire.sym} 760 -700 2 0 {name=p396 sig_type=std_logic lab=VP}
C {lab_wire.sym} 760 -680 2 0 {name=p397 sig_type=std_logic lab=gd}
C {inverter.sym} 810 -660 0 0 {name=x102}
C {lab_wire.sym} 810 -700 0 1 {name=p398 sig_type=std_logic lab=VP}
C {lab_wire.sym} 810 -620 2 0 {name=p399 sig_type=std_logic lab=gd}
C {lab_wire.sym} 1650 -470 2 0 {name=p389 sig_type=std_logic lab=VCO5_11_sel}
C {NOR_2in.sym} 1090 -530 0 0 {name=x104}
C {lab_wire.sym} 1260 -550 2 0 {name=p394 sig_type=std_logic lab=VP}
C {lab_wire.sym} 1260 -530 2 0 {name=p395 sig_type=std_logic lab=gd}
C {lab_wire.sym} 1620 -510 2 0 {name=p400 sig_type=std_logic lab=VP}
C {lab_wire.sym} 1620 -490 2 0 {name=p401 sig_type=std_logic lab=gd}
C {NAND_2in.sym} 1450 -490 0 0 {name=x106}
C {XNOR.sym} 590 -680 0 0 {name=x100}
C {lab_wire.sym} 970 -680 0 0 {name=p215 sig_type=std_logic lab=001}
C {lab_wire.sym} 420 -570 0 0 {name=p216 sig_type=std_logic lab=000}
C {lab_wire.sym} 970 -640 0 0 {name=p402 sig_type=std_logic lab=after_000011_n}
C {lab_wire.sym} 420 -700 0 0 {name=p403 sig_type=std_logic lab=f0}
C {lab_wire.sym} 420 -680 0 0 {name=p404 sig_type=std_logic lab=f1}
C {lab_wire.sym} 420 -550 0 0 {name=p405 sig_type=std_logic lab=after_000011_n}
C {lab_wire.sym} 420 -410 0 0 {name=p406 sig_type=std_logic lab=f1_n}
C {lab_wire.sym} 420 -430 0 0 {name=p407 sig_type=std_logic lab=after_000011_n}
C {lab_wire.sym} 420 -450 0 0 {name=p408 sig_type=std_logic lab=010}
C {iopin.sym} 460 -1260 2 0 {name=p46 lab=gd}
C {lab_wire.sym} 480 -1260 2 0 {name=p53 sig_type=std_logic lab=gd}
C {iopin.sym} 460 -1240 2 0 {name=p54 lab=VP}
C {ipin.sym} 460 -1140 0 0 {name=p59 lab=f0}
C {lab_wire.sym} 480 -1140 2 0 {name=p60 sig_type=std_logic lab=f0}
C {ipin.sym} 460 -1120 0 0 {name=p61 lab=f1}
C {lab_wire.sym} 480 -1120 2 0 {name=p63 sig_type=std_logic lab=f1}
C {lab_wire.sym} 480 -1240 2 0 {name=p1 sig_type=std_logic lab=VP}
C {opin.sym} 760 -1160 0 1 {name=p14 lab=VCO5_11_sel}
C {lab_wire.sym} 780 -1160 2 0 {name=p15 sig_type=std_logic lab=VCO5_11_sel}
C {ipin.sym} 460 -1100 0 0 {name=p19 lab=000}
C {lab_wire.sym} 480 -1100 2 0 {name=p22 sig_type=std_logic lab=000}
C {ipin.sym} 460 -1080 0 0 {name=p23 lab=after_000011_n}
C {lab_wire.sym} 480 -1080 2 0 {name=p24 sig_type=std_logic lab=after_000011_n}
C {ipin.sym} 460 -1060 0 0 {name=p25 lab=010}
C {lab_wire.sym} 480 -1060 2 0 {name=p26 sig_type=std_logic lab=010}
C {ipin.sym} 460 -1040 0 0 {name=p27 lab=f1_n}
C {lab_wire.sym} 480 -1040 2 0 {name=p28 sig_type=std_logic lab=f1_n}
C {ipin.sym} 460 -1010 0 0 {name=p2 lab=001}
C {lab_wire.sym} 480 -1010 2 0 {name=p20 sig_type=std_logic lab=001}
