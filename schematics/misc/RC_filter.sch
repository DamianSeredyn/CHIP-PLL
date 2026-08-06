v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -70 -20 -20 -20 {lab=in}
N 70 -20 110 -20 {lab=out}
N 70 -20 70 10 {lab=out}
N 40 -20 70 -20 {lab=out}
N 70 90 70 140 {lab=gd}
N 40 50 40 90 {lab=gd}
N 40 90 70 90 {lab=gd}
N 70 50 70 90 {lab=gd}
N 70 90 100 90 {lab=gd}
N 100 50 100 90 {lab=gd}
C {sg13cmos5l_pr/rppd.sym} 10 -20 1 0 {name=R1
w=0.5e-6
l=0.5e-6
model=rppd
body=gd
spiceprefix=X
b=0
 m=1
  mm_ok=1
value="expr_eng(  ( 70.0e-6 / @w + 260.0 * ( (@b + 1)* @l + ( 1.081*( @w + 6.0e-9 ) + 0.18e-6 )*@b ) / ( @w + 6.0e-9 ) ) / @m  )"
}
C {ipin.sym} -70 -20 0 0 {name=p1 lab=in}
C {opin.sym} 110 -20 0 0 {name=p2 lab=out}
C {ipin.sym} 70 140 0 0 {name=p3 lab=gd}
C {sg13cmos5l_pr/sg13_lv_nmos.sym} 70 30 1 0 {name=M1
l=0.2u
w=5u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
