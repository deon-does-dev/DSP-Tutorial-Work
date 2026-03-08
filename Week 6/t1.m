fs = 44100; % Sampling frequency

% Generate a single sinusoid and a sum of sinusoids
[sig1, ~] = generate_sinusoid(fs, 1, 1000, 0, 0.1);
[sig2, ~] = generate_sinusoid(fs, 0.5, 5000, pi/4, 0.1);
sig_sum = sig1 + sig2;

% Plot the single sinusoid
figure(1);
subplot(2,1,1);
plot_spectrum_log(sig1, fs);
title('Magnitude Spectrum - Single Sinusoid (1kHz)');

% Plot the sum of sinusoids
subplot(2,1,2);
plot_spectrum_log(sig_sum, fs);
title('Magnitude Spectrum - Sum of Sinusoids (1kHz + 5kHz)');

function [sig, t] = generate_sinusoid(fs, A, freq, phase, dur)
    ts = 1/fs; 
    t = 0:ts:(dur - ts); 
    sig = A * cos(2*pi*freq*t + phase); 
end

function plot_spectrum_log(sig, fs)
    N = length(sig);
    spec_length = floor(N/2 + 1);
    
    dft = fft(sig);
    spec = dft(1:spec_length);
    mag = abs(spec)/N;
    mag(2:ceil(N/2)) = 2*mag(2:ceil(N/2));
    
    % Plot the magnitude in decibels
    mag_db = 20*log10(mag); 
    
    k = 0:(spec_length - 1);
    freqs = k*fs/N;
    
    % Logarithmically scale the frequency axis
    semilogx(freqs, mag_db);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
    grid on;
    xlim([20 fs/2]);
end