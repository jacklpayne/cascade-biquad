/*
Single IIR Biquad with Q1.15 inputs, outputs, coefficients
*/

module biquad #(
    // Coefficients
    parameter signed[15:0] a0 = 16'sd0,
    parameter signed[15:0] a1 = 16'sd0,
    parameter signed[15:0] a2 = 16'sd0,
    parameter signed[15:0] b0 = 16'sd0,
    parameter signed[15:0] b1 = 16'sd0,
    parameter signed[15:0] b2 = 16'sd0,
    // Guard bits on the internal registers
    // used for bq0 in the cascade to propagate the
    // limit cycle below the output LSB when rounding
    parameter integer G = 0
)(
    input clk,
    input rst,

    input signed[15:0] in_sample,
    output signed[15:0] out_sample
);

reg signed[15+G:0] acc[1:0];

wire signed[31+G:0] w_full;
wire signed[15+G:0] w;

wire signed[31+G:0] out_full;

assign w_full = (in_sample <<< G)   // Round and shift
        - (((acc[0] * a1) + (1<<14)) >>> 15)
        - (((acc[1] * a2) + (1<<14)) >>> 15);

// Handle overflow
wire no_ovf = (&w_full[31+G:15+G]) | (~|w_full[31+G:15+G]);
assign w = no_ovf ? w_full[15+G:0] : (w_full[31+G] ? {1'b1,{(15+G){1'b0}}} : {1'b0,{(15+G){1'b1}}});

assign out_full = (w * b0)
            + (acc[0] * b1)
            + (acc[1] * b2);

always @(posedge clk) begin
    if (rst) begin
        acc[0] <= 0;
        acc[1] <= 0;
    end
    else begin
        acc[0] <= w;
        acc[1] <= acc[0];
    end
end

wire signed[31+G:0] out_rnd = (out_full + (1<<14+G)) >>> (15+G);

wire no_ovf_out = (&out_rnd[31+G:15]) | (~|out_rnd[31+G:15]);
assign out_sample = no_ovf_out ? out_rnd[15:0]
                               : (out_rnd[31+G] ? 16'h8000 : 16'h7FFF);
endmodule
