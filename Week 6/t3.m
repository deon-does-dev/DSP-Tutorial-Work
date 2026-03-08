fs = 8000;
[sig, ~] = generate_sinusoid(fs, 1, 440, 0, 0.5); % 0.5 seconds of a 440Hz wave
N = length(sig);

% Time the custom DFT
disp('Running custom DFT (this might take a moment)...');
tic;
custom_dft_result = my_dft(sig);
custom_time = toc;

% Time MATLAB's FFT
tic;
matlab_fft_result = fft(sig);
fft_time = toc;

% Compare Accuracy (Maximum absolute difference between the two)
max_diff = max(abs(custom_dft_result - matlab_fft_result));

fprintf('Custom DFT Time: %.4f seconds\n', custom_time);
fprintf('MATLAB FFT Time: %.4f seconds\n', fft_time);
fprintf('Maximum Difference (Accuracy): %e\n', max_diff);

function X = my_dft(x)
    % Custom implementation of the DFT
    N = length(x);
    X = zeros(1, N);
    
    for k = 0:(N-1)
        for n = 0:(N-1)
            % MATLAB starts at 1, not 0
            X(k+1) = X(k+1) + x(n+1) * exp(-1i * 2 * pi * k * n / N);
        end
    end
end

function [sig, t] = generate_sinusoid(fs, A, freq, phase, dur)
    ts = 1/fs; 
    t = 0:ts:(dur - ts); 
    sig = A * cos(2*pi*freq*t + phase); 
end