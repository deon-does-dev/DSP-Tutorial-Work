% 1. Set up the time vector
Fs = 4000; 
t = 0:1/Fs:0.05; % Generate just 0.05 seconds of audio so the waves are visible on a plot

% 2. Create the individual frequency components
wave_150 = sin(2 * pi * 150 * t);
wave_800 = sin(2 * pi * 800 * t);

% Combine them to create the composite test signal
testSignal = wave_150 + wave_800;

% 3. Apply the filter from Task 1
filteredSignal = filter(b, 1, testSignal);

% 4. Plot the results to compare them
figure;

subplot(2,1,1);
plot(t, testSignal);
title('Original Signal (150 Hz + 800 Hz)');
xlabel('Time (seconds)');
ylabel('Amplitude');

subplot(2,1,2);
plot(t, filteredSignal);
title('Filtered Signal (300 Hz Low-Pass Applied)');
xlabel('Time (seconds)');
ylabel('Amplitude');