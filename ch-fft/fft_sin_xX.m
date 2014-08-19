n = [0:511];
deltaf = 100/512;
Ts = 1/100;
t = n*Ts;

x1 = sin(2*pi*25*deltaf*t);
x2 = sin(2*pi*128*deltaf*t);
x = x1 + x2;

figure(1);
clf;
subplot(2,1,1)
plot(t, x, 'k')
set(gca, 'xlim', [0 5])
xlabel('Time (s)')
ylabel('x(t)')

X = fft(x, 512);
subplot(2,1,2);
plot(n(1:257)*deltaf, 20*log10(abs(X(1:257))), 'k');
set(gca, 'ylim', [-300 100])
xlabel('Frequency (Hz)')
ylabel('|X|, dB')
print -deps2 fft_sin_xX

x1 = sin(2*pi*5*t);        
x2 = sin(2*pi*25*t);        
x = x1 + x2;
figure(2);
clf;
subplot(2,1,1)
X = fft(x, 512);
plot(n(1:257)*deltaf, 20*log10(abs(X(1:257))), 'k');
ylabel('|X|, dB');
x2 = sin(2*pi*24*t);
x = x1 + x2;
X = fft(x, 512);
subplot(2,1,2)
plot(n(1:257)*deltaf, 20*log10(abs(X(1:257))), 'k');
xlabel('Frequency (Hz)');
ylabel('|X|, dB');

print -deps2 fft_sin_XX
