# 📡 OFDM Simulation in MATLAB

This project demonstrates an **Orthogonal Frequency Division Multiplexing (OFDM)** system using MATLAB.  
It includes QAM modulation, Rayleigh fading channel, AWGN noise, and channel equalization.  
Performance is measured in terms of **Bit Error Rate (BER) vs SNR** for different modulation schemes.

---

## 🚀 Features
- Supports **4-QAM, 16-QAM, 64-QAM**.
- OFDM with IFFT/FFT and **Cyclic Prefix**.
- **Rayleigh fading + AWGN channel**.
- **Channel estimation and equalization**.
- BER vs SNR comparison.
- Constellation diagram visualization.
- Exports results to `.csv` for further analysis.
- Saves plots and results inside `docs/` and `results/`.

---

## 📂 Project Structure
OFDM-Simulation/
|-- ofdm_simulation.m       # Main MATLAB script
|-- README.md               # Project documentation
|-- results/                # BER results in CSV
|   `-- ber_results.csv
|-- docs/                   # Plots and screenshots
|   |-- ber_plot.png
|   `-- constellation.png
