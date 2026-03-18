** sch_path: /foss/designs/untitled.sch
**.subckt untitled vp in out gnd
*.iopin vp
*.iopin gnd
*.ipin in
*.opin out
XM1 out in gnd gnd sg13_lv_nmos w=1.0u l=0.72u ng=1 m=1 rfmode=1
XM2 out in vp vp sg13_lv_pmos w=0.15u l=0.13u ng=1
**.ends
.end
