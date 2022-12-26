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

    /* assign zf = (data == 16'd0);
    assign cf = (data > 8'b11111111) ? 1 : 0; */
    
    //assign data = (sub == 1'b0) ? a + b : a - b;

    always @ (negedge clk) begin
        if (sub == 1'b0) begin
            data = a + b;
        end else begin
            data = a - b;
        end

        zf = (data == 16'd0);
        cf = (data > 8'b11111111) ? 1 : 0;

    end

endmodule
