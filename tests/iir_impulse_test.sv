module iir_impulse_test();
reg clk;
reg rst;
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
initial begin
    clk = 0;
    in_sample = 0;
    rst = 1;
    #20;
    rst = 0;
    @(negedge clk);

    in_sample = 16'h7333;      // 0.9 impulse

    fd = $fopen("tests/results/IR_v.txt", "w");

    for (i = 0; i < 1024; i = i+1) begin
        #1;
        out_real = $itor($signed(out_sample)) / 32768.0;
        $fwrite(fd, "%0.10f\n", out_real);
        @(negedge clk);
        in_sample = 0;
    end
    $fclose(fd);
    $finish;
end
endmodule
