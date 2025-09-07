# 📡 OFDM Simulation in MATLAB

This project demonstrates an **Orthogonal Frequency Division Multiplexing (OFDM)** system using MATLAB.  
It simulates an OFDM communication system with **QAM modulation**, **Rayleigh fading channel**, **AWGN noise**, and **channel equalization**.  
The system performance is evaluated using **Bit Error Rate (BER) vs SNR** for different QAM modulation orders.

---

## 🚀 Features
- Supports **4-QAM, 16-QAM, 64-QAM** modulation schemes
- Implements **OFDM modulation** using IFFT/FFT with **Cyclic Prefix**
- Simulates **Rayleigh fading + AWGN channel**
- Performs **channel estimation and equalization**
- Plots **BER vs SNR** for comparison
- Visualizes **constellation diagrams**
- Exports **results to CSV** for further analysis
- Saves **plots as images** in `docs/` folder for documentation

---

## 📂 Project Structure
OFDM-Simulation/
├── ofdm_simulation.m # Main MATLAB script
├── README.md # Project documentation
├── results/ # BER results in CSV
│ └── ber_results.csv
├── docs/ # Plots and screenshots
│ ├── ber_plot.png
│ └── constellation.png
