// Memory
module memory_module (
    
    input clk, 
    input ie, 
    input oe, 
    input [7:0] address, 

    inout [7:0] bus

);

    reg [7:0] data[0:255];
    integer i;

    assign bus = (oe == 1'b1) ? data[address] : 'bzzzzzzzz;

    initial begin 
        for (i = 0; i <= 255; i = i + 1) begin
            data[i] = i; // All NOP
        end
    end

    always @ (negedge clk) begin

        if (ie == 1'b1) begin
            data[address] = bus;
        end

    end

endmodule
