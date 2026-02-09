dry = 0.7;      % 70% original
wet = 0.3;      % 30% reverb

% calculate length difference
len_diff = length(y_reverb) - length(sig);

% pad original signal 
sig_padded = [sig; zeros(len_diff, 1)];

% mix signals
y_mix = (sig_padded * dry) + (y_reverb * wet);

% normalise 
y_mix = y_mix / max(abs(y_mix)); 

% compare in a graph
figure;

subplot(2,1,1); 
plot(sig_padded);
title("Dry Signal");

subplot(2,1,2);
plot(y_mix);
title("Final Mix (Dry & Wet)");