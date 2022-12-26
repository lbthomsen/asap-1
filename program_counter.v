// Wrapper around register_counter_module
module program_counter_module (
    input               rst, 
    input               clk, 
    input               ie, 
    input               oe, 
    input               step, 
    output      [7:0]   data, 
    inout       [7:0]   bus

);

    register_counter_module program_counter1 (
        .rst(rst), 
        .clk(clk), 
        .ie(ie), 
        .oe(oe), 
        .step(step),
        .data(data),  
        .bus(bus)
    );

endmodule