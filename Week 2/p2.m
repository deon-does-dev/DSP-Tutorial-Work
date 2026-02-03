% Look at import_wav.m (in Class Materials), and use this as a starting
% point to load your own audio files. 

% import audio data as a 2D array
[sig, fs] = audioread("handel.wav");

samples = size(sig, 1);      % count no. of rows 
channels = size(sig, 2);     % count no. of columns

% no. of samples / sampling frequency = duration
duration = samples/fs;

% calculate length of sample
t = (0:(samples - 1)) * (1/fs); % time = no. of samples * duration of 1 sample

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

peak = max(abs(sig(:)));        % find max value across all channels
peak_norm_sig = sig / peak;