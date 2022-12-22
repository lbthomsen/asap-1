//
// Top Module for asap1
//
module asap1 (

    input       rst_i,
    input       clk_i,
    input       clk_start_stop_i,
    input       clk_step_i,
    input       clk_speed_i,
    output      led0 = 0,
    output      led1 = 0,
    output      led2 = 0,
    output      led3 = 0,
    output      led4 = 0,
    output      led5 = 0,
    output      led6 = 0,
    output      led7

);

    `include "global.vh"

    wire clk; 

    wire    [7:0]   bus;
    wire    [7:0]   da;
    wire    [7:0]   db;
    wire    [7:0]   ireg;
    wire    [7:0]   oreg;
    wire    [CONTROL_SIGNALS - 1:0]     ctrl;

    wire zf;
    wire cf;

    assign led7 = clk;
    
    clock_module clock0 (
        .clk_i(clk_i), 
        .clk_step_i(clk_step_i), 
        .clk_start_stop_i(clk_start_stop_i), 
        .clk_speed_i(clk_speed_i), 
        .clk(clk)
    );

    control_module control (
        .clk(clk), 
        .zf(zf), 
        .cf(cf), 

        .ireg(ireg), 
        .oreg(oreg), 

        .ctrl(ctrl)
    );

    register_module a_register (
        .clk(clk), 
        .ie(ctrl[AI]), 
        .oe(ctrl[AO]), 
        .data(da), 
        .bus(bus)
    );

    register_module b_register (
        .clk(clk), 
        .ie(ctrl[BI]), 
        .oe(ctrl[BO]), 
        .data(db), 
        .bus(bus)
    );

    register_module memory_address_register (
        .clk(clk), 
        .ie(ctrl[MAI]),
        .oe(FALSE), 
        .bus(bus)
    );

    register_module output_register (
        .clk(clk), 
        .ie(ctrl[OUI]),
        .oe(FALSE),  
        .bus(bus)
    );

    register_module instruction_register (
        .clk(clk), 
        .ie(ctrl[II]),
        .oe(FALSE),  
        .data(ireg),
        .bus(bus)
    );

    register_module operand_register (
        .clk(clk), 
        .ie(ctrl[OI]), 
        .oe(FALSE), 
        .data(oreg),
        .bus(bus)
    );

    alu_module alu (
        .oe(ctrl[ALO]), 
        .sub(als), 
        .a(da), 
        .b(db), 
        .cf(cf), 
        .zf(zf), 
        .bus(bus)
    );

    program_counter_module program_counter (
        .clk(clk), 
        .ie(ctrl[PCI]), 
        .oe(ctrl[PCO]), 
        .step(ctrl[PCS]), 
        .bus(bus)
    );

    memory_module ram (
        .clk(clk),
        .ie(ctrl[MI]), 
        .oe(ctrl[MO]), 
        .bus(bus) 
    );

endmodule

// vim: ts=4 et nowrap autoindent
