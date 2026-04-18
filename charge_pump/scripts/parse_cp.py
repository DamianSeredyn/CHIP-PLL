import numpy as np
import os
import glob

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_DIR = os.path.abspath(os.path.join(SCRIPT_DIR, "../.."))
DATA_DIR = os.path.join(PROJECT_DIR, "charge_pump/results/data")
for f in glob.glob(os.path.join(DATA_DIR, 'cp_parsed_*.txt')):
    os.remove(f)
print("Usunieto stare pliki.")

files = glob.glob(os.path.join(DATA_DIR, "charge_pump_data_*.txt"))

for filepath in files:
    tag = os.path.basename(filepath).replace("charge_pump_data_", "").replace(".txt", "")
    
    data = np.loadtxt(filepath)
    
    time  = data[:, 0]
    vout  = data[:, 3]
    i_vip = data[:, 5]
    i_vin = data[:, 7]
    v_bias_p = data[:, 9]
    v_bias_n = data[:, 11]
    
    out = np.column_stack([time, vout, i_vip, i_vin, v_bias_p, v_bias_n])
    
    out_path = os.path.join(DATA_DIR, f"cp_parsed_{tag}.txt")
    np.savetxt(out_path, out, header="time vout i_vip i_vin v_bias_p v_bias_n", comments="")
    
    print(f"Parsed: {tag}")

print("Done.")