h = readmatrix('IR_samples.txt');

fs = 48000; N = 4096;
H = fft(h, N);
f = (0:N/2-1)*fs/N;
plot(f, 20*log10(abs(H(1:N/2))+eps)); grid on;
xlim([0 fs/2]); ylim([-60 5]); xlabel('Hz'); ylabel('dB');