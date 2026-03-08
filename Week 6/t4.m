fs = 44100;
f0 = 100;   % start frequency
f1 = 8000;  % end frequency
T = 2;      % duration 

% generate the chirp signal
[chirp_sig, t] = generate_chirp(fs, f0, f1, T);

% plot magnitude spectrum
figure(1);
subplot(2,1,1);
plot_spectrum(chirp_sig, fs);
title('Magnitude Spectrum of Linear Chirp');

% plot spectrogram 
subplot(2,1,2);
% parameters: signal, window size, overlap, FFT points, sampling rate, 'yaxis' puts frequency on the Y axis
spectrogram(chirp_sig, 1024, 512, 1024, fs, 'yaxis');
title('Spectrogram of Linear Chirp');

function [sig, t] = generate_chirp(fs, f0, f1, T)
    % Synthesise a linear chirp signal
    ts = 1/fs;
    t = 0:ts:(T - ts);
    m = (f1 - f0) / (2 * T);
    sig = cos(2 * pi * (m * t.^2 + f0 * t));
end

function plot_spectrum(sig, fs)
    N = length(sig);
    spec_length = floor(N/2 + 1);
    dft = fft(sig);
    spec = dft(1:spec_length);
    mag = abs(spec)/N;
    mag(2:ceil(N/2)) = 2*mag(2:ceil(N/2));
    mag = 20*log10(mag + 1e-12);
    k = 0:(spec_length - 1);
    freqs = k*fs/N;
    
    plot(freqs, mag);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
    grid on;
end