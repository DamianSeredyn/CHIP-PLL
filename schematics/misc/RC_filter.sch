v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 50 -20 230 -20 {lab=in}
N 230 -20 280 -20 {lab=in}
N 230 90 230 120 {lab=gd}
N 230 90 260 90 {lab=gd}
N 230 50 230 90 {lab=gd}
N 260 50 260 90 {lab=gd}
N 200 90 230 90 {lab=gd}
N 230 -20 230 10 {lab=in}
N 50 -20 50 20 {lab=in}
N -70 -20 50 -20 {lab=in}
N 50 80 50 120 {lab=#net1}
N 50 210 50 230 {lab=gd}
N 20 160 20 210 {lab=gd}
N 20 210 50 210 {lab=gd}
N 50 160 50 210 {lab=gd}
N 50 210 80 210 {lab=gd}
N 80 160 80 210 {lab=gd}
C {ipin.sym} -70 -20 0 0 {name=p1 lab=in}
C {opin.sym} 280 -20 0 0 {name=p2 lab=out}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 230 30 1 0 {name=M1
l=10u
w=10u
ng=1
m=5
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 230 120 0 0 {name=p4 sig_type=std_logic lab=gd}
C {sg13g2_pr/rppd.sym} 50 50 2 0 {name=R2
w=0.5e-6
l=10e-6
model=rppd
body=gd
spiceprefix=X
 m=1
  mm_ok=1
value="expr_eng(  ( 70.0e-6 / @w + 260.0 * ( (@b + 1)* @l + ( 1.081*( @w + 6.0e-9 ) + 0.18e-6 )*@b ) / ( @w + 6.0e-9 ) ) / @m  )"
}
C {lab_pin.sym} 50 230 0 0 {name=p3 sig_type=std_logic lab=gd}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 50 140 1 0 {name=M2
l=10u
w=10u
ng=1
m=5
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
