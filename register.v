// Wrapper around register_counter_module
module register_module (
    input               rst, 
    input               clk, 
    input               ie, 
    input               oe, 
    output      [7:0]   data, 
    inout       [7:0]   bus
);

    register_counter_module register1 (
        .rst(rst), 
        .clk(clk), 
        .ie(ie), 
        .oe(oe), 
        .step(1'b0),
        .data(data),  
        .bus(bus)
    );

endmodule