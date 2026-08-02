v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 90 -10 90 10 {lab=#net1}
N 0 40 50 40 {lab=#net2}
N 0 -60 -0 40 {lab=#net2}
N -0 -60 50 -60 {lab=#net2}
N 90 -10 220 -10 {lab=#net1}
N 90 -30 90 -10 {lab=#net1}
N 220 -10 220 40 {lab=#net1}
N 220 -60 220 -10 {lab=#net1}
N 90 -120 90 -90 {lab=#net3}
N 130 -120 260 -120 {lab=#net3}
N 260 -120 260 -90 {lab=#net3}
N 90 70 90 100 {lab=#net4}
N 140 100 260 100 {lab=#net4}
N 260 70 260 100 {lab=#net4}
N 90 40 140 40 {lab=#net4}
N 140 40 140 100 {lab=#net4}
N 90 100 140 100 {lab=#net4}
N 260 40 300 40 {lab=#net4}
N 300 40 300 100 {lab=#net4}
N 260 100 300 100 {lab=#net4}
N 260 -60 300 -60 {lab=#net3}
N 300 -120 300 -60 {lab=#net3}
N 260 -120 300 -120 {lab=#net3}
N 90 -60 130 -60 {lab=#net3}
N 130 -120 130 -60 {lab=#net3}
N 90 -120 130 -120 {lab=#net3}
N 260 -10 260 10 {lab=#net5}
N 260 -10 360 -10 {lab=#net5}
N 260 -30 260 -10 {lab=#net5}
C {sg13g2_pr/sg13_hv_pmos.sym} 70 -60 0 0 {name=M1
l=0.4u
w=0.3u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} 70 40 0 0 {name=M2
l=0.45u
w=0.3u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} 240 -60 0 0 {name=M3
l=0.4u
w=0.3u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} 240 40 0 0 {name=M4
l=0.45u
w=0.3u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_nmos
spiceprefix=X
}
