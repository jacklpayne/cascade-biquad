rng(1);
M  = 20000;
xn = randi([-8192 8192], M, 1);          % ±0.25 FS, uniform

fd = fopen('tests/input/noise_in.hex','w');
fprintf(fd, '%04x\n', mod(xn, 65536));
fclose(fd);

writematrix(xn, 'tests/input/noise_in.txt');