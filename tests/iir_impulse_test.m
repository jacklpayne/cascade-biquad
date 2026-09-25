x = zeros(1024,1);
x(1) = round(0.9*32768);        % 29491

h = cascade_biquad_ideal_ref(x);

format long
fprintf('%.10f\n', h);