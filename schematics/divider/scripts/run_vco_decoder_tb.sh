#!/bin/bash
# ==============================================================================
# VCO DECODER — functional check across all 512 codes, swept over corner/temp/VDD
# ==============================================================================
# VCO_decoder_tb.sch drives c0,c1,c2 (coarse select) and f0-f5 (fine select)
# with PULSE sources whose periods are binary-weighted powers of two
# (f0=3.125n, f1=6.25n, f2=12.5n, f3=25n, f4=50n, f5=100n, c0=200n, c1=400n,
# c2=800n). Together these 9 sources behave exactly like a free-running
# 9-bit binary counter with a 1.5625ns "tick":
#
#     code(t) = floor(t / 1.5625ns) mod 512        (bit0=f0 ... bit8=c2)
#     coarse  = code >> 6      (c0,c1,c2 -> 0..7)
#     fine    = code & 0x3F    (f0..f5   -> 0..63)
#
# so a SINGLE 801ns transient already exercises all 512 (coarse,fine)
# combinations once each — unlike the pdiv testbench, no per-code looping
# is required here. What IS worth sweeping is corner/temp/VDD, since decoder
# propagation delay eating into the 1.5625ns dwell window is a real functional
# risk at slow/cold/low-VDD corners, even though the logic itself is static.
#
# KNOWN SCHEMATIC ISSUE (see header comment in the .py companion script too):
# port p15 (net 130,520) on the VCO_decoder symbol instance is labeled
# "VCO2_11_sel", identical to port p4 (net 130,400). xschem will tie both
# pins to the same node. This is almost certainly meant to be "VCO5_11_sel"
# (the golden table has a distinct Vco5-11 entry). Until the .sch is fixed,
# VCO5-11 codes cannot be independently verified — the report flags this.
#
# NOTE: like run_sweep_pdiv_optimized.sh, this script consumes an ALREADY
# NETLISTED .spice file — it does not invoke xschem itself. Netlist
# VCO_decoder_tb.sch to VCO_decoder_tb.spice yourself (xschem batch mode,
# or File > Netlist) and drop it in simulations/, or point at it directly
# with --spice <path>.
#
# File naming: vcodec_<corner>_T<temp>_Vp<vp>.dat
#
# Place in vco_decoder/scripts/ and run from there (mirrors divider/scripts/).
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Expected hierarchy (mirrors the divider testbench layout):
#   SCRIPT_DIR    -> .../CHIP-PLL/schematics/vco_decoder/scripts
#   DECODER_DIR   -> .../CHIP-PLL/schematics/vco_decoder        (1 level up)
#   ROOT_DIR      -> .../CHIP-PLL                                (3 levels up)
DECODER_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
ROOT_DIR="$(cd "$DECODER_DIR/../.." && pwd)"

source $ROOT_DIR/configs/corner_data

# ── Argument parsing (same -c/-t/-v convention as run_sweep_pdiv_optimized.sh) ─
FILTER_CORNERS=""
FILTER_TEMPS=""
FILTER_VPS=""
SPICE_OVERRIDE=""

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
                    typ)  FILTER_CORNERS="$FILTER_CORNERS mos_tt"; FILTER_TEMPS="$FILTER_TEMPS $t_nom"; FILTER_VPS="$FILTER_VPS $vp_nom" ;;
                    hot)  FILTER_CORNERS="$FILTER_CORNERS mos_ff"; FILTER_TEMPS="$FILTER_TEMPS $t_min"; FILTER_VPS="$FILTER_VPS $vp_min" ;;
                    cold) FILTER_CORNERS="$FILTER_CORNERS mos_ff"; FILTER_TEMPS="$FILTER_TEMPS $t_nom"; FILTER_VPS="$FILTER_VPS $vp_max" ;;
                    *)    FILTER_CORNERS="$FILTER_CORNERS $1" ;;
                esac
                shift
            done
            ;;
        -t)
            shift
            [[ $# -eq 0 || "$1" == -* ]] && { echo "Error: -t requires a value"; exit 1; }
            while [[ $# -gt 0 && "$1" != -* ]]; do FILTER_TEMPS="$FILTER_TEMPS $(resolve_var "$1")"; shift; done
            ;;
        -v)
            shift
            [[ $# -eq 0 || "$1" == -* ]] && { echo "Error: -v requires a value"; exit 1; }
            while [[ $# -gt 0 && "$1" != -* ]]; do FILTER_VPS="$FILTER_VPS $(resolve_var "$1")"; shift; done
            ;;
        --spice)
            shift
            [[ $# -eq 0 ]] && { echo "Error: --spice requires a path"; exit 1; }
            SPICE_OVERRIDE="$1"
            shift
            ;;
        -h|--help)
            sed -n '/^# ===/,/^# ===/p' "$0" | sed 's/^# \?//' | head -40
            echo "Extra option: --spice <path>   override path to the netlisted VCO_decoder_tb.spice"
            exit 0
            ;;
        *)
            echo "Error: unknown option '$1'"
            echo "Run with -h for usage."
            exit 1
            ;;
    esac
done

dedup() { echo "$1" | tr ' ' '\n' | grep -v '^$' | awk '!seen[$0]++' | tr '\n' ' '; }
FILTER_CORNERS=$(dedup "$FILTER_CORNERS")
FILTER_TEMPS=$(dedup "$FILTER_TEMPS")
FILTER_VPS=$(dedup "$FILTER_VPS")

if [[ -z "$FILTER_TEMPS" ]]; then FILTER_TEMPS="$t_min $t_nom $t_max"; fi
if [[ -z "$FILTER_VPS"   ]]; then FILTER_VPS="$vp_min $vp_nom $vp_max"; fi

if [[ -n "$FILTER_CORNERS" ]]; then
    filtered=""
    for C in $corners; do
        for F in $FILTER_CORNERS; do
            if [[ "$C" == *"$F"* ]]; then filtered="$filtered $C"; break; fi
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
SIM_NAME="vcodec"
NETLIST="${SPICE_OVERRIDE:-$DECODER_DIR/simulations/VCO_decoder_tb.spice}"
DATA_DIR=$DECODER_DIR/results/data
RESULTS_DIR=$DECODER_DIR/results

TSTEP="50p"
TSTOP="801n"     # 512 codes * 1.5625ns tick + margin

# ── Load an already-netlisted .spice file (same convention as
#    run_sweep_pdiv_optimized.sh / pdiv_sym_tb.spice — no xschem call here) ────
if [[ ! -f "$NETLIST" ]]; then
    echo "Error: netlist not found: $NETLIST"
    echo "Netlist VCO_decoder_tb.sch to VCO_decoder_tb.spice first (xschem batch"
    echo "mode or File > Netlist), or point at it with --spice <path>."
    exit 1
fi

# ── Sanity-check the known duplicate-net-name issue (see header) ──────────────
DUP_COUNT=$(grep -c 'VCO2_11_sel' "$NETLIST")
if grep -q 'VCO5_11_sel' "$NETLIST"; then
    HAS_VCO5_NET=1
else
    HAS_VCO5_NET=0
fi
if [[ "$HAS_VCO5_NET" -eq 0 ]]; then
    echo "WARNING: no 'VCO5_11_sel' net found in the netlist — the schematic's"
    echo "         second 'VCO2_11_sel'-labeled port (p15) is shorted onto the"
    echo "         real VCO2_11_sel net. Vco5-11 codes cannot be verified"
    echo "         independently until the .sch label is fixed. Continuing —"
    echo "         the report will mark those codes as UNTESTABLE."
fi

echo "=========================================================================="
echo "VCO DECODER FUNCTIONAL CHECK (all 512 codes per PVT point, single run each)"
echo "=========================================================================="
echo "Corners     : $corners"
echo "Temperatures: $FILTER_TEMPS"
echo "VDDs        : $FILTER_VPS"
echo "Timestep    : $TSTEP   TSTOP: $TSTOP"
echo ""

TOTAL=0
for CORNER in $corners; do for TEMP in $FILTER_TEMPS; do for VP in $FILTER_VPS; do TOTAL=$((TOTAL+1)); done; done; done
echo "Total simulations: $TOTAL (1 run per PVT point covers all 512 codes)"
echo "=========================================================================="
echo ""

mkdir -p $DATA_DIR
rm -f $DATA_DIR/${SIM_NAME}_*.dat
rm -f $RESULTS_DIR/${SIM_NAME}_report.html

CURRENT=0

for CORNER in $corners; do
for TEMP in $FILTER_TEMPS; do
for VP in $FILTER_VPS; do

    TAG="${CORNER}_T${TEMP}_Vp${VP}"
    DAT=$DATA_DIR/${SIM_NAME}_${TAG}.dat

    python3 - "$NETLIST" "$CORNER" "$TEMP" "$VP" "$DAT" "$TSTEP" "$TSTOP" "$HAS_VCO5_NET" <<'PYEOF'
import re, sys

(netlist_path, corner, temp, vp, dat_path, tstep, tstop, has_vco5) = sys.argv[1:]
has_vco5 = (has_vco5 == "1")

with open(netlist_path) as f:
    spice = f.read()

# 1. Remove existing .control block (the xschem-netlisted one from the .sch)
spice = re.sub(r'\.control.*?\.endc', '', spice, flags=re.DOTALL)

# 2. Corner / temp / vdd
spice = re.sub(r'\.param\s+temp\s*=.*', f'.param temp={temp}', spice, flags=re.IGNORECASE)
spice = re.sub(r'\.param\s+vdd\s*=.*',  f'.param vdd={vp}',    spice, flags=re.IGNORECASE)
spice = re.sub(r'(\.lib\s+\S*cornerMOSlv\.lib\s+)\S+', r'\g<1>' + corner, spice, flags=re.IGNORECASE)

# 3. Remove any pre-existing .options TEMP, then re-add
spice = re.sub(r'\.options[^\n]*\bTEMP\b[^\n]*\n', '', spice, flags=re.IGNORECASE)
spice = re.sub(r'(\.end\b)', f'.options TEMP={temp}\n\\1', spice, flags=re.IGNORECASE)

# 4. Rebuild the .control block: single transient, wrdata all decoder I/O.
#    Inputs (c0,c1,c2,f0..f5) are saved too so the analysis script can
#    cross-check the reconstructed code against the actual bit values
#    instead of only trusting the nominal PULSE timing.
sigs = ['c0', 'c1', 'c2', 'f0', 'f1', 'f2', 'f3', 'f4', 'f5',
        'VCO_sel', 'VCO2_5_sel', 'VCO2_11_sel',
        'VCO3_5_sel', 'VCO3_11_sel', 'VCO4_5_sel', 'VCO4_11_sel']
if has_vco5:
    sigs.append('VCO5_11_sel')

wrdata_sigs = ' '.join(f'v({s})' for s in sigs)

control_block = f"""
.control
save all
tran {tstep} {tstop}
wrdata {dat_path} {wrdata_sigs}
exit
.endc
"""

with open('/tmp/vcodec_run.spice', 'w') as f:
    f.write(spice + control_block)

# stash the signal order next to the .dat file so the python report
# generator doesn't have to guess it
with open(dat_path + '.siglist', 'w') as f:
    f.write(' '.join(sigs))
PYEOF

    ngspice -b /tmp/vcodec_run.spice >/tmp/vcodec_${TAG}.log 2>&1
    if [[ ! -s "$DAT" ]]; then
        echo "  [$TAG] FAILED — see /tmp/vcodec_${TAG}.log"
    else
        CURRENT=$((CURRENT+1))
        PCT=$(( CURRENT * 100 / TOTAL ))
        echo "  [$TAG] done — ${PCT}% total"
    fi

done
done
done

echo ""
echo "=========================================================================="
echo "All simulations done. Generating report..."
echo "=========================================================================="
python3 $SCRIPT_DIR/plot_vco_decoder.py
