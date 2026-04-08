#!/bin/bash

OUT=/foss/designs/CHIP-PLL/PFD/simulations/pfd_linearity.txt
SPICE=/foss/designs/CHIP-PLL/PFD/simulations/PFD_tb.spice

rm -f $OUT
echo "dly pw_up pw_down" > $OUT

for DLY in 0 1u 2u 3u 4u 5u 6u 7u 8u 9u 10u 11u 12u 13u 14u 15u 16u 17u 18u 19u 20u 21u 22u 23u 24u 25u 26u 27u 28u 29u 30u 31.25u; do

    sed "s/\.param dly=.*/.param dly=$DLY/" $SPICE > /tmp/pfd_run.spice

    RESULT=$(ngspice -b /tmp/pfd_run.spice 2>/dev/null)

    PW_UP=$(echo "$RESULT" | grep "pw_up" | awk '{print $3}')
    PW_DOWN=$(echo "$RESULT" | grep "pw_down" | awk '{print $3}')

    echo "$DLY $PW_UP $PW_DOWN" >> $OUT
    echo "Done: dly=$DLY pw_up=$PW_UP pw_down=$PW_DOWN"

done
