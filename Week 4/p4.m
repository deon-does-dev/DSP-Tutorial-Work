a = 1;
b = Hd.Numerator;              % Access the filter coefficients
stem(b);             % Plots the impulse response

% Method 1: Convolution
newnoise1 = conv(Noise, b); 

% Method 2: The filter function
newnoise2 = filter(b, a, Noise); 

% Compare lengths
% conv yields N + M - 1 samples, while filter yields N samples 
len1 = length(newnoise1); 
len2 = length(newnoise2);