[sig, fs] = audioread("pluck.wav");

delay_time = 250;   % delay in ms
attenuation = 0.6;  % strength of echo

% convert delay from ms to samples
delay_samples = round(delay_time * 1e-3 * fs);

% ====================================
% WITH USING CONV FUNCTION
% ====================================

% impulse response - create a vector of zeros long enough to hold delay
ir = zeros(delay_samples + 1, 1);

% set first sample to 1
ir(1) = 1;

% wet echo - start at delay time
ir(delay_samples) = attenuation; 

% convolve signals
y = conv(sig, ir);

% create time vector based on sampling frequency
t = (0:length(y) - 1) / fs;

% plot echo 
figure;
plot(t, y);
title("Echo Effect");
xlabel("Time (S)");
ylabel("Amplitude");
grid on;

% ====================================
% WITHOUT USING CONV FUNCTION
% ====================================

% pad dry signal with 0s
dry_signal = [sig; zeros(delay_samples, 1)];

% create wet signal
wet_signal = [zeros(delay_samples, 1); sig] * attenuation;

% combine dry and wet signals
output_signal = dry_signal + wet_signal;

% time vector based on sampling frequency
t = (0:length(y) - 1) / fs;

% plot echo
figure(2);
plot(t, y);
title("Echo Effect (without conv)");
xlabel("Time (S)");
ylabel("Amplitude");
grid on;