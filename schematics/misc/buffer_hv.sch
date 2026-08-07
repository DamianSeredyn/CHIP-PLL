v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 90 -10 90 10 {lab=buf_stage_1}
N 0 40 50 40 {lab=in}
N 0 -60 -0 40 {lab=in}
N -0 -60 50 -60 {lab=in}
N 90 -10 220 -10 {lab=buf_stage_1}
N 90 -30 90 -10 {lab=buf_stage_1}
N 220 -10 220 40 {lab=buf_stage_1}
N 220 -60 220 -10 {lab=buf_stage_1}
N 90 -120 90 -90 {lab=vph}
N 260 -120 260 -90 {lab=vph}
N 90 70 90 100 {lab=gd}
N 260 70 260 100 {lab=gd}
N 90 40 140 40 {lab=gd}
N 140 40 140 100 {lab=gd}
N 90 100 140 100 {lab=gd}
N 260 40 300 40 {lab=gd}
N 300 40 300 100 {lab=gd}
N 260 100 300 100 {lab=gd}
N 260 -60 300 -60 {lab=vph}
N 300 -120 300 -60 {lab=vph}
N 260 -120 300 -120 {lab=vph}
N 90 -60 130 -60 {lab=vph}
N 130 -120 130 -60 {lab=vph}
N 90 -120 130 -120 {lab=vph}
N 260 -10 260 10 {lab=out}
N 260 -10 360 -10 {lab=out}
N 260 -30 260 -10 {lab=out}
N 130 -120 260 -120 {lab=vph}
N 140 100 260 100 {lab=gd}
C {sg13g2_pr/sg13_hv_pmos.sym} 70 -60 0 0 {name=M1
l=0.45u
w=1u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} 70 40 0 0 {name=M2
l=0.45u
w=1u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} 240 -60 0 0 {name=M3
l=0.45u
w=1u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} 240 40 0 0 {name=M4
l=0.45u
w=1u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_nmos
spiceprefix=X
}
C {ipin.sym} 0 -10 0 0 {name=p1 lab=in}
C {opin.sym} 360 -10 0 0 {name=p2 lab=out}
C {lab_wire.sym} 190 -10 0 0 {name=p3 sig_type=std_logic lab=buf_stage_1}
C {ipin.sym} 90 -120 0 0 {name=p6 lab=vph}
C {ipin.sym} 90 100 0 0 {name=p5 lab=gd}
