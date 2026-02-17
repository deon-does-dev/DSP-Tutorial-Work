noiseFs = 22050;
noiseDur = 2;

% generate noise with mean of 0 and standard deviation of 1
noise = randn(noiseFs * noiseDur, 1); 

sound(noise, noiseFs);