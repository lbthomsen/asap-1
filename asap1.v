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
    output      led7, 
    output       [7:0] l4

);

    `include "global.vh"

    wire clk; 
    wire rst;

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

    assign rst = rst_i;
    assign led7 = clk;
    assign l4 = out;
    
    clock_module clock0 (
        .rst(rst), 
        .clk_i(clk_i), 
        .clk_step_i(clk_step_i), 
        .clk_start_stop_i(clk_start_stop_i), 
        .clk_speed_i(clk_speed_i), 
        .clk(clk)
    );

    control_module control (
        .rst(rst), 
        .clk(clk), 
        .zf(zf), 
        .cf(cf), 
        .ireg(ireg), 
        .ctrl(ctrl)
    );

    register_module a_register (
        .rst(rst),
        .clk(clk), 
        .ie(ctrl[AI]), 
        .oe(ctrl[AO]), 
        .data(da), 
        .bus(bus)
    );

    register_module b_register (
        .rst(rst),
        .clk(clk), 
        .ie(ctrl[BI]), 
        .oe(ctrl[BO]), 
        .data(db), 
        .bus(bus)
    );

    register_module memory_address_register (
        .rst(rst),
        .clk(clk), 
        .ie(ctrl[MAI]), 
        .oe(1'b0), 
        .data(addr), 
        .bus(bus)
    );

    register_module output_register (
        .rst(rst), 
        .clk(clk), 
        .ie(ctrl[OUI]), 
        .oe(1'b0), 
        .data(out), 
        .bus(bus)
    );

    register_module instruction_register (
        .rst(rst),
        .clk(clk), 
        .ie(ctrl[II]),
        .oe(1'b0), 
        .data(ireg),
        .bus(bus)
    );

    alu_module alu (
        .rst(rst),
        .clk(clk), 
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
        .clk(clk), 
        .ie(ctrl[PCI]), 
        .oe(ctrl[PCO]), 
        .step(ctrl[PCS]), 
        .data(pc), 
        .bus(bus)
    );

    memory_module ram (
        .rst(rst),
        .clk(clk),
        .ie(ctrl[MI]), 
        .oe(ctrl[MO]), 
        .address(addr), 
        .bus(bus) 
    );

endmodule

// vim: ts=4 et nowrap autoindent
