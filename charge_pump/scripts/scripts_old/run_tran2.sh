#!/bin/bash
# run_corners.sh - Symulacja cornerów PVT dla charge pump
# Rejestruje: v(vout), i(v.x1.viup), i(v.x1.vidn), v(x1.biasn)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

SIM_DIR="$PROJECT_DIR/charge_pump/simulations"
NETLIST_SRC="$SIM_DIR/NEW_500n_tran_tb.spice"

DATA_DIR="$PROJECT_DIR/charge_pump/results/data"
LOG_DIR="$PROJECT_DIR/charge_pump/results/logs"
RESULTS_DIR="$PROJECT_DIR/charge_pump/results"

TMP_NETLIST="$SIM_DIR/temp_run_$$.spice"

# Parametry symulacji – na test ustaw tylko dwa cornera
corners="mos_tt mos_ss"
t_min="-25"
#t_nom="27"
#t_max="125"
vp_min="1.08"
#vp_nom="1.2"
#vp_max="1.32"

mkdir -p "$DATA_DIR" "$LOG_DIR" "$RESULTS_DIR"
rm -f "$DATA_DIR"/charge_pump_data_*.txt
rm -f "$RESULTS_DIR"/cp_*.png "$RESULTS_DIR"/cp_report.html

prepare_netlist() {
    local corner=$1
    local temp=$2
    local vp=$3
    local out=$4

    cp "$NETLIST_SRC" "$out"

    # 1. Usuń wszystkie istniejące bloki .control ... .endc (włączając wielokrotne)
    sed -i '/^\.control/,/^\.endc/d' "$out"

    # 2. Usuń wszelkie linie zawierające wrdata, write, set appendwrite
    sed -i '/wrdata/d; /write/d; /set appendwrite/d' "$out"

    # 3. Podmień parametry
    sed -i -e "s/\.param temp=.*/.param temp=$temp/" \
           -e "s/\.param Vp=.*/.param Vp=$vp/" "$out"

    # 4. Zmień corner w linii .lib
    sed -i -E "s/^(\.lib .*cornerMOSlv\.lib) [^ ]+$/\1 $corner/" "$out"

    # 5. Dopisz swój blok .control przed .ends (lub na końcu)
    if grep -q "^\.ends" "$out"; then
        sed -i "/^\.ends/i\\
**** begin user architecture code\\
.options temp=$temp\\
.control\\
op\\
tran 1n 80u\\
save all\\
set filetype=ascii\\
wrdata cp_test.txt time v(vout) i(v.x1.viup) i(v.x1.vidn) v(x1.biasn)\\
quit\\
.endc\\
**** end user architecture code" "$out"
    else
        cat >> "$out" <<EOF

**** begin user architecture code
.options temp=$temp
.control
op
tran 1n 80u
save all
set filetype=ascii
wrdata cp_test.txt time v(vout) i(v.x1.viup) i(v.x1.vidn) v(x1.biasn)
quit
.endc
**** end user architecture code
EOF
    fi
}

# Główna pętla
for CORNER in $corners; do
    for TEMP in $t_min $t_nom $t_max; do
        for VP in $vp_min $vp_nom $vp_max; do
            TAG="${CORNER}_T${TEMP}_Vp${VP}"
            OUT_FILE="$DATA_DIR/charge_pump_data_${TAG}.txt"
            LOG_FILE="$LOG_DIR/ngspice_${TAG}.log"

            echo "=== $TAG ==="
            prepare_netlist "$CORNER" "$TEMP" "$VP" "$TMP_NETLIST"

            (cd "$SIM_DIR" && ngspice -b "$(basename "$TMP_NETLIST")") > "$LOG_FILE" 2>&1

            if [ -f "$SIM_DIR/cp_test.txt" ]; then
                cp "$SIM_DIR/cp_test.txt" "$OUT_FILE"
                echo "  OK → $OUT_FILE"
                rm -f "$SIM_DIR/cp_test.txt"
            else
                echo "  BŁĄD: brak cp_test.txt. Log: $LOG_FILE"
                tail -20 "$LOG_FILE"
            fi
            rm -f "$TMP_NETLIST"
        done
    done
done

# Post-processing
if [ -f "$SCRIPT_DIR/parse_cp2.py" ]; then
    python3 "$SCRIPT_DIR/parse_cp2.py"
fi
if [ -f "$SCRIPT_DIR/plot_cp2.py" ]; then
    python3 "$SCRIPT_DIR/plot_cp2.py"
fi

echo "Gotowe. Raport HTML: $RESULTS_DIR/cp_report.html"
