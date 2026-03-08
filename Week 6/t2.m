fs = 44100; 
dur = 1; 
N = fs*dur; 
noise = randn(1, N);
noise = noise/max(abs(noise)); % Peak normalise

% 1. Take the DFT using fft()
dft = fft(noise);

% 2. Manipulate the DFT coefficients
f1 = 2000;
f2 = 4000;
k1 = floor(f1*N/fs) + 1;
k2 = floor(f2*N/fs) + 1;

% Apply a spectral effect: Boost the frequencies by a factor of 2 (~6dB)
dft(k1:k2) = dft(k1:k2) * 2; 

% 3. Take the IDFT using ifft() with the symmetric flag
processed_noise = ifft(dft, 'symmetric');

% Plot Spectra
figure(1);
plot_spectrum(noise, fs);
hold on;
plot_spectrum(processed_noise, fs);
hold off;
ylim([-100, -20]);
legend('Original White Noise', 'Boosted Noise (2kHz - 4kHz)');
title('Spectral Processing: Frequency Boost');

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