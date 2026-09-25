function y = cascade_biquad_ideal_ref(x_int)
    sos = [13709 27419 13709 32768 0 22070
           10531 21062 10531 32768 0  9362
            8946 17892  8946 32768 0  3015
            8271 16543  8271 32768 0   318] / 32768;
    y = double(x_int)/32768;
    for s = 1:4
        y = filter(sos(s,1:3), [1 sos(s,5:6)], y);
    end
end