#!/bin/bash

OUT=/foss/designs/CHIP-PLL/PFD/simulations/pfd_linearity.txt
SPICE=/foss/designs/CHIP-PLL/PFD/simulations/PFD_tb.spice
T_US=31.25
STEPS=64

rm -f $OUT
echo "dly pw_up pw_down" > $OUT

for i in $(seq 0 $((STEPS-1))); do
    DLY=$(echo "scale=6; $i * $T_US / ($STEPS-1)" | bc)
    DLY_U="${DLY}u"

    sed "s/\.param dly=.*/.param dly=$DLY_U/" $SPICE > /tmp/pfd_run.spice
    RESULT=$(ngspice -b /tmp/pfd_run.spice 2>/dev/null)
    PW_UP=$(echo "$RESULT" | grep "pw_up" | awk '{print $3}')
    PW_DOWN=$(echo "$RESULT" | grep "pw_down" | awk '{print $3}')
    echo "$DLY_U $PW_UP $PW_DOWN" >> $OUT
    echo "Done: dly=$DLY_U pw_up=$PW_UP pw_down=$PW_DOWN"
done

python3 /foss/designs/CHIP-PLL/PFD/scripts/plot_pfd.py
