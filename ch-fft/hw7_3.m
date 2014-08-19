

plot(freqs, 20*log10(abs(hannfreq(64,freqs))), ...
     freqs, 20*log10(abs(hammingfreq(64,freqs))));


xlabel('Frequency')
ylabel('Magnitude, dB')

