//
// A single 8 bit register
//
module register_module (
    input               rst, 
    input               clk, 
    input               ie, 
    input               oe, 
    output  reg [7:0]   data, 
    inout       [7:0]   bus
);

    `include "global.vh"

    register_counter_module rcm (
        .rst(rst), 
        .clk(clk), 
        .ie(ie), 
        .oe(oe), 
        .step(FALSE), 
        .data(data), 
        .bus(bus)
    );

endmodule
// vim: ts=4 et nowrap autoindent