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
N 70 70 70 100 {lab=#net1}
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
C {sg13cmos5l_pr/cap_mfringe.sym} 70 40 0 0 {name=C1
model=cap_mfringe
w=2.0u
l=2.0u
mmin=1
mmax=4
spiceprefix=X
}
C {ipin.sym} 70 100 0 0 {name=p3 lab=gd}
