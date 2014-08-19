% quantdemo1.m
%
% Demonstrate the effects of quantization error, by playing tones with
% different numbers of bits of quantization error.

% Sampling frequency, tone frequency (Hz), signal duration (s)
Fs = 5000;
f = 250;
T = 3;

% Generate sine wave (full double-precision quantization)
t = [0:1/Fs:T];
orig = sin(2*pi*f*t);

% Quantize to 16, 8, 4 bits. Remember, the signal goes from -1 to +1,
% so the number of levels produced below is twice the multiplier (plus one).
q8 = round(orig*2^7);
q4 = round(orig*2^3);
q2 = round(orig*2);

input(['Press enter to play the original tone at ' int2str(f) 'Hz']);
soundsc(orig,Fs);

input(['Press enter to play the tone at 8 bits quantization']);
soundsc(q8,Fs);

input(['Press enter to play the tone at 4 bits quantization']);
soundsc(q4,Fs);

input(['Press enter to play the tone at 2 bits quantization']);
soundsc(q2,Fs);
