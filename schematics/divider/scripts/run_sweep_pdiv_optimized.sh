#!/bin/bash
# ==============================================================================
# SWEEP PROGRAMMABLE DIVIDER (pdiv) — corner / temperature / VDD / division value
# ==============================================================================
# ngspice crashes for simulations longer than ~14 µs (known environment issue).
# Strategy: run one short simulation per division value N (0-63)
# with d0-d5 hardwired as DC voltages. Each simulation duration is calculated
# to provide exactly 10 periods of the slowest output (out_div), minimizing runtime.
# N=0 is bypass mode: output frequency = clk / 2
#
# RESET HANDLING (netlist now drives reset from V4 as a PWL source):
#   - reset is held HIGH (asserted) for ~75% of the out_div period at this N,
#     then released. This scales the reset duration with N so slower division
#     values still get a proportionally long, safe reset window.
#   - TSTOP = reset_release_time + 10 full out_div periods, so there are
#     always exactly 10 post-reset periods available for measurement,
#     regardless of how long reset was held.
#   - tran's optional <tstart> argument is set to the reset release time, so
#     ngspice only WRITES data (wrdata) from that point on — the reset
#     transient itself never appears in the .dat file and can't skew the
#     duty-cycle calculation done downstream.
#
# IMPORTANT: Measures from out_div (not out) because:
#   - out has very short pulses (narrow pulse train, poor for duty cycle measurement)
#   - out_div is the /2 version of out, giving ~50% duty cycle
#   - out_div is more reliable for frequency and duty cycle analysis
#
# File naming: pdiv_<corner>_T<temp>_Vp<vp>_N<nn>.dat  (nn = 00..63)
#
# Place in divider/scripts/ and run from there.
#
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# New hierarchy: CHIP-PLL/schematics/divider/scripts/<this file>
#   SCRIPT_DIR  -> .../CHIP-PLL/schematics/divider/scripts
#   DIVIDER_DIR -> .../CHIP-PLL/schematics/divider        (1 level up)
#   ROOT_DIR    -> .../CHIP-PLL                            (3 levels up)
DIVIDER_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
ROOT_DIR="$(cd "$DIVIDER_DIR/../.." && pwd)"

source $ROOT_DIR/configs/corner_data

# ── Argument parsing ───────────────────────────────────────────────────────────
FILTER_CORNERS=""
FILTER_TEMPS=""
FILTER_VPS=""

resolve_var() {
    local name="$1"
    case "$name" in
        t_min)  echo "$t_min"  ;;
        t_nom)  echo "$t_nom"  ;;
        t_max)  echo "$t_max"  ;;
        vp_min) echo "$vp_min" ;;
        vp_nom) echo "$vp_nom" ;;
        vp_max) echo "$vp_max" ;;
        *)      echo "$name"   ;;
    esac
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -c)
            shift
            while [[ $# -gt 0 && "$1" != -* ]]; do
                case "$1" in
                    typ)
                        FILTER_CORNERS="$FILTER_CORNERS mos_tt"
                        FILTER_TEMPS="$FILTER_TEMPS $t_nom"
                        FILTER_VPS="$FILTER_VPS $vp_nom"
                        ;;
                    hot)
                        FILTER_CORNERS="$FILTER_CORNERS mos_ff"
                        FILTER_TEMPS="$FILTER_TEMPS $t_min"
                        FILTER_VPS="$FILTER_VPS $vp_min"
                        ;;
                    cold)
                        FILTER_CORNERS="$FILTER_CORNERS mos_ff"
                        FILTER_TEMPS="$FILTER_TEMPS $t_nom"
                        FILTER_VPS="$FILTER_VPS $vp_max"
                        ;;
                    *)
                        FILTER_CORNERS="$FILTER_CORNERS $1"
                        ;;
                esac
                shift
            done
            ;;
        -t)
            shift
            [[ $# -eq 0 || "$1" == -* ]] && { echo "Error: -t requires a value"; exit 1; }
            while [[ $# -gt 0 && "$1" != -* ]]; do
                FILTER_TEMPS="$FILTER_TEMPS $(resolve_var "$1")"
                shift
            done
            ;;
        -v)
            shift
            [[ $# -eq 0 || "$1" == -* ]] && { echo "Error: -v requires a value"; exit 1; }
            while [[ $# -gt 0 && "$1" != -* ]]; do
                FILTER_VPS="$FILTER_VPS $(resolve_var "$1")"
                shift
            done
            ;;
        -h|--help)
            sed -n '/^# USAGE/,/^# ===/p' "$0" | sed 's/^# \?//' | head -40
            exit 0
            ;;
        *)
            echo "Error: unknown option '$1'"
            echo "Run with -h for usage."
            exit 1
            ;;
    esac
done

# ── Deduplicate lists ──────────────────────────────────────────────────────────
dedup() {
    echo "$1" | tr ' ' '\n' | grep -v '^$' | awk '!seen[$0]++' | tr '\n' ' '
}
FILTER_CORNERS=$(dedup "$FILTER_CORNERS")
FILTER_TEMPS=$(dedup "$FILTER_TEMPS")
FILTER_VPS=$(dedup "$FILTER_VPS")

# ── Fall back to full range ────────────────────────────────────────────────────
if [[ -z "$FILTER_TEMPS" ]]; then FILTER_TEMPS="$t_min $t_nom $t_max"; fi
if [[ -z "$FILTER_VPS" ]]; then FILTER_VPS="$vp_min $vp_nom $vp_max"; fi

# ── Filter corners ─────────────────────────────────────────────────────────────
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
        echo "Error: no corner matches for: $FILTER_CORNERS"
        echo "Available corners: $corners"
        exit 1
    fi
    corners=$(dedup "$filtered")
fi

# ── Configuration ──────────────────────────────────────────────────────────────
SIM_NAME="pdiv"
SPICE=$DIVIDER_DIR/simulations/pdiv_sym_tb.spice
DATA_DIR=$DIVIDER_DIR/results/data
RESULTS_DIR=$DIVIDER_DIR/results

# Simulation parameters
# Timestep: 20ps for good accuracy on small signals
TSTEP="20p"

# N range: 0-63 (N=0 is bypass mode: output frequency = clk / 2)
# Code 111111 (N=63, all data bits high) is intentionally excluded — not simulated.
N_VALUES=$(seq 0 63 | grep -v '^63$')

# ── Function to calculate RESET_TIME / RESET_END / TSTOP ──────────────────────
# out_div frequency = 320 MHz / (2 * (N+1))
# Period of out_div = 2 * (N+1) / 320 MHz = (N+1) / 160 MHz
#
# RESET_TIME  = 0.75 * period_out_div(N)   — reset asserted for ~75% of one
#               out_div period at this division value
# RESET_END   = RESET_TIME + 100ps         — short, fixed fall-transition width
# TSTOP       = RESET_END + 10 * period_out_div(N) — 10 full periods measured
#               strictly AFTER reset has released
#
# Prints three lines: RESET_TIME, RESET_END, TSTOP (ngspice time strings)
calculate_timing() {
    local N=$1
    python3 << PYEOF
N = int($N)

# out_div period in seconds for this N (see header note above)
period_out_div = (N + 1) / 160e6

# Reset asserted for ~75% of this N's out_div period
reset_time_sec = 0.75 * period_out_div
# Fixed, short transition width for the reset falling edge
reset_end_sec = reset_time_sec + 100e-12

# 10 full out_div periods to measure, counted from AFTER reset releases
tstop_sec = reset_end_sec + 10 * period_out_div

def fmt(t):
    # Format as an ngspice time string (e.g., "1.5u", "100n", "250p")
    if t >= 1e-6:
        return f"{t*1e6:.4f}u"
    elif t >= 1e-9:
        return f"{t*1e9:.4f}n"
    else:
        return f"{t*1e12:.4f}p"

print(fmt(reset_time_sec))
print(fmt(reset_end_sec))
print(fmt(tstop_sec))
PYEOF
}

echo "=========================================================================="
echo "PROGRAMMABLE DIVIDER SWEEP (OPTIMIZED)"
echo "=========================================================================="
echo "Corners     : $corners"
echo "Temperatures: $FILTER_TEMPS"
echo "VDDs        : $FILTER_VPS"
echo "Division N  : 0..63, excluding 63 (111111) — 63 runs per PVT point, includes bypass mode N=0"
echo "Per-run time: DYNAMIC (reset ~75% of out_div period, then 10 periods of out_div)"
echo "Timestep    : $TSTEP"
echo "Measurement : out_div (NOT out, which has very short pulses)"
echo "Reset       : held from t=0, released before the 10-period measurement window"
echo ""

# Count total simulations
TOTAL=0
for CORNER in $corners; do
for TEMP in $FILTER_TEMPS; do
for VP in $FILTER_VPS; do
    for N in $N_VALUES; do TOTAL=$((TOTAL + 1)); done
done; done; done

echo "Total simulations: $TOTAL (includes bypass mode N=0, excludes code 111111/N=63)"
echo "=========================================================================="
echo ""

mkdir -p $DATA_DIR

# Remove previous results only for the PVT points we are about to (re)run
for CORNER in $corners; do
for TEMP in $FILTER_TEMPS; do
for VP in $FILTER_VPS; do
    TAG="${CORNER}_T${TEMP}_Vp${VP}"
    rm -f $DATA_DIR/${SIM_NAME}_${TAG}_N*.dat
done; done; done
rm -f $RESULTS_DIR/${SIM_NAME}_report.html

CURRENT=0

for CORNER in $corners; do
for TEMP in $FILTER_TEMPS; do
for VP in $FILTER_VPS; do

    TAG="${CORNER}_T${TEMP}_Vp${VP}"
    echo "=== PVT: $TAG ==="

    for N in $N_VALUES; do
        NN=$(printf "%02d" $N)
        DAT=$DATA_DIR/${SIM_NAME}_${TAG}_N${NN}.dat

        # Calculate dynamic RESET_TIME / RESET_END / TSTOP for this N value
        TIMING=$(calculate_timing $N)
        RESET_TIME=$(sed -n '1p' <<< "$TIMING")
        RESET_END=$(sed -n '2p' <<< "$TIMING")
        TSTOP=$(sed -n '3p' <<< "$TIMING")

        # Extract data bits from N (0-63)
        D0=$(( (N >> 0) & 1 ))
        D1=$(( (N >> 1) & 1 ))
        D2=$(( (N >> 2) & 1 ))
        D3=$(( (N >> 3) & 1 ))
        D4=$(( (N >> 4) & 1 ))
        D5=$(( (N >> 5) & 1 ))

        # Generate SPICE netlist with DC-biased data inputs
        python3 - "$SPICE" "$CORNER" "$TEMP" "$VP" "$DAT" \
                   "$D0" "$D1" "$D2" "$D3" "$D4" "$D5" \
                   "$TSTEP" "$TSTOP" "$VP" "$RESET_TIME" "$RESET_END" <<'PYEOF'
import re, sys

(spice_path, corner, temp, vp, dat_path,
 d0_str, d1_str, d2_str, d3_str, d4_str, d5_str,
 tstep, tstop, vdd_str, reset_time, reset_end) = sys.argv[1:]

with open(spice_path) as f:
    spice = f.read()

# 1. Remove existing .control block
spice = re.sub(r'\.control.*?\.endc', '', spice, flags=re.DOTALL)

# 2. Replace temperature parameter
spice = re.sub(r'\.param\s+temp\s*=.*', f'.param temp={temp}', spice, flags=re.IGNORECASE)
# This netlist has no ".param vdd=" line — V1 drives VP directly with a fixed
# 1.2V literal ("V1 VP 0 1.2"). If a future testbench reintroduces a vdd
# param, this substitution still applies harmlessly (no match = no-op).
spice = re.sub(r'\.param\s+vdd\s*=.*',  f'.param vdd={vp}',    spice, flags=re.IGNORECASE)

# 3. Select corner from library
spice = re.sub(r'(\.lib\s+\S*cornerMOSlv\.lib\s+)\S+',
               r'\g<1>' + corner, spice, flags=re.IGNORECASE)

# 4. Remove existing .options TEMP
spice = re.sub(r'\.options[^\n]*\bTEMP\b[^\n]*\n', '', spice, flags=re.IGNORECASE)

# 5. Convert vdd to float for DC source values
vdd_v = float(vdd_str)
def dc_level(bit_val):
    return f"{vdd_v:.4f}" if int(bit_val) else "0"

# 6. Replace data input sources with DC levels
#    These patterns match voltage source definitions for the data bits.
#    If your testbench uses different source names, modify these patterns.
#    Example: change V11 to whatever your d0 source is named in pdiv_sym_tb.spice
#
#    The pattern matches: SourceName  node+  node-  [definition]
#    Then replaces the definition part with DC <value>

replacements = [
    # Match voltage sources with numeric ground (0) — exact node names
    (r'(V11\s+d0\s+0)\s+.*', lambda: f'\\1 DC {dc_level(d0_str)}'),
    (r'(V10\s+d1\s+0)\s+.*', lambda: f'\\1 DC {dc_level(d1_str)}'),
    (r'(V12\s+d2\s+0)\s+.*', lambda: f'\\1 DC {dc_level(d2_str)}'),
    (r'(V7\s+d3\s+0)\s+.*',  lambda: f'\\1 DC {dc_level(d3_str)}'),
    (r'(V8\s+d4\s+0)\s+.*',  lambda: f'\\1 DC {dc_level(d4_str)}'),
    (r'(V9\s+d5\s+0)\s+.*',  lambda: f'\\1 DC {dc_level(d5_str)}'),
    # V1 drives VP directly (e.g. "V1 VP 0 1.2") — tie it to the swept VDD
    # instead of the netlist's hardcoded literal, so -v corner sweeps work.
    (r'(V1\s+VP\s+0)\s+.*', lambda: f'\\1 {vdd_v:.4f}'),
    # V4 drives reset as a PWL source (e.g. "V4 reset 0 PWL( 0 1.2 500n 1.2 500.1n 0)").
    # Rebuild it: reset asserted (at VDD) from t=0 to reset_time, falls to 0
    # by reset_end. reset_time/reset_end are pre-computed per N (~75% of the
    # out_div period) and passed in from the bash driver.
    (r'(V4\s+reset\s+0\s+PWL\()[^)]*(\))',
     lambda: f'\\g<1> 0 {vdd_v:.4f} {reset_time} {vdd_v:.4f} {reset_end} 0\\g<2>'),
]

for pattern, replacement in replacements:
    spice = re.sub(pattern, replacement(), spice, flags=re.IGNORECASE)

# 7. Add .options TEMP
spice = re.sub(r'(\.end\b)', f'.options TEMP={temp}\n\\1', spice, flags=re.IGNORECASE)

# 8. Create .control block with measurement from out_div (not out).
#    tran's optional 4th argument (tstart) tells ngspice to only start
#    WRITING data at reset_end — the simulator still runs from t=0, but the
#    reset transient itself is excluded from the .dat file, so it can't
#    skew any downstream duty-cycle/frequency calculation.
control_block = f"""
.control
save all
tran {tstep} {tstop} {reset_end}
wrdata {dat_path} v(clk) v(out_div) v(div2) v(div4) v(div8) v(div16) v(div32) v(div64)
exit
.endc
"""

with open('/tmp/pdiv_run.spice', 'w') as f:
    f.write(spice + control_block)

PYEOF

        # Run ngspice
        ngspice -b /tmp/pdiv_run.spice >/dev/null 2>&1

        CURRENT=$((CURRENT + 1))
        PCT=$(( CURRENT * 100 / TOTAL ))
        printf "  N=%02d (d5..d0=%d%d%d%d%d%d) RESET=0-%s TSTOP=%s — %3d%% total\n" \
               $N $D5 $D4 $D3 $D2 $D1 $D0 "$RESET_END" "$TSTOP" $PCT

    done  # N loop

done
done
done  # PVT loops

echo ""
echo "=========================================================================="
echo "All simulations done. Generating report..."
echo "=========================================================================="
python3 $SCRIPT_DIR/plot_divider_pdiv_optimized.py
