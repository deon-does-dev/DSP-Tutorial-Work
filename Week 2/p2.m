% Look at import_wav.m (in Class Materials), and use this as a starting
% point to load your own audio files. 

% import audio data as a 2D array
[sig, fs] = audioread("handel.wav");

samples = size(sig, 1);             % count no. of rows 
channels = size(sig, 2);            % count no. of columns

% no. of samples / sampling frequency = duration
duration = samples/fs;

% calculate length of sample
t = (0:(samples - 1)) * (1/fs);     % time = no. of samples * duration of 1 sample

% ====================================
% 1. Plot waveform of a signal
% ====================================

figure(1);
plot(t, sig);
ylim([-1, 1]);
xlabel("Time (s)");

% ====================================
% 2. Apply gain to signal 
% ====================================

gain = sig * 0.5;

% ====================================
% 3. Apply DC offset to signal
% ====================================

offset = sig + 0.1;

% ====================================
% 4. Normalise signal to peak at 1
% ====================================

peak = max(abs(sig(:)));            % find max value across all channels
peak_norm = sig / peak;

% ====================================
% 5. Normalise to RMS amp of .5
% ====================================

rms = rms(sig(:));                  % calculate current RMS value
rms_norm = sig * (0.5 / rms);

% ====================================
% 6. Add fades to sample with linspace
% ====================================

% create fade using linspace over sample length
fade_in = linspace(0, 1, length(sig))';
fade_out = linspace(1, 0, length(sig))';

% apply both fades to sample
fade_in_sample = sig .* fade_in;
fade_out_sample = fade_in_sig .* fade_out;

% ====================================
% 7. Reverse sample
% ====================================

% flip the column vector
reversed = flipud(sig);

% ====================================
% 8. Swap channels
% ====================================

% column 1 takes the signal's 2nd column and vice versa for other column
swapped = [sig(:, 2), sig(:, 1)];

% ====================================
% 9. Sum to mono
% ====================================

% average two channels together
mono = (sig (:, 1) + sig(:, 2)) / 2;