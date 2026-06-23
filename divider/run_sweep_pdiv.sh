#!/bin/bash
# ==============================================================================
# SWEEP PROGRAMMABLE DIVIDER (pdiv) — corner / temperatura / VDD
# ==============================================================================
# Sweeps programmable divider testbench (pdiv_sym_tb.spice) across PVT conditions.
# Measures clock, programmable divider output, and intermediate division stages.
# Calls plot_divider_pdiv.py to analyze frequency, duty cycle, and divisibility.
#
# Place in divider/scripts/ and run from there.
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

source $PROJECT_DIR/configs/corner_data

# ── Presets (-c <preset or corner>) ──────────────────────────────────────────
# Available presets:
#   typ   → mos_tt,  t_nom,        vp_nom        (typical conditions)
#   hot   → mos_ss,  t_max,        vp_min        (worst-case hot)
#   cold  → mos_ff,  t_min,        vp_max        (worst-case cold)
#
# Can also pass corner names directly: -c tt ss ff
# Without arguments: all corners and all PVT combinations are simulated
# ──────────────────────────────────────────────────────────────────────────────

FILTER_CORNERS=""
FILTER_TEMPS=""
FILTER_VPS=""
PRESET=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        -c) shift
            while [[ $# -gt 0 && "$1" != -* ]]; do
                case "$1" in
                    typ)
                        PRESET="typ"
                        FILTER_CORNERS="$FILTER_CORNERS mos_tt"
                        FILTER_TEMPS="$t_nom"
                        FILTER_VPS="$vp_nom"
                        ;;
                    hot)
                        PRESET="hot"
                        FILTER_CORNERS="$FILTER_CORNERS mos_ss"
                        FILTER_TEMPS="$t_max"
                        FILTER_VPS="$vp_min"
                        ;;
                    cold)
                        PRESET="cold"
                        FILTER_CORNERS="$FILTER_CORNERS mos_ff"
                        FILTER_TEMPS="$t_min"
                        FILTER_VPS="$vp_max"
                        ;;
                    *)
                        FILTER_CORNERS="$FILTER_CORNERS $1"
                        ;;
                esac
                shift
            done ;;
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
done

# If no presets specified for temp/vp, use full range
if [[ -z "$FILTER_TEMPS" ]]; then FILTER_TEMPS="$t_min $t_nom $t_max"; fi
if [[ -z "$FILTER_VPS" ]]; then FILTER_VPS="$vp_min $vp_nom $vp_max"; fi

if [[ -n "$FILTER_CORNERS" ]]; then
    filtered=""
    for C in $corners; do
        for F in $FILTER_CORNERS; do
            if [[ "$C" == *"$F"* ]]; then
                filtered="$filtered $C"
                break
            fi
        done
    done
    if [[ -z "$filtered" ]]; then
        echo "Error: no corner matches: $FILTER_CORNERS"
        echo "Available corners: $corners"
        exit 1
    fi
    corners="$filtered"
fi

SIM_NAME="pdiv"
SPICE=$PROJECT_DIR/divider/simulations/pdiv_sym_tb.spice
DATA_DIR=$PROJECT_DIR/divider/results/data
RESULTS_DIR=$PROJECT_DIR/divider/results

if [[ -n "$PRESET" ]]; then
    echo "Preset: $PRESET → corners:$corners  temp: $FILTER_TEMPS  vp: $FILTER_VPS"
else
    echo "Simulated corners: all ($corners)"
fi

echo "Simulation parameters:"
python3 - "$SPICE" <<'PYEOF'
import re, sys
spice_path = sys.argv[1]
skip = {'temp', 'vdd'}
with open(spice_path) as f:
    for line in f:
        m = re.match(r'\.param\s+(\w+)\s*=\s*(\S+)', line.strip(), re.IGNORECASE)
        if m and m.group(1).lower() not in skip:
            print(f"  {m.group(1)}={m.group(2)}")
PYEOF

mkdir -p $DATA_DIR

# Remove all previous results before each simulation
rm -f $DATA_DIR/${SIM_NAME}_*.dat
rm -f $RESULTS_DIR/${SIM_NAME}_report.html

# Count total combinations
TOTAL=0
for CORNER in $corners; do
for TEMP in $FILTER_TEMPS; do
for VP in $FILTER_VPS; do
    TOTAL=$((TOTAL + 1))
done; done; done

CURRENT=0

for CORNER in $corners; do
for TEMP in $FILTER_TEMPS; do
for VP in $FILTER_VPS; do

    TAG="${CORNER}_T${TEMP}_Vp${VP}"
    DAT=$DATA_DIR/${SIM_NAME}_${TAG}.dat

    python3 - "$SPICE" "$CORNER" "$TEMP" "$VP" "$DAT" <<'PYEOF'
import re, sys
spice_path, corner, temp, vp, dat_path = sys.argv[1:]

with open(spice_path) as f:
    spice = f.read()

# 1. Remove existing .control block
spice = re.sub(r'\.control.*?\.endc', '', spice, flags=re.DOTALL)

# 2. Replace swept parameters
spice = re.sub(r'\.param\s+temp\s*=.*', f'.param temp={temp}', spice)
spice = re.sub(r'\.param\s+vdd\s*=.*',  f'.param vdd={vp}',    spice)

# 3. Select corner from cornerMOSlv.lib
spice = re.sub(r'(\.lib\s+\S*cornerMOSlv\.lib\s+)\S+',
               r'\g<1>' + corner, spice, flags=re.IGNORECASE)

# 4. Remove existing .options TEMP lines
spice = re.sub(r'\.options[^\n]*\bTEMP\b[^\n]*\n', '', spice, flags=re.IGNORECASE)

# 5. Insert .options TEMP before .end
spice = re.sub(r'(\.end\b)', f'.options TEMP={temp}\n\\1', spice, flags=re.IGNORECASE)

# 6. New .control block
# Measures: clk (reference), out_div (divider /2 output), out (main output),
# and division stages if available in testbench (div2-div64 for monitoring)
# NOTE: Adjust signal list to match actual signals in pdiv_sym_tb.spice
control_block = f"""
.control
tran 50p 4u
wrdata {dat_path} v(clk) v(out) v(out_div) v(div2) v(div4) v(div8) v(div16) v(div32) v(div64)
exit
.endc
"""

with open('/tmp/pdiv_run.spice', 'w') as f:
    f.write(spice + control_block)
PYEOF

    ngspice -b /tmp/pdiv_run.spice >/dev/null 2>&1

    CURRENT=$((CURRENT + 1))
    PCT=$(( CURRENT * 100 / TOTAL ))
    printf "%-45s — done %3d%% of simulation finished\n" "${TAG}" "${PCT}"

done
done
done

echo "Generating report..."
python3 $SCRIPT_DIR/plot_divider_pdiv.py
