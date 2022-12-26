
`timescale 1 ms / 1 ms

module asap1_tb();

    `include "global.vh"

    wire    [7:0]                       bus;
    wire    [7:0]                       pc;
    wire    [7:0]                       da;
    wire    [7:0]                       db;
    wire    [7:0]                       ireg;
    wire    [7:0]                       addr;
    wire    [7:0]                       out;
    wire    [CONTROL_SIGNALS - 1:0]     ctrl;

    wire zf;
    wire cf;

    reg clk_sim = 1;

    // Simulation time: 10000 * 1 ns = 10 us
    localparam DURATION = 100000;

    //assign bus = (force_bus == 1) ? write_bus : 8'bzzzzzzzz;

    always begin
        #5
        clk_sim = ~clk_sim;
    end

    control_module control (
        .clk(clk_sim), 
        .zf(zf), 
        .cf(cf), 

        .ireg(ireg), 

        .ctrl(ctrl)
    );

    register_module a_register (
        .clk(clk_sim), 
        .ie(ctrl[AI]), 
        .oe(ctrl[AO]), 
        .data(da), 
        .bus(bus)
    );

    register_module b_register (
        .clk(clk_sim), 
        .ie(ctrl[BI]), 
        .oe(ctrl[BO]), 
        .data(db), 
        .bus(bus)
    );

    register_module memory_address_register (
        .clk(clk_sim), 
        .ie(ctrl[MAI]), 
        .oe(1'b0), 
        .data(addr), 
        .bus(bus)
    );

    register_module output_register (
        .rst(rst), 
        .clk(clk_sim), 
        .ie(ctrl[OUI]), 
        .oe(1'b0), 
        .data(out), 
        .bus(bus)
    );

    register_module instruction_register (
        .clk(clk_sim), 
        .ie(ctrl[II]),
        .oe(1'b0), 
        .data(ireg),
        .bus(bus)
    );

    alu_module alu (
        .clk(clk_sim), 
        .oe(ctrl[ALO]), 
        .sub(ctrl[ALS]), 
        .a(da), 
        .b(db), 
        .cf(cf), 
        .zf(zf), 
        .bus(bus)
    );

    program_counter_module program_counter (
        .rst(rst), 
        .clk(clk_sim), 
        .ie(ctrl[PCI]), 
        .oe(ctrl[PCO]), 
        .step(ctrl[PCS]), 
        .data(pc), 
        .bus(bus)
    );

    memory_module ram (
        .clk(clk_sim),
        .ie(ctrl[MI]), 
        .oe(ctrl[MO]), 
        .address(addr), 
        .bus(bus) 
    );

    // Run simulation (output to .vcd file)
    initial begin
    
        // Create simulation output file 
        $dumpfile("asap1_tb.vcd");
        $dumpvars(0, asap1_tb);
        
        // Wait for given amount of time for simulation to complete
        #(DURATION)
        
        // Notify and end simulation
        $display("Finished!");
        $finish;
    end

endmodule

// vim: ts=4 et nowrap autoindent
