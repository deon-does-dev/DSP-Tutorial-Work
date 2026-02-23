Fs = 4000;
fc = 300 / (Fs / 2); % Normalised cut-off frequency
n = 30; % For a 61-point filter (2n + 1)

% Generate the filter coefficients
b = fc * sinc(fc * (-n:n));

% Plot the truncated sinc function (impulse response)
figure;
plot(b);
title('Truncated SINC Function');
xlabel('Samples');
ylabel('Amplitude');

% Plot the frequency spectrum
fvtool(b, 1);