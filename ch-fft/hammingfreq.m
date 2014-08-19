function resp = hammingfreq(n,freqs)


resp = exp(-j*(n-1)*0.5*freqs) .* (0.54*S(n, freqs) + ...
       0.23*S(n, freqs-2*pi/(n-1)) + 0.23*S(n, freqs+2*pi/(n-1)));
