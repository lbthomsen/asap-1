//
// Top Module for asap1
//
module asap1 (
    input       rst_i,
    input       clk_i,
    input       clk_start_stop_i,
    input       clk_step_i,
    input       clk_speed_i,
    output  reg [7:0]   l0 = 0, 
    output  reg [7:0]   l1 = 0, 
    output  reg [7:0]   l2 = 0, 
    output  reg [7:0]   l3 = 0, 
    output  reg [7:0]   l4 = 0, 
    output  reg [7:0]   l6 = 0, 
    output  reg [7:0]   l7 = 0, 
    output  reg [7:0]   l8 = 0, 
    output  reg [7:0]   l9 = 0
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
    wire    [7:0]                       mem;
    wire    [CONTROL_SIGNALS - 1:0]     ctrl;

    wire zf;
    wire cf;

    assign rst = rst_i;

    always @(clk) begin
        l0[0] <= rst;
        l0[1] <= clk;
        l0[6] <= zf;
        l0[7] <= cf;
        l1 <= pc;
        l2 <= ireg;
        l3 <= addr;
        l4 <= out;
        l6 <= da;
        l7 <= db;
        l8 <= ctrl[16:8];
        l9 <= ctrl[7:0];
    end
     
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

    program_counter_module program_counter (
        .rst(rst), 
        .clk(clk), 
        .ie(ctrl[PCI]), 
        .oe(ctrl[PCO]), 
        .step(ctrl[PCS]), 
        .data(pc), 
        .bus(bus)
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
        .oe(FALSE), 
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
        .ie(ctrl[ALE]), 
        .oe(ctrl[ALO]), 
        .sub(ctrl[ALS]), 
        .a(da), 
        .b(db), 
        .cf(cf), 
        .zf(zf), 
        .bus(bus)
    );

    memory_module ram (
        .rst(rst),
        .clk(clk),
        .ie(ctrl[MI]), 
        .oe(ctrl[MO]), 
        .addr(addr), 
        .data(mem), 
        .bus(bus) 
    );

endmodule

// vim: ts=4 et nowrap autoindent
