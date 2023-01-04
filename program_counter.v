// A single 8 bit register which can work as a counter
module program_counter_module (
    input               rst, 
    input               clk, 
    input               ie, 
    input               oe, 
    input               step, 
    output  reg [7:0]   data, 
    inout       [7:0]   bus
);

    `include "global.vh"

    register_counter_module rcm (
        .rst(rst), 
        .clk(clk), 
        .ie(ie), 
        .oe(oe), 
        .step(step), 
        .data(data), 
        .bus(bus)
    );

endmodule
