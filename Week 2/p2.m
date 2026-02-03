% Look at import_wav.m (in Class Materials), and use this as a starting
% point to load your own audio files. 

% import audio data as a 2D array
[sig, fs] = audioread("skepta_stereo.wav");

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

rms_sample = rms(sig(:));           % calculate current RMS value
rms_norm = sig * (0.5 / rms_sample);

% ====================================
% 6. Add fades to sample with linspace
% ====================================

% create fade using linspace over sample length
fade_in = linspace(0, 1, length(sig))';
fade_out = linspace(1, 0, length(sig))';

% apply both fades to sample
fade_in_sample = sig .* fade_in;
fade_out_sample = fade_in_sample .* fade_out;

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

% ====================================
% 10. Load multiple samples & mix
% ====================================

% load additional audio file
[sig2, fs2] = audioread("lexapro_stereo.wav");

mono2 = (sig2(:, 1) + sig2(:, 2)) / 2;

% find maximum length of each sample, and pad shorter sample with 0s
max_len = max(length(mono), length(mono2));

pad1 = zeros(max_len - length(mono), 1);
pad2 = zeros(max_len - length(mono2), 1);

sample1_padded = [mono; pad1];
sample2_padded = [mono2; pad2];

% sum both samples together
mixed_sample = sample1_padded + sample2_padded;

% normalise to prevent clipping
mixed_sample = mixed_sample / max(abs(mixed_sample));

sound(mixed_sample, fs2);