// ALU
module alu_module (
    input               oe, 
    input               sub, 
    input       [7:0]   a, 
    input       [7:0]   b, 
    output              zf, 
    output              cf, 
    inout       [7:0]   bus
);

    wire [15:0] data;

    assign zf = (data == 16'd0);
    assign cf = (data > 8'b11111111) ? 1 : 0;
    assign bus = (oe == 1'b1) ? data : 'bzzzzzzzz;
    assign data = (sub == 1'b0) ? a + b : a - b;

endmodule
