% Define parameters for testing 
f1 = 200;
f2 = 1000;
dur = 5.0;
fs = 44100; 

% Generate the chirp signal
chirpsig = mychirp(f1, f2, dur, fs);

% Output to a wav file and play the sound
audiowrite('mychirp.wav', chirpsig, fs);
sound(chirpsig, fs);
disp('Playing chirp sound and saved to mychirp.wav...');

function signal = mychirp(f1, f2, dur, fs)
    % MYCHIRP generates a linear-FM chirp signal
    % f1 = starting frequency
    % f2 = ending frequency
    % dur = total time duration
    % fs = sampling frequency (OPTIONAL: default is 8000)
    
    if (nargin < 4)
        fs = 8000;
    end
    
    ts = 1/fs;
    t = 0:ts:dur;
    
    % Calculate the slope parameter 'a'
    a = (f2 - f1) / (2 * dur); 
    b = f1;
    
    % Generate the phase and the signal
    theta = 2*pi*(100 + b*t + a*t.*t);
    signal = real(exp(1j*theta)); % 1j is used instead of j for best practice
end