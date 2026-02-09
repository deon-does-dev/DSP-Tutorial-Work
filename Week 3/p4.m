[sig, fs] = audioread("Class Materials/pluck.wav");
[ir, ~] = audioread("Class Materials/LargeHall.wav");

% Make IR mono and shorten for test (commented out)
ir = mean(ir, 2);
% ir = ir(1:2000);

% ====================================
% BUILT-IN CONV FUNCTION
% ====================================

disp("Built-in convolution function");

tic;                        % start timer
y_builtin = conv(sig, ir);
time_builtin = toc;         % stop timer

% ====================================
% MANUAL CONV FUNCTION
% ====================================

disp("Manual loop algorithm");

N = length(sig);
M = length(ir);
y_manual = zeros(N + M - 1, 1);

tic;                        % start timer 

for n = 1:length(y_manual)
    k_min = max(1, n - N + 1);
    k_max = min(n, M);

    sum_val = 0;

    for k = k_min:k_max
        sum_val = sum_val + sig(n - k + 1) * ir(k);
    end

    y_manual(n) = sum_val;
end
time_manual = toc;          % stop timer 

fprintf("Manual Loop took: %.4f seconds\n", time_manual);
fprintf("Built-in function took: %.1f seconds, and is %.4f times faster", time_builtin, time_manual/time_builtin)