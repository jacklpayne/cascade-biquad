/*
    4-section cascade of Direct Form II biquads.
    PIPELINE=1 registers each section's output, so the critical path is
    one biquad instead of all four. Costs 4 cycles of latency; throughput
    stays one sample per clock.
*/
module cascade_biquad #(
    parameter PIPELINE = 1
)(
    input clk,
    input rst,
    input signed[15:0] in_sample,
    output signed[15:0] out_sample
);

/*
    Biquad 0
*/
localparam signed[15:0] bq0_a0 = 16'h7FFF;
localparam signed[15:0] bq0_a1 = 16'h0000;
localparam signed[15:0] bq0_a2 = 16'h5636;  // 0.673523
localparam signed[15:0] bq0_b0 = 16'h358D;  // 0.418365
localparam signed[15:0] bq0_b1 = 16'h6B1B;  // 0.836761
localparam signed[15:0] bq0_b2 = 16'h358D;  // 0.418365

wire signed[15:0] bq0_out;
reg  signed[15:0] bq0_reg;
wire signed[15:0] bq0_pipe = PIPELINE ? bq0_reg : bq0_out;

biquad #(bq0_a0, bq0_a1, bq0_a2, bq0_b0, bq0_b1, bq0_b2, 2) biquad0 (
    .clk(clk),
    .rst(rst),

    .in_sample(in_sample),
    .out_sample(bq0_out)
);

always @(posedge clk) begin
    if (rst) bq0_reg <= 0;
    else     bq0_reg <= bq0_out;
end

/*
    Biquad 1
*/
localparam signed[15:0] bq1_a0 = 16'h7FFF;
localparam signed[15:0] bq1_a1 = 16'h0000;
localparam signed[15:0] bq1_a2 = 16'h2492;  // 0.285706
localparam signed[15:0] bq1_b0 = 16'h2924;  // 0.321411
localparam signed[15:0] bq1_b1 = 16'h5249;  // 0.642853
localparam signed[15:0] bq1_b2 = 16'h2924;  // 0.321411

wire signed[15:0] bq1_out;
reg  signed[15:0] bq1_reg;
wire signed[15:0] bq1_pipe = PIPELINE ? bq1_reg : bq1_out;

biquad #(bq1_a0, bq1_a1, bq1_a2, bq1_b0, bq1_b1, bq1_b2, 0) biquad1 (
    .clk(clk),
    .rst(rst),

    .in_sample(bq0_pipe),
    .out_sample(bq1_out)
);

always @(posedge clk) begin
    if (rst) bq1_reg <= 0;
    else     bq1_reg <= bq1_out;
end

/*
    Biquad 2
*/
localparam signed[15:0] bq2_a0 = 16'h7FFF;
localparam signed[15:0] bq2_a1 = 16'h0000;
localparam signed[15:0] bq2_a2 = 16'h0BC7;  // 0.092010
localparam signed[15:0] bq2_b0 = 16'h22F2;  // 0.273010
localparam signed[15:0] bq2_b1 = 16'h45E4;  // 0.546021
localparam signed[15:0] bq2_b2 = 16'h22F2;  // 0.273010

wire signed[15:0] bq2_out;
reg  signed[15:0] bq2_reg;
wire signed[15:0] bq2_pipe = PIPELINE ? bq2_reg : bq2_out;

biquad #(bq2_a0, bq2_a1, bq2_a2, bq2_b0, bq2_b1, bq2_b2, 0) biquad2 (
    .clk(clk),
    .rst(rst),

    .in_sample(bq1_pipe),
    .out_sample(bq2_out)
);

always @(posedge clk) begin
    if (rst) bq2_reg <= 0;
    else     bq2_reg <= bq2_out;
end

/*
    Biquad 3
*/
localparam signed[15:0] bq3_a0 = 16'h7FFF;
localparam signed[15:0] bq3_a1 = 16'h0000;
localparam signed[15:0] bq3_a2 = 16'h013E;  // 0.009705
localparam signed[15:0] bq3_b0 = 16'h204F;  // 0.252411
localparam signed[15:0] bq3_b1 = 16'h409F;  // 0.504852
localparam signed[15:0] bq3_b2 = 16'h204F;  // 0.252411

wire signed[15:0] bq3_out;
reg  signed[15:0] bq3_reg;

biquad #(bq3_a0, bq3_a1, bq3_a2, bq3_b0, bq3_b1, bq3_b2, 0) biquad3 (
    .clk(clk),
    .rst(rst),

    .in_sample(bq2_pipe),
    .out_sample(bq3_out)
);

always @(posedge clk) begin
    if (rst) bq3_reg <= 0;
    else     bq3_reg <= bq3_out;
end

assign out_sample = PIPELINE ? bq3_reg : bq3_out;
endmodule