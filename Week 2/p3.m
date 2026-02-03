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

function [sig, t] = generate_sinusoid(fs, A, freq, phase, dur)
  ts = 1/fs; % calculate the sampling period
  t = 0:ts:(dur - ts); % generate sample times
  sig = A * cos(2*pi*freq*t + phase); % synthesise the signal
end