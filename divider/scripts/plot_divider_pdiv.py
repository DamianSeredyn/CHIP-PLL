#!/usr/bin/env python3
# ==============================================================================
# PROGRAMMABLE DIVIDER (pdiv) — Analysis and HTML Report
# ==============================================================================
# Loads .dat files from ngspice simulations, computes frequency and duty cycle,
# verifies proper division operation, and generates an HTML report.
#
# Place in divider/scripts/ and run after simulations complete.
# ==============================================================================

import os
import sys
import re
import numpy as np
from pathlib import Path
from datetime import datetime

# ──────────────────────────────────────────────────────────────────────────────
# CONFIGURATION — adjust as needed
# ──────────────────────────────────────────────────────────────────────────────

DUTY_TARGET = 50.0      # Target duty cycle (%)
DUTY_TOL = 5.0          # Tolerance around target (%)
DIV_REL_TOL = 0.10      # Divider ratio tolerance (10%)
LAST_FRACTION = 0.5     # Use last 50% of simulation for analysis
VSWING_MIN = 0.40       # Minimum swing (as fraction of VDD) to count as real signal

# Order of signals in wrdata output — MUST MATCH run_sweep_pdiv.sh
SIGNAL_ORDER = ['clk', 'out', 'out_div', 'div2', 'div4', 'div8', 'div16', 'div32', 'div64']

# Expected division ratios for monitoring outputs
# out_div is /2 of the main divider output, so depends on programming value
# For now, we measure the actual ratios; adjust if you program fixed values
EXPECTED_RATIOS = {
    'clk':     1,      # reference
    'out':     None,   # programmable (will measure and report)
    'out_div': None,   # /2 of out (will be out_ratio * 2)
    'div2':    2,      # if measured
    'div4':    4,
    'div8':    8,
    'div16':   16,
    'div32':   32,
    'div64':   64,
}

# ──────────────────────────────────────────────────────────────────────────────

def parse_netlist(spice_path):
    """Extract simulation parameters from netlist."""
    params = {}
    if not os.path.exists(spice_path):
        return params
    try:
        with open(spice_path, 'r') as f:
            for line in f:
                m = re.match(r'\.param\s+(\w+)\s*=\s*(\S+)', line.strip(), re.IGNORECASE)
                if m:
                    key, val = m.groups()
                    try:
                        params[key.lower()] = float(val)
                    except:
                        params[key.lower()] = val
    except:
        pass
    return params

def load_dat(dat_path):
    """Load ngspice .dat output file."""
    if not os.path.exists(dat_path):
        return None, None
    
    try:
        with open(dat_path, 'r') as f:
            lines = f.readlines()
        
        # Skip header/metadata, find data start
        data_start = 0
        for i, line in enumerate(lines):
            if line.strip() and not line.startswith('Title') and not line.startswith('Date'):
                try:
                    float(line.split()[0])
                    data_start = i
                    break
                except:
                    continue
        
        # Parse time and voltage columns
        data = np.loadtxt(dat_path, skiprows=data_start)
        if data.size == 0:
            return None, None
        
        time = data[:, 0] if data.ndim > 1 else data
        signals = data[:, 1:] if data.ndim > 1 else None
        
        return time, signals
    except Exception as e:
        print(f"Error loading {dat_path}: {e}", file=sys.stderr)
        return None, None

def analyze_signal(time, voltage, signal_name, vdd, ref_freq=None):
    """
    Analyze a signal: compute frequency and duty cycle.
    
    Returns: {
        'frequency': float or None,
        'duty_cycle': float or None,
        'measured_ratio': float or None (relative to reference),
        'swing': float (max - min of voltage),
        'status': 'ok' or 'stuck',
    }
    """
    
    result = {
        'frequency': None,
        'duty_cycle': None,
        'measured_ratio': None,
        'swing': 0.0,
        'status': 'ok',
    }
    
    # Check signal swing — if too small, likely stuck
    v_min, v_max = np.min(voltage), np.max(voltage)
    swing = v_max - v_min
    result['swing'] = swing
    
    if swing < VSWING_MIN * vdd:
        result['status'] = 'stuck'
        return result
    
    # Find rising and falling edges (crossings of 50% amplitude)
    threshold = (v_max + v_min) / 2.0
    
    # Detect zero crossings with interpolation
    crossings = []
    for i in range(len(voltage) - 1):
        v1, v2 = voltage[i], voltage[i+1]
        t1, t2 = time[i], time[i+1]
        
        # Rising edge
        if v1 < threshold <= v2:
            t_cross = t1 + (t2 - t1) * (threshold - v1) / (v2 - v1)
            crossings.append(('rise', t_cross))
        # Falling edge
        elif v1 >= threshold > v2:
            t_cross = t1 + (t2 - t1) * (threshold - v1) / (v2 - v1)
            crossings.append(('fall', t_cross))
    
    if len(crossings) < 3:
        result['status'] = 'stuck'
        return result
    
    # Use last 50% of simulation for analysis (let circuit settle)
    t_start = LAST_FRACTION * time[-1]
    crossings = [(edge, t) for edge, t in crossings if t >= t_start]
    
    if len(crossings) < 2:
        result['status'] = 'stuck'
        return result
    
    # Compute period (average of consecutive rise-to-rise)
    rising_times = [t for edge, t in crossings if edge == 'rise']
    if len(rising_times) >= 2:
        periods = np.diff(rising_times)
        period = np.mean(periods)
        result['frequency'] = 1.0 / period if period > 0 else None
    
    # Compute duty cycle (average of high-time / period)
    if len(crossings) >= 4:
        duties = []
        i = 0
        while i + 2 < len(crossings):
            edge1, t1 = crossings[i]
            edge2, t2 = crossings[i+1]
            edge3, t3 = crossings[i+2]
            
            if edge1 == 'rise' and edge2 == 'fall' and edge3 == 'rise':
                high_time = t2 - t1
                period = t3 - t1
                if period > 0:
                    duty = 100.0 * high_time / period
                    duties.append(duty)
                i += 2
            else:
                i += 1
        
        if duties:
            result['duty_cycle'] = np.mean(duties)
    
    # Compute measured ratio vs reference frequency
    if ref_freq is not None and result['frequency'] is not None and result['frequency'] > 0:
        result['measured_ratio'] = ref_freq / result['frequency']
    
    return result

def check_pass_fail(analysis, expected_ratio=None):
    """
    Check if signal passes criteria:
    1. Measured ratio matches expected (if provided)
    2. Duty cycle within target ± tolerance
    """
    if analysis['status'] == 'stuck':
        return False, 'stuck'
    
    if analysis['frequency'] is None or analysis['duty_cycle'] is None:
        return False, 'no_signal'
    
    # Check duty cycle
    if analysis['duty_cycle'] is not None:
        duty_dev = abs(analysis['duty_cycle'] - DUTY_TARGET)
        if duty_dev > DUTY_TOL:
            return False, 'bad_duty'
    
    # Check divider ratio
    if expected_ratio is not None and analysis['measured_ratio'] is not None:
        ratio_error = abs(analysis['measured_ratio'] - expected_ratio) / expected_ratio
        if ratio_error > DIV_REL_TOL:
            return False, 'bad_ratio'
    
    return True, 'pass'

def generate_html_report(results_dict, output_path):
    """Generate HTML report from analysis results."""
    
    html = """<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Programmable Divider (pdiv) Analysis Report</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .header {
            background-color: #333;
            color: white;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .header h1 {
            margin: 0;
        }
        .timestamp {
            font-size: 0.9em;
            opacity: 0.8;
        }
        .summary-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
            background-color: white;
        }
        .summary-table th {
            background-color: #4CAF50;
            color: white;
            padding: 12px;
            text-align: left;
            font-weight: bold;
        }
        .summary-table td {
            padding: 10px 12px;
            border-bottom: 1px solid #ddd;
        }
        .summary-table tr:hover {
            background-color: #f9f9f9;
        }
        .pvt-panel {
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 20px;
        }
        .pvt-title {
            font-size: 1.2em;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
            padding-bottom: 10px;
            border-bottom: 2px solid #4CAF50;
        }
        .data-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.9em;
        }
        .data-table th {
            background-color: #e8e8e8;
            padding: 8px;
            text-align: left;
            border: 1px solid #bbb;
        }
        .data-table td {
            padding: 8px;
            border: 1px solid #ddd;
        }
        .data-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .pass {
            background-color: #c8e6c9;
            font-weight: bold;
            color: #2e7d32;
        }
        .fail {
            background-color: #ffcdd2;
            font-weight: bold;
            color: #c62828;
        }
        .warn {
            background-color: #fff3cd;
            color: #856404;
        }
        .duty-ok {
            background-color: #e8f5e9;
        }
        .duty-warn {
            background-color: #fff9c4;
        }
        .duty-fail {
            background-color: #ffebee;
        }
        .status-pass::before {
            content: "✓ ";
            font-weight: bold;
            color: green;
        }
        .status-fail::before {
            content: "✗ ";
            font-weight: bold;
            color: red;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Programmable Divider (pdiv) — PVT Analysis Report</h1>
        <p class="timestamp">Generated: """ + datetime.now().strftime("%Y-%m-%d %H:%M:%S") + """</p>
    </div>
"""
    
    # Summary table
    html += """    <h2>Summary by Corner</h2>
    <table class="summary-table">
        <tr>
            <th>Corner / Temperature / VDD</th>
            <th>f_clk (MHz)</th>
            <th>CLK Duty (%)</th>
            <th>out (MHz)</th>
            <th>out Duty (%)</th>
            <th>Measured Ratio</th>
            <th>Status</th>
        </tr>
"""
    
    # Group by corner
    corners_dict = {}
    for (corner, temp, vp), data in sorted(results_dict.items()):
        c_key = corner
        if c_key not in corners_dict:
            corners_dict[c_key] = []
        corners_dict[c_key].append((temp, vp, data))
    
    for corner, pvt_list in sorted(corners_dict.items()):
        for i, (temp, vp, data) in enumerate(sorted(pvt_list)):
            tag = f"{corner}_T{temp}_Vp{vp}"
            
            clk_data = data.get('clk', {})
            out_data = data.get('out', {})
            
            clk_freq = clk_data.get('frequency')
            clk_duty = clk_data.get('duty_cycle')
            out_freq = out_data.get('frequency')
            out_duty = out_data.get('duty_cycle')
            out_ratio = out_data.get('measured_ratio')
            
            clk_freq_str = f"{clk_freq:.2f}" if clk_freq is not None else "N/A"
            clk_duty_str = f"{clk_duty:.1f}" if clk_duty is not None else "N/A"
            out_freq_str = f"{out_freq:.2f}" if out_freq is not None else "N/A"
            out_duty_str = f"{out_duty:.1f}" if out_duty is not None else "N/A"
            out_ratio_str = f"{out_ratio:.3f}" if out_ratio is not None else "N/A"
            
            
            
            pass_fail, reason = check_pass_fail(out_data)
            status_class = 'pass' if pass_fail else 'fail'
            status_text = '✓ PASS' if pass_fail else '✗ FAIL'
            
            html += f"""        <tr>
            <td>{tag}</td>
            <td>{clk_freq_str}</td>
            <td>{clk_duty_str}</td>
            <td>{out_freq_str}</td>
            <td>{out_duty_str}</td>
            <td>{out_ratio_str}</td>
            <td class="{status_class}">{status_text}</td>
        </tr>
"""
    
    html += """    </table>
"""
    
    # Detailed PVT panels
    html += """    <h2>Detailed Results by Corner</h2>
"""
    
    for (corner, temp, vp), data in sorted(results_dict.items()):
        tag = f"{corner}_T{temp}_Vp{vp}"
        
        html += f"""    <div class="pvt-panel">
        <div class="pvt-title">PVT Condition: {tag}</div>
        <table class="data-table">
            <tr>
                <th>Signal</th>
                <th>Frequency (MHz)</th>
                <th>Duty Cycle (%)</th>
                <th>Measured Ratio</th>
                <th>Expected Ratio</th>
                <th>Swing (V)</th>
                <th>Status</th>
            </tr>
"""
        
        for signal_name in SIGNAL_ORDER:
            signal_data = data.get(signal_name, {})
            
            freq = signal_data.get('frequency')
            duty = signal_data.get('duty_cycle')
            ratio = signal_data.get('measured_ratio')
            swing = signal_data.get('swing', 0)
            status = signal_data.get('status', 'unknown')
            
            freq_str = f"{freq:.3f}" if freq is not None else "N/A"
            duty_str = f"{duty:.1f}" if duty is not None else "N/A"
            ratio_str = f"{ratio:.3f}" if ratio is not None else "N/A"
            
            # Expected ratio
            exp_ratio = EXPECTED_RATIOS.get(signal_name)
            if signal_name == 'out_div' and 'out' in data:
                out_ratio = data['out'].get('measured_ratio')
                if out_ratio is not None:
                    exp_ratio = out_ratio * 2  # out_div is /2
            exp_ratio_str = f"{exp_ratio:.1f}" if exp_ratio is not None else "—"
            
            # Pass/fail
            if status == 'stuck':
                row_class = 'fail'
                status_text = '✗ Stuck'
            elif freq is None:
                row_class = 'fail'
                status_text = '✗ No signal'
            else:
                pass_fail, reason = check_pass_fail(signal_data, exp_ratio)
                row_class = 'pass' if pass_fail else 'fail'
                status_text = '✓ Pass' if pass_fail else f'✗ {reason}'
            
            # Duty cycle highlight
            if duty is not None:
                duty_dev = abs(duty - DUTY_TARGET)
                if duty_dev <= DUTY_TOL:
                    duty_class = 'duty-ok'
                elif duty_dev <= DUTY_TOL + 5:
                    duty_class = 'duty-warn'
                else:
                    duty_class = 'duty-fail'
            else:
                duty_class = ''
            
            html += f"""            <tr>
                <td><b>{signal_name}</b></td>
                <td>{freq_str}</td>
                <td class="{duty_class}">{duty_str}</td>
                <td>{ratio_str}</td>
                <td>{exp_ratio_str}</td>
                <td>{swing:.3f}</td>
                <td class="{row_class}">{status_text}</td>
            </tr>
"""
        
        html += """        </table>
    </div>
"""
    
    html += """    <hr>
    <p style="font-size: 0.85em; color: #666;">
        <b>Pass Criteria:</b>
        (1) Duty cycle within 50% ± 5% (configurable)
        (2) Measured divider ratio matches expected within 10% (configurable)
    </p>
    <p style="font-size: 0.85em; color: #666;">
        <b>Signals:</b>
        clk = reference clock input;
        out = main programmable divider output;
        out_div = /2 output for 50% duty cycle;
        div2–div64 = intermediate/monitoring outputs (if present in testbench)
    </p>
</body>
</html>
"""
    
    with open(output_path, 'w') as f:
        f.write(html)

# ──────────────────────────────────────────────────────────────────────────────
# MAIN
# ──────────────────────────────────────────────────────────────────────────────

def main():
    project_dir = Path.cwd().parent.parent
    data_dir = project_dir / 'divider' / 'results' / 'data'
    spice_path = project_dir / 'divider' / 'simulations' / 'pdiv_sym_tb.spice'
    report_path = project_dir / 'divider' / 'results' / 'pdiv_report.html'
    
    if not data_dir.exists():
        print(f"Error: data directory not found: {data_dir}")
        sys.exit(1)
    
    # Parse netlist for parameters
    netlist_params = parse_netlist(str(spice_path))
    vdd_nominal = netlist_params.get('vdd', 1.8)
    
    # Find all .dat files
    dat_files = sorted(data_dir.glob('pdiv_*.dat'))
    if not dat_files:
        print(f"Error: no .dat files found in {data_dir}")
        sys.exit(1)
    
    results = {}
    
    for dat_path in dat_files:
        # Parse filename: pdiv_<corner>_T<temp>_Vp<vp>.dat
        match = re.match(r'pdiv_(.*?)_T(.*?)_Vp(.*?)\.dat', dat_path.name)
        if not match:
            continue
        
        corner, temp, vp = match.groups()
        print(f"Analyzing {dat_path.name}...", end=' ', flush=True)
        
        time, signals = load_dat(str(dat_path))
        if time is None or signals is None:
            print("SKIP (no data)")
            continue
        
        vdd = float(vp) if vp else vdd_nominal
        
        # Analyze each signal
        pvt_results = {}
        clk_freq = None
        
        for i, signal_name in enumerate(SIGNAL_ORDER):
            if i >= signals.shape[1]:
                print(f"WARN: signal {signal_name} (col {i}) not in data")
                continue
            
            voltage = signals[:, i]
            
            # Reference frequency from clock
            if signal_name == 'clk':
                analysis = analyze_signal(time, voltage, signal_name, vdd, ref_freq=None)
                clk_freq = analysis['frequency']
            else:
                analysis = analyze_signal(time, voltage, signal_name, vdd, ref_freq=clk_freq)
            
            pvt_results[signal_name] = analysis
        
        results[(corner, temp, vp)] = pvt_results
        print("OK")
    
    if not results:
        print("Error: no valid results to report")
        sys.exit(1)
    
    # Generate report
    print(f"Generating report: {report_path}")
    generate_html_report(results, str(report_path))
    print("Done!")

if __name__ == '__main__':
    main()
