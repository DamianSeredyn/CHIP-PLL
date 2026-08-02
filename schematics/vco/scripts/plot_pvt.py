import numpy as np
import matplotlib.pyplot as plt
from matplotlib.widgets import CheckButtons
import glob, os

files = sorted(glob.glob("/foss/designs/CHIP-PLL/simulations/pvt_results/*.dat"))

colors = {"tt": "black", "ff": "red", "ss": "blue", "fs": "green", "sf": "orange"}

fig, ax = plt.subplots(figsize=(13, 7))
plt.subplots_adjust(left=0.3)

lines = {}
labels = []

for f in files:
    label = os.path.basename(f).replace(".dat", "")
    corner = label.split("_")[0]
    try:
        data = np.loadtxt(f, skiprows=1)
        if data.ndim < 2 or data.shape[1] < 2:
            print(f"skip {label} — unexpected format")
            continue
        line, = ax.plot(data[:, 0] * 1e9,
                        data[:, 1],
                        label=label,
                        color=colors.get(corner, "gray"),
                        linewidth=0.8,
                        alpha=0.8,
                        visible=True)
        lines[label] = line
        labels.append(label)
    except Exception as e:
        print(f"skip {label}: {e}")

ax.set_xlabel("Time (ns)")
ax.set_ylabel("v(out_pb) [V]")
ax.set_title("VCO — PVT corners — v(out_pb)")
ax.grid(True, linewidth=0.3, alpha=0.5)

# checkbuttons panel on the left
check_ax = plt.axes([0.01, 0.05, 0.26, 0.9])
visibility = [True] * len(labels)
check = CheckButtons(check_ax, labels, visibility)

for lab, txt in zip(labels, check.labels):
    corner = lab.split("_")[0]
    txt.set_color(colors.get(corner, "gray"))
    txt.set_fontsize(6)

def toggle(label):
    lines[label].set_visible(not lines[label].get_visible())
    fig.canvas.draw_idle()

check.on_clicked(toggle)

plt.show()
