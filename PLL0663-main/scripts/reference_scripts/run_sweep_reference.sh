ge#!/bin/bash
# ==============================================================================
# REFERENCE SWEEP SCRIPT
# ------------------------------------------------------------------------------
# Generic corner / temperature / VDD sweep driver for ngspice testbenches.
# Copy this file into your <block>/scripts/ directory and adapt the sections
# marked  # === USER EDIT ===  to fit your simulation.
#
# What this script does (and what stays the same across blocks):
#   - parses -c <preset|corner> arguments (typ / hot / cold / raw corner names)
#   - sources $PROJECT_DIR/configs/corner_data for corner & PVT ranges
#   - filters the corner list against the user's selection
#   - prints all .param lines from the testbench (except externally-controlled
#     ones: temp, vdd) so the user sees what stays fixed across the sweep
#   - cleans previous .dat / .png / report.html results
#   - loops over corners × temperatures × VDDs (× any extra user axes), patches
#     the SPICE deck per-combination, runs ngspice -b, prints progress
#   - calls the plotting/report script at the end
#
# What you MUST edit before running:
#   1. SIM_NAME            — output filename prefix
#   2. SPICE testbench path
#   3. Plot script name
#   4. The .control block (probes, analysis type, simulation time)
#   5. Any extra inner sweep axes (e.g. Vin for a VCO, load cap for a buffer)
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

source $PROJECT_DIR/configs/corner_data
# corner_data provides:
#   t_min, t_nom, t_max          (temperatures, °C)
#   vp_min, vp_nom, vp_max       (supply voltages, V)
#   corners                      (space-separated list, e.g. "mos_tt mos_ss ...")


# ==============================================================================
# PRESETS  (-c <preset or corner>)
# ------------------------------------------------------------------------------
# Available presets:
#   typ   → mos_tt,  t_nom,  vp_nom    (typical conditions)
#   hot   → mos_ss,  t_max,  vp_min    (worst-case hot)
#   cold  → mos_ff,  t_min,  vp_max    (worst-case cold)
#
# You can also pass corner names directly: -c tt ss ff
# No arguments → full sweep over all corners and all PVT points.
# ==============================================================================

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

# Default to full ranges if no preset narrowed them
if [[ -z "$FILTER_TEMPS" ]]; then FILTER_TEMPS="$t_min $t_nom $t_max"; fi
if [[ -z "$FILTER_VPS"   ]]; then FILTER_VPS="$vp_min $vp_nom $vp_max"; fi

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


# ==============================================================================
# === USER EDIT ===  PATHS & NAMING
# ------------------------------------------------------------------------------
# SIM_NAME is the prefix used for all output files (.dat, .png, report).
# SPICE is the path to your testbench netlist.
# PLOT_SCRIPT is the python file that turns .dat files into plots + html report.
# ==============================================================================

SIM_NAME="myblock"
SPICE=$PROJECT_DIR/myblock/simulations/myblock_tb.spice
PLOT_SCRIPT=$SCRIPT_DIR/plot_myblock.py

DATA_DIR=$PROJECT_DIR/$SIM_NAME/results/data
RESULTS_DIR=$PROJECT_DIR/$SIM_NAME/results


# ==============================================================================
# Informational header
# ==============================================================================

if [[ -n "$PRESET" ]]; then
    echo "Preset: $PRESET → corners:$corners  temp: $FILTER_TEMPS  vp: $FILTER_VPS"
else
    echo "Simulated corners: all ($corners)"
fi

echo "Simulation parameters:"
python3 - "$SPICE" <<'PYEOF'
import re, sys
spice_path = sys.argv[1]
# Skip params that are externally swept (controlled by this script).
# If you add more swept params (e.g. vin, iload), add them here too.
skip = {'temp', 'vdd'}
with open(spice_path) as f:
    for line in f:
        m = re.match(r'\.param\s+(\w+)\s*=\s*(\S+)', line.strip(), re.IGNORECASE)
        if m and m.group(1).lower() not in skip:
            print(f"  {m.group(1)}={m.group(2)}")
PYEOF

mkdir -p $DATA_DIR

# Clean previous results before each run
rm -f $DATA_DIR/${SIM_NAME}_*.dat
rm -f $RESULTS_DIR/${SIM_NAME}_*.png
rm -f $RESULTS_DIR/${SIM_NAME}_report.html


# ==============================================================================
# === USER EDIT ===  EXTRA SWEEP AXES (optional)
# ------------------------------------------------------------------------------
# If your simulation needs more sweep axes beyond corner/temp/vdd, add them as
# extra `for` loops below AND:
#   - extend TAG to include the new variable
#   - add a sed-style rewrite for it in the python heredoc (.param <name>=...)
#   - add the variable name to the `skip` set in the parameter-printing block
#     above so it isn't printed as a fixed parameter
#
# Example (VCO): add `for VIN in 0.4 0.8; do ... done` around the inner block,
# include `_Vin${VIN}` in TAG, and add `.param vin=...` rewriting in the python.
# ==============================================================================

# Count total combinations for progress reporting
TOTAL=0
for CORNER in $corners; do
for TEMP in $FILTER_TEMPS; do
for VP in $FILTER_VPS; do
    TOTAL=$((TOTAL + 1))
done; done; done

CURRENT=0


# ==============================================================================
# MAIN SWEEP LOOP
# ==============================================================================

for CORNER in $corners; do
for TEMP in $FILTER_TEMPS; do
for VP in $FILTER_VPS; do

    TAG="${CORNER}_T${TEMP}_Vp${VP}"
    DAT=$DATA_DIR/${SIM_NAME}_${TAG}.dat

    # --------------------------------------------------------------------------
    # Patch the SPICE deck for this PVT point.
    #
    # Steps performed inside the python heredoc:
    #   1. Strip any existing .control ... .endc block
    #   2. Rewrite .param temp= and .param vdd= to the current sweep values
    #   3. Remove any pre-existing .options TEMP line (avoid duplicates)
    #   4. Insert a fresh .options TEMP=... before .end
    #   5. Append a new .control block with the simulation + probes
    #
    # === USER EDIT ===  The control_block below is your probes & analysis.
    #   - Change `tran 200p 160u` to your simulation command (.ac, .dc, .noise…)
    #   - Change the `wrdata` line to list the signals you want saved
    #   - The .dat file column layout will be:
    #         time1 sig1   time2 sig2   time3 sig3   ...
    #     (ngspice writes one time column per signal in wrdata)
    #   - Make sure the column count and signal order matches what your
    #     plotting script expects in load_dat().
    # --------------------------------------------------------------------------

    python3 - "$SPICE" "$CORNER" "$TEMP" "$VP" "$DAT" <<'PYEOF'
import re, sys
spice_path, corner, temp, vp, dat_path = sys.argv[1:]

with open(spice_path) as f:
    spice = f.read()

# 1. Strip any existing .control block
spice = re.sub(r'\.control.*?\.endc', '', spice, flags=re.DOTALL)

# 2. Rewrite swept parameters
spice = re.sub(r'\.param\s+temp\s*=.*', f'.param temp={temp}', spice)
spice = re.sub(r'\.param\s+vdd\s*=.*',  f'.param vdd={vp}',    spice)
# === USER EDIT === add more .param rewrites here if you added sweep axes
# e.g.  spice = re.sub(r'\.param\s+vin\s*=.*', f'.param vin={vin}', spice)

# 3. Remove pre-existing .options TEMP line(s)
spice = re.sub(r'\.options[^\n]*\bTEMP\b[^\n]*\n', '', spice, flags=re.IGNORECASE)

# 4. Inject .options TEMP before .end
spice = re.sub(r'(\.end\b)', f'.options TEMP={temp}\n\\1', spice, flags=re.IGNORECASE)

# 5. === USER EDIT ===  Probes & analysis block
#    Replace the tran command and wrdata signal list with what your sim needs.
control_block = f"""
.control
* TODO: USER — set the analysis line for your simulation
* tran <step> <stop>      e.g. tran 200p 160u
* ac dec <pts> <fmin> <fmax>
* dc <src> <start> <stop> <step>
*
* TODO: USER — list the signals to save (column order matters for plotting)
* wrdata {dat_path} v(node1) v(node2) i(vsrc)
exit
.endc
"""

with open('/tmp/sim_run.spice', 'w') as f:
    f.write(spice + control_block)
PYEOF

    ngspice -b /tmp/sim_run.spice >/dev/null 2>&1

    CURRENT=$((CURRENT + 1))
    PCT=$(( CURRENT * 100 / TOTAL ))
    printf "%-45s — done %3d%% of simulation finished\n" "${TAG}" "${PCT}"

done
done
done

echo "Generating plots and report..."
python3 $PLOT_SCRIPT
