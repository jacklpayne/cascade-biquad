// Q1.15
// Cascade biquad IIR
module biquad_standalone(
    input clk,
    input rst,

    input signed[15:0] in_sample,
    output signed[15:0] out_sample
    );

// Single biquad
wire signed[15:0] a[2:0]; // Are negative
wire signed[15:0] b[2:0];
reg signed[15:0] acc[1:0];

wire signed[31:0] w_full;
wire signed[15:0] w;

wire signed[31:0] out;

assign b[0] = 16'h7FFF; // ~1
assign b[1] = 16'h2000; // 0.25
assign b[2] = 16'h2000; // 0.25

assign a[0] = 16'hFFFF; // ~-1.0, unused
assign a[1] = 16'hE000; // -0.25
assign a[2] = 16'hF000; // -0.125

assign w_full = in_sample
        + (((acc[0] * a[1]) + (1<<14)) >>> 15)
        + (((acc[1] * a[2]) + (1<<14)) >>> 15);

assign w = w_full[15:0];

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

assign out = (w * b[0])
            + (acc[0] * b[1])
            + (acc[1] * b[2]);

assign out_sample = out + ((1<<14)) >>> 15;
endmodule
