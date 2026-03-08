fs = 10000;
% Generate a chirp from 200 Hz to 1700 Hz for 1.5 seconds
sig = mychirp(200, 1700, 1.5, fs);

% STFT Parameters
window = 128;   % Segment size
noverlap = 120; % Overlapping samples
nfft = 128;     % FFT length

% Generate the Spectrogram
figure;
spectrogram(sig, window, noverlap, nfft, fs, 'yaxis');
title('Spectrogram (STFT) of Chirp Signal');

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