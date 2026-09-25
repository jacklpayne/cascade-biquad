xn   = readmatrix('tests/input/noise_in.txt');
y_v  = readmatrix('tests/results/noise_v.txt');
y_m  = cascade_biquad_ideal_ref(xn);

n = min(numel(y_m), numel(y_v));
y_m = y_m(1:n); y_v = y_v(1:n);

fd = fopen('tests/results/noise_m.txt','w');
fprintf(fd, '%.10f\n', y_m);
fclose(fd);

e = y_v - y_m;

fprintf('samples compared : %d\n', n);
fprintf('max |error|      : %.3e  (%.2f LSB)\n', max(abs(e)), max(abs(e))*32768);
fprintf('rms error        : %.3e  (%.2f LSB)\n', rms(e), rms(e)*32768);
fprintf('error SNR        : %.2f dB\n', 10*log10(sum(y_m.^2)/sum(e.^2)));
N = 8192; fs = 48000;
E = fft(e(1:N).*hann(N));
plot((0:N/2-1)*fs/N, 20*log10(abs(E(1:N/2))+eps)); grid on
xlabel('Hz'); ylabel('dB'); title('error spectrum');