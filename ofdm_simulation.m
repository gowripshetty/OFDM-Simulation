% ====================================================
% OFDM Simulation in MATLAB
% Author: Your Name
% Description: OFDM system with QAM modulation,
%              AWGN + Rayleigh channel,
%              Channel estimation + Equalization,
%              BER vs SNR comparison
% ====================================================

clc; clear; close all;

%% Parameters
Nsubcarriers = 64;       % Number of subcarriers
Nsymbols = 1000;         % Number of OFDM symbols
cp_len = 16;             % Cyclic prefix length
M_values = [4 16 64];    % QAM modulation orders
SNRdB = 0:5:30;          % SNR range

%% BER storage
BER = zeros(length(M_values), length(SNRdB));

%% Loop over modulation orders
for mi = 1:length(M_values)
    M = M_values(mi);    % Current modulation order
    k = log2(M);         % Bits per symbol
    
    for si = 1:length(SNRdB)
        snr = SNRdB(si);
        nBits = Nsymbols * Nsubcarriers * k;
        
        % Generate random bits
        bits = randi([0 1], nBits, 1);
        
        % QAM Modulation
        symbols = qammod(bi2de(reshape(bits, k, []).'), M, ...
                         'UnitAveragePower', true);
                     
        % Serial to parallel (group into OFDM symbols)
        symbols_matrix = reshape(symbols, Nsubcarriers, []);
        
        % IFFT (OFDM modulation)
        tx_ifft = ifft(symbols_matrix, Nsubcarriers);
        
        % Add Cyclic Prefix
        tx_cp = [tx_ifft(end-cp_len+1:end,:); tx_ifft];
        
        % Serialize
        tx_signal = tx_cp(:);
        
        % Channel (Rayleigh fading + AWGN)
        h = (randn(1,Nsubcarriers) + 1i*randn(1,Nsubcarriers))/sqrt(2);
        rx_signal = filter(h,1,tx_signal);
        rx_signal = awgn(rx_signal, snr, 'measured');
        
        % Reshape back into symbols
        rx_cp_matrix = reshape(rx_signal, Nsubcarriers+cp_len, []);
        
        % Remove CP
        rx_matrix = rx_cp_matrix(cp_len+1:end, :);
        
        % FFT
        rx_fft = fft(rx_matrix, Nsubcarriers);
        
        % Channel Estimation (simple: assume known h)
        H = fft(h, Nsubcarriers).';
        rx_eq = rx_fft ./ H;
        
        % Parallel to serial
        rx_symbols = rx_eq(:);
        
        % QAM Demodulation
        rx_bits = de2bi(qamdemod(rx_symbols, M, ...
                        'UnitAveragePower', true), k);
        rx_bits = rx_bits.';
        rx_bits = rx_bits(:);
        
        % BER calculation
        BER(mi, si) = mean(bits ~= rx_bits);
    end
end

%% Plot BER vs SNR
figure;
semilogy(SNRdB, BER(1,:), '-o', 'LineWidth', 2); hold on;
semilogy(SNRdB, BER(2,:), '-s', 'LineWidth', 2);
semilogy(SNRdB, BER(3,:), '-d', 'LineWidth', 2);
grid on; xlabel('SNR (dB)'); ylabel('BER');
legend('4-QAM','16-QAM','64-QAM');
title('OFDM BER Performance with QAM');

%% Plot Constellation (example: 16-QAM)
M = 16;
scatterplot(qammod(0:M-1,M,'UnitAveragePower',true));
title('16-QAM Constellation');

%% Save Results to CSV
% Define your project folder
outputFolder = 'D:\projects\OFDM simulation';

% Create results folder if not exists
resultsFolder = fullfile(outputFolder, 'results');
if ~exist(resultsFolder, 'dir')
    mkdir(resultsFolder);
end

% Save CSV
csvwrite(fullfile(resultsFolder, 'ber_results.csv'), [[SNRdB]', BER.']);
disp(['Results saved to: ' fullfile(resultsFolder, 'ber_results.csv')]);


