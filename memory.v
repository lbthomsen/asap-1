// Memory
module memory_module (
    input                   rst, 
    input                   clk, 
    input                   ie, 
    input                   oe, 
    input           [7:0]   addr, 
    output  reg     [7:0]   data = 0, 
    inout           [7:0]   bus
);

    `include "global.vh"

    reg [7:0] mem[255];

    assign bus = (oe == 1'b1) ? data : 8'bzzzzzzzz;

    initial begin 
        $readmemh("counter3.bin", mem);
    end

    always @* begin
        data = mem[addr]; 
    end

    always @ (negedge clk) begin
        if (ie == 1'b1) begin
            mem[addr] = bus;
        end
    end

endmodule
