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
    integer i;

    assign bus = (oe == 1'b1) ? data[address] : 'bzzzzzzzz;

    initial begin 
        $readmemh("counter1.bin", data);

	//data[0] = 8'h05; 
	//data[1] = 8'h01;
	//data[2] = 8'h04;
	//data[3] = 8'hff;
	//data[4] = 8'h05;
	//data[5] = 8'h00;
	//data[6] = 8'h07;
	//data[7] = 8'h00;
	//data[8] = 8'h02;
	//data[9] = 8'hff;
	//data[10] = 8'h06;
	//data[11] = 8'h06;

/*         for (i = 0; i <= 255; i = i + 1) begin
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
 */
    end

    always @ (negedge clk) begin

        if (ie == 1'b1) begin
            data[address] = bus;
        end

    end

endmodule
