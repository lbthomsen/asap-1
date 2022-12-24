// Memory
module memory_module (
    
    input clk, 
    input ie, 
    input oe, 
    input [7:0] address, 

    inout [7:0] bus

);

    `include "global.vh"

    reg [7:0] data[0:255];
    integer i;

    assign bus = (oe == 1'b1) ? data[address] : 'bzzzzzzzz;

    initial begin 
        for (i = 0; i <= 255; i = i + 1) begin
            data[i] = i; // All NOP
        end

        data[0] = LDI;
        data[1] = 8'd1;

        data[2] = STA;
        data[3] = 255;

        data[4] = ADD;
        data[5] = 255;

        data[6] = OUT;
        data[7] = 0;

        data[8] = JMP;
        data[9] = 4;

    end

    always @ (negedge clk) begin

        if (ie == 1'b1) begin
            data[address] = bus;
        end

    end

endmodule
