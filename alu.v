// ALU
module alu_module (
    input               rst, 
    input               clk, 
    input               oe, 
    input               sub, 
    input       [7:0]   a, 
    input       [7:0]   b, 
    output              zf, 
    output              cf, 
    inout       [7:0]   bus
);

    reg [15:0] data;

    assign bus = (oe == 1'b1) ? data[7:0] : 8'bzzzzzzzz;

    assign zf = (data == 16'd0) ? 1'b1 : 1'b0;

    assign cf = (data > 255) ? 1'b1 : 1'b0;

    always @* data = (sub == 1'b0) ? a + b : a - b;

endmodule
