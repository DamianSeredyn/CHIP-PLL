import numpy as np
import matplotlib.pyplot as plt

data = []
with open('/foss/designs/CHIP-PLL/PFD/simulations/pfd_linearity.txt') as f:
    next(f)
    for line in f:
        parts = line.strip().split()
        if len(parts) == 3:
            dly_str, pw_up, pw_down = parts
            dly = float(dly_str.replace('u','e-6'))
            data.append((dly, float(pw_up), float(pw_down)))

data = np.array(data)
dly   = data[:,0]
pw_up = data[:,1]
pw_dn = data[:,2]
delta = pw_up - pw_dn

T = 31.25e-6
phi_deg = (dly / T - 0.5) * 360

idx = np.argsort(phi_deg)
phi_deg = phi_deg[idx]
delta   = delta[idx]
pw_up   = pw_up[idx]
pw_dn   = pw_dn[idx]

phi_ideal = np.linspace(-180, 180, 1000)
scale = np.max(np.abs(delta[np.abs(phi_deg) < 170]))
delta_ideal = phi_ideal / 180.0 * scale
delta_ideal_at_sim = phi_deg / 180.0 * scale

error = delta - delta_ideal_at_sim
error_pct = error / scale * 100

mask = np.abs(phi_deg) < 175
phi_clean   = phi_deg[mask]
error_clean = error[mask]

fig = plt.figure(figsize=(14, 10))

ax1 = fig.add_subplot(2, 2, 1)
ax1.plot(phi_deg, delta*1000, 'o-', color='royalblue',
         linewidth=2, markersize=4, label='PFD symulacja')
ax1.plot(phi_ideal, delta_ideal*1000, '--', color='tomato',
         linewidth=1.5, label='Idealna PFD')
ax1.axhline(0, color='gray', linewidth=0.8, linestyle=':')
ax1.axvline(0, color='gray', linewidth=0.8, linestyle=':')
ax1.set_xlabel('Roznica faz [deg]')
ax1.set_ylabel('UP - DOWN [mV avg]')
ax1.set_title('Charakterystyka liniowosci PFD')
ax1.set_xticks(range(-180, 181, 45))
ax1.legend()
ax1.grid(True, alpha=0.3)

ax2 = fig.add_subplot(2, 2, 2)
ax2.plot(phi_deg, pw_up*1000, 'o-', color='green',
         linewidth=2, markersize=4, label='avg UP')
ax2.plot(phi_deg, pw_dn*1000, 's-', color='orange',
         linewidth=2, markersize=4, label='avg DOWN')
ax2.axvline(0, color='gray', linewidth=0.8, linestyle=':')
ax2.set_xlabel('Roznica faz [deg]')
ax2.set_ylabel('Srednie napiecie [mV]')
ax2.set_title('Srednie napiecie UP i DOWN vs faza')
ax2.set_xticks(range(-180, 181, 45))
ax2.legend()
ax2.grid(True, alpha=0.3)

ax3 = fig.add_subplot(2, 2, 3)
ax3.plot(phi_clean, error_clean*1000, 'o-', color='purple',
         linewidth=2, markersize=4, label='Blad')
ax3.axhline(0, color='gray', linewidth=0.8, linestyle=':')
ax3.axvline(0, color='gray', linewidth=0.8, linestyle=':')
ax3.fill_between(phi_clean, error_clean*1000, 0, alpha=0.2, color='purple')
ax3.set_xlabel('Roznica faz [deg]')
ax3.set_ylabel('Blad [mV avg]')
ax3.set_title('Blad wzgledem idealnej charakterystyki')
ax3.set_xticks(range(-180, 181, 45))
ax3.legend()
ax3.grid(True, alpha=0.3)

ax4 = fig.add_subplot(2, 2, 4)
ax4.axis('off')

rows = [
    ['Max delta [mV]',    f'{np.max(delta)*1000:.3f}'],
    ['Min delta [mV]',    f'{np.min(delta)*1000:.3f}'],
    ['Max blad [mV]',     f'{np.max(error_clean)*1000:.3f}'],
    ['Min blad [mV]',     f'{np.min(error_clean)*1000:.3f}'],
    ['Avg blad [mV]',     f'{np.mean(error_clean)*1000:.3f}'],
    ['Max blad [%]',      f'{np.max(np.abs(error_clean/scale*100)):.2f}'],
    ['RMS blad [mV]',     f'{np.sqrt(np.mean(error_clean**2))*1000:.3f}'],
    ['Zakres fazy [deg]', '-180 do +180'],
    ['T [us]',            f'{T*1e6:.2f}'],
    ['Liczba punktow',    f'{len(phi_deg)}'],
]

table = ax4.table(
    cellText=rows,
    colLabels=['Parametr', 'Wartosc'],
    cellLoc='center',
    loc='center',
    colWidths=[0.6, 0.4]
)
table.auto_set_font_size(False)
table.set_fontsize(10)
table.scale(1, 1.8)
ax4.set_title('Statystyki', pad=10)

plt.tight_layout()
plt.savefig('/foss/designs/CHIP-PLL/PFD/results/pfd_linearity.png', dpi=150)
plt.show()
print("Zapisano: pfd_linearity.png")
