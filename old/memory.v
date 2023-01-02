// Memory
module memory_module (
    
    input rst, 
    input clk, 
    input ie, 
    input oe, 
    input [7:0] address, 

    inout [7:0] bus

);

    `include "global.vh"

    reg [7:0] data[0:255];

    assign bus = (oe == 1'b1) ? data[address] : 'bzzzzzzzz;

    initial begin 
        $readmemh("counter2.bin", data);
    end

    always @ (negedge clk) begin
        if (ie == 1'b1) begin
            data[address] = bus;
        end
    end

endmodule
