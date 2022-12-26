// ALU
module alu_module (
    input               clk, 
    input               oe, 
    input               sub, 
    input       [7:0]   a, 
    input       [7:0]   b, 
    output      reg     zf, 
    output      reg     cf, 
    inout       [7:0]   bus
);

    reg [15:0] data;

    assign bus = (oe == 1'b1) ? data : 'bzzzzzzzz;

    always @ (a, b) begin
      if (sub == 1'b0) begin
        data = a + b;
      end else begin
        data = a - b;
      end
      zf = (data == 16'd0) ? 1'b1 : 1'b0;
      cf = (data > 255) ? 1'b1 : 1'b0;
    end

endmodule