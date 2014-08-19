function resp = hannfreq(n,freqs)


resp = 0.5 * exp(-j*(n-1)*0.5*freqs) .* ...
(S(n, freqs) + 0.5*S(n, freqs-2*pi/(n-1)) + 0.5*S(n, freqs+2*pi/(n-1)));
