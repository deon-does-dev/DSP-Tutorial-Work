% Dual frequency noise from task 2
Fs = 4000;
t = 0:1/Fs:0.05;
testSignal = sin(2*pi*150*t) + sin(2*pi*800*t);

win = hamming(61)'; % Generate a 61-point Hamming window and transpose it
b_hamming = b .* win; % Apply window 

% Filter the signal
filteredSignal = filter(b_hamming, 1, testSignal);

% Plot the original and filtered signals for comparison
figure;
subplot(2, 1, 1);
plot(t, testSignal);
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2, 1, 2);
plot(t, filteredSignal);
title('Filtered Signal');
xlabel('Time (s)');
ylabel('Amplitude');