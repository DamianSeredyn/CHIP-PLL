v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -70 -20 -20 -20 {lab=in}
N 230 -20 280 -20 {lab=out}
N 70 -20 70 10 {lab=out}
N 40 -20 70 -20 {lab=out}
N 150 90 150 120 {lab=gd}
N 150 90 180 90 {lab=gd}
N 150 50 150 90 {lab=gd}
N 180 50 180 90 {lab=gd}
N 120 90 150 90 {lab=gd}
N 120 50 120 90 {lab=gd}
N 230 90 230 120 {lab=gd}
N 230 90 260 90 {lab=gd}
N 230 50 230 90 {lab=gd}
N 260 50 260 90 {lab=gd}
N 200 90 230 90 {lab=gd}
N 200 50 200 90 {lab=gd}
N 40 50 40 90 {lab=gd}
N 70 90 100 90 {lab=gd}
N 100 50 100 90 {lab=gd}
N 70 50 70 90 {lab=gd}
N 40 90 70 90 {lab=gd}
N 70 90 70 130 {lab=gd}
N 150 -20 150 10 {lab=out}
N 70 -20 150 -20 {lab=out}
N 230 -20 230 10 {lab=out}
N 150 -20 230 -20 {lab=out}
C {ipin.sym} -70 -20 0 0 {name=p1 lab=in}
C {opin.sym} 280 -20 0 0 {name=p2 lab=out}
C {ipin.sym} 70 130 0 0 {name=p3 lab=gd}
C {/foss/pdks/ihp-sg13cmos5l/libs.tech/xschem/sg13cmos5l_pr/sg13_lv_nmos.sym} 70 30 1 0 {name=M1
l=10u
w=10u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {/foss/pdks/ihp-sg13cmos5l/libs.tech/xschem/sg13cmos5l_pr/sg13_lv_nmos.sym} 150 30 1 0 {name=M3
l=10u
w=10u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {/foss/pdks/ihp-sg13cmos5l/libs.tech/xschem/sg13cmos5l_pr/sg13_lv_nmos.sym} 230 30 1 0 {name=M4
l=10u
w=10u
ng=1
m=1
mm_ok=1
model=sg13_lv_nmos
spiceprefix=X
}
C {lab_pin.sym} 150 120 0 0 {name=p9 sig_type=std_logic lab=gd}
C {lab_pin.sym} 230 120 0 0 {name=p4 sig_type=std_logic lab=gd}
C {/foss/pdks/ihp-sg13cmos5l/libs.tech/xschem/sg13g2_pr/rppd.sym} 10 -20 1 0 {name=R2
w=0.5e-6
l=0.5e-6
model=rppd
body=gd
spiceprefix=X
 m=1
  mm_ok=1
value="expr_eng(  ( 70.0e-6 / @w + 260.0 * ( (@b + 1)* @l + ( 1.081*( @w + 6.0e-9 ) + 0.18e-6 )*@b ) / ( @w + 6.0e-9 ) ) / @m  )"
}
