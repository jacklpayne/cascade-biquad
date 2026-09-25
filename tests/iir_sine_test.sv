module iir_sine_test();
reg clk;
reg rst;
reg signed[15:0] in_sample;
wire signed[15:0] out_sample;

cascade_biquad dut(
    .clk(clk),
    .in_sample(in_sample),
    .rst(rst),
    .out_sample(out_sample)
);

always #10 clk = ~clk;
integer i, fd;
real out_real;

localparam M = 8692;
reg signed [15:0] stim [0:M-1];

initial begin
    $readmemh("tests/input/sine_in.hex", stim);

    clk = 0; in_sample = 0; rst = 1;
    #20; rst = 0;

    fd = $fopen("tests/results/sine_v.txt", "w");

    @(negedge clk);
    for (i = 0; i < M; i = i+1) begin
        in_sample = stim[i];
        #1;
        $fwrite(fd, "%0.10f\n", $itor($signed(out_sample))/32768.0);
        @(negedge clk);
    end
    $fclose(fd);
    $finish;
end
endmodule
