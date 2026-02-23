Fs = 48000;          % Sampling frequency in Hz
fc = 1000;           % Cut-off frequency in Hz
Q = 0.707;           % Quality factor
dBgain = 0;          % Required by the function inputs

% Generate the IIR filter coefficients using function
[b, a] = AudioEQLPF(fc, dBgain, Fs, Q);

% Visualise frequency response
fvtool(b, a);

% Create a test signal
t = 0:1/Fs:1;
noiseSignal = randn(size(t));

% 4. Apply the IIR filter
filteredNoise = filter(b, a, noiseSignal);

% 5. Plot results
figure;

subplot(2,1,1);
plot(t, noiseSignal);
title('Original White Noise');
xlabel('Time (seconds)');
ylabel('Amplitude');

subplot(2,1,2);
plot(t, filteredNoise);
title('Filtered Noise (1000 Hz Low-Pass Applied)');
xlabel('Time (seconds)');
ylabel('Amplitude');

function [b, a] = AudioEQLPF(fc, dBgain, Fs, Q)
    % Calculate the intermediate variables
    w0 = 2 * pi * fc / Fs;
    alpha = sin(w0) / (2 * Q);
    
    % Calculate the numerator coefficients (b)
    b0 = (1 - cos(w0)) / 2;
    b1 = 1 - cos(w0);
    b2 = (1 - cos(w0)) / 2;
    
    % Calculate the denominator coefficients (a)
    a0 = 1 + alpha;
    a1 = -2 * cos(w0);
    a2 = 1 - alpha;
    
    % Normalise all coefficients by dividing by a0
    % Return them as row vectors
    b = [b0/a0, b1/a0, b2/a0];
    a = [1, a1/a0, a2/a0];
end