// ALU
module alu_module (
    input               rst, 
    input               clk, 
    input               ie, 
    input               oe, 
    input               sub, 
    input       [7:0]   a, 
    input       [7:0]   b, 
    output reg          zf, 
    output reg          cf, 
    inout       [7:0]   bus
);

    `include "global.vh"

    reg [15:0]  data;

    assign bus = (oe == 1'b1) ? data[7:0] : 8'bzzzzzzzz;

    always @* begin
        data = (sub == 1'b0) ? a + b : a - b;
    end

    always @(negedge clk) begin
        if (ie == 1'b1) begin
            zf = (data == 0) ? 1'b1 : 1'b0;
            cf = (data > 255) ? 1'b1 : 1'b0;
        end
    end

endmodule
