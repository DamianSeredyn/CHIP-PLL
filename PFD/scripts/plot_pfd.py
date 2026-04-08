import numpy as np
import matplotlib.pyplot as plt

dly_vals, pw_up_vals, pw_down_vals, delta_vals = [], [], [], []

with open('/foss/designs/CHIP-PLL/PFD/simulations/pfd_linearity.txt') as f:
    lines = f.readlines()

i = 0
while i < len(lines):
    line = lines[i].strip()
    if '=' in line and 'pw_up' not in line and 'pw_down' not in line and 'delta' not in line:
        dly = float(line.split('=')[1].strip())
        pw_up   = float(lines[i+1].split('=')[1].strip())
        pw_down = float(lines[i+2].split('=')[1].strip())
        delta   = float(lines[i+3].split('=')[1].strip())
        dly_vals.append(dly)
        pw_up_vals.append(pw_up)
        pw_down_vals.append(pw_down)
        delta_vals.append(delta)
        i += 4
    else:
        i += 1

dly   = np.array(dly_vals)
pw_up = np.array(pw_up_vals)
pw_dn = np.array(pw_down_vals)
delta = np.array(delta_vals)

T = 31.25e-6
phi_deg = dly / T * 360

print("dly [us] | pw_up [ns] | pw_down [ns] | delta [ns]")
for i in range(len(dly)):
    print(f"{dly[i]*1e6:8.2f} | {pw_up[i]*1e9:10.2f} | {pw_dn[i]*1e9:12.2f} | {delta[i]*1e9:10.2f}")
