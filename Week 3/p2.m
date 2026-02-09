[sig, fs] = audioread("Class Materials/pluck.wav");
[ir, fs_ir] = audioread("Class Materials/LargeHall.wav");
% [ir, fs_ir] = audioread("Church.wav");

[rows, cols] = size(ir);

% convert to mono
if cols == 2
    ir = mean(ir, 2);
end

% perform convolution
y_reverb = conv(sig, ir);

% normalise 
y_reverb = y_reverb / max(abs(y_reverb));

% plot
t = (0:length(y_reverb) - 1) / fs;

figure;
plot(t, y_reverb);
title("Convolution Reverb");
xlabel("Time (S)");