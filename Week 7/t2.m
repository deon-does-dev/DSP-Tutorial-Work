fs = 10000;
% Generate a chirp from 1700 Hz to 200 Hz for 1.5 seconds
sig = mychirp(1700, 200, 1.5, fs); 

% Plot the spectrum
plot_fft_spectrum(sig, fs);

function plot_fft_spectrum(sig, Fs)
    % Function to compute and plot the FFT of a signal
    len = length(sig);
    SSC = fft(sig);
    SSR = abs(SSC) ./ len;     % Normalize magnitude
    L = round(len/2);          % Only need the first half of the FFT
    
    Mag = mag2db(SSR);         % Convert to decibels
    f = (Fs/2) * (0:L) / L;    % Create frequency axis
    
    % Plotting
    figure;
    plot(f, Mag(1:L+1));
    title('FFT of Chirp Signal');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
    grid on;
end

function signal = mychirp(f1, f2, dur, fs)
    % Included to keep the script self-contained
    if (nargin < 4), fs = 8000; end
    ts = 1/fs;
    t = 0:ts:dur;
    a = (f2 - f1) / (2 * dur); 
    b = f1;
    theta = 2*pi*(100 + b*t + a*t.*t);
    signal = real(exp(1j*theta));
end