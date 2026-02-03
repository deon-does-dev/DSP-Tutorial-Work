% ====================================
% 1. Investigate effects of aliasing
% ====================================

fs = 100;       % low sampling frequency 
dur = 0.5;      % short duration
amp = 0.5;

% generate frequency below nyquist limit
freq1 = fs/4;
[sig1, t1] = generate_sinusoid(fs, amp, freq1, 0, dur);

% generate frequency above nyquist limit
freq2 = (fs/4) * 3;
[sig2, t2] = generate_sinusoid(fs, amp, freq2, 0, dur);

% smooth out graph lines
t_smooth = 0:0.001:(dur - 0.001);

sig1_smooth = amp * cos(2*pi*freq1*t_smooth);
sig2_smooth = amp * cos(2*pi*freq2*t_smooth);

% plot both generated frequencies
figure(1);
clf;

% plot signal 1 with circles
subplot(2, 1, 1);
plot(t_smooth, sig1_smooth, "b-");
title((fs/4) + " Hz Signal (Sampled at " + fs + " Hz)");
xlabel("Time (s)");
grid on;

% plot signal 2 with squares
subplot(2, 1, 2);
plot(t_smooth, sig2_smooth, "r-");
title((fs/4) * 3 + " Hz Signal (Sampled at " + fs + " Hz)");
xlabel("Time (s)");
grid on;

% ====================================
% 2. Mix 2 different freq. together
% ====================================

% set new, higher sampling frequency 
fs = 48000;

% generate 2 signals
[sig1, t] = generate_sinusoid(fs, 0.5, 440, 0, 1);
[sig2, t] = generate_sinusoid(fs, 0.5, 660, 0, 1); 

% mix both signals together
mixed_signal = sig1 + sig2; 

% ====================================
% 3. Concatenate signals to make tune
% ====================================

% create tune (middle C, D then E)
[note1, ~] = generate_sinusoid(fs, 0.8, 261.63, 0, 0.5);
[note2, ~] = generate_sinusoid(fs, 0.8, 293.66, 0, 0.5);
[note3, ~] = generate_sinusoid(fs, 0.8, 329.63, 0, 0.5);

% append to list tune
tune = [note1, note2, note3];

% ====================================
% 4. Generate binaural beats
% ====================================

% generate 2 signals of slightly different frequencies 
[left_channel, ~] = generate_sinusoid(fs, 0.8, 200, 0, 5);
[right_channel, t] = generate_sinusoid(fs, 0.8, 205, 0, 5);

% combine into a 2-column matrix 
binaural = [left_channel', right_channel'];

% play it back
sound(binaural, fs);

% Function from generate_sinusoid.m in class materials

function [sig, t] = generate_sinusoid(fs, A, freq, phase, dur)
  ts = 1/fs; % calculate the sampling period
  t = 0:ts:(dur - ts); % generate sample times
  sig = A * cos(2*pi*freq*t + phase); % synthesise the signal
end