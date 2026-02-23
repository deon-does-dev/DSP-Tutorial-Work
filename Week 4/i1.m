% Create a test signal
Fs = 22050;
duration = 2;

% Generate a row vector of noise to match the loop structure
testSignal = randn(1, Fs * duration); 

% Extract the impulse response from filter (Hd)
IR = Hd.Numerator; 

% Apply the filter using conv function
filteredSignal = myConv(testSignal, IR);

% Visualise the results
figure;

subplot(2,1,1);
plot(testSignal);
title('Original Noise Signal');
xlabel('Samples');
ylabel('Amplitude');

subplot(2,1,2);
plot(filteredSignal);
title('Filtered Signal (Low-Pass Applied via Conv Func)');
xlabel('Samples');
ylabel('Amplitude');

% Listen to the difference
% sound(testSignal, Fs);
% pause(duration + 0.5);
% sound(filteredSignal, Fs);

function output = myConv(signal, IR)
    % Find the lengths of the input arrays
    lenSignal = length(signal);
    lenIR = length(IR);
    
    % Calculate the total length of the convolved output
    outLen = lenSignal + lenIR - 1;
    
    % Initialise the output array with zeros
    output = zeros(1, outLen);
    
    % Perform the convolution using dynamic boundaries
    for i = 1:lenSignal
        for j = 1:lenIR
            output(i + j - 1) = output(i + j - 1) + signal(i) * IR(j);
        end
    end
end