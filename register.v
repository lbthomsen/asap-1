// A single 8 bit register
module register_module (
    input               rst, 
    input               clk, 
    input               ie, 
    input               oe, 
    output  reg [7:0]   data, 
    inout       [7:0]   bus
);

    assign bus = (oe == 1'b1) ? data : 'bzzzzzzzz;

    always @ (negedge clk) begin

        if (rst == 1'b1) begin
            data = 8'd0;
        end else begin
            if (ie == 1'b1) begin
                 data = bus;
            end
        end

    end

endmodule