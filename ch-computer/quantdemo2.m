% quantdemo2.m
%
% Demonstrate the effects of quantization error, by playing a bird song with
% different numbers of bits of quantization error.

% Sampling frequency, tone frequency (Hz), signal duration (s)
Fs = 8192;

% load the song into variable "orig"
load amoriole2.mat

% Quantize to 16, 8, 4 bits. Remember, the signal goes from -1 to +1,
% so the number of levels produced below is twice the multiplier (plus one).
q8 = round(orig*2^7);
q4 = round(orig*2^3);
q2 = round(orig*2);

input(['Press enter to play the original song']);
soundsc(orig,Fs);

input(['Press enter to play the song at 8 bits quantization']);
soundsc(q8,Fs);

input(['Press enter to play the song at 4 bits quantization']);
soundsc(q4,Fs);

input(['Press enter to play the song at 2 bits quantization']);
soundsc(q2,Fs);
