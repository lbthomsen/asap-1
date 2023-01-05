// CPU control logic
module control_module (
    input                                   rst, 
    input                                   clk, 
    input                                   zf,     // Zero flag
    input                                   cf,     // Carry flag
    input           [7:0]                   ireg,     // Instruction register direct data
    output  reg     [CONTROL_SIGNALS - 1:0] ctrl
);

    `include "global.vh"

    reg [15:0] MICROCODE [0:255] [0:3];

    reg [3:0]   step;

    initial begin
        ctrl <= 16'b0000000000000000;
        step <= 4'b1111;

        // NOP
        MICROCODE[NOP][0] <= 16'd0; // Do nothing - the remaining steps doesn't matter

        // LDA
        MICROCODE[LDA][0] <= 2**MO + 2**MAI;
        MICROCODE[LDA][1] <= 2**MO + 2**AI;
        MICROCODE[LDA][2] <= 16'd0;

        // ADD
        MICROCODE[ADD][0] <= 2**MO + 2**MAI; // Memory out (operand is in memory address register) memory address in
        MICROCODE[ADD][1] <= 2**MO + 2**BI;  // Memory out B in
        MICROCODE[ADD][2] <= 2**ALO + 2**AI; // ALU out A in
        MICROCODE[ADD][3] <= 16'd0;

        // SUB
        MICROCODE[SUB][0] <= 2**MO + 2**MAI; // Memory out (operand is in memory address register) memory address in
        MICROCODE[SUB][1] <= 2**MO + 2**BI + 2**ALS;  // Memory out B in and ALU Subtract flag
        MICROCODE[SUB][2] <= 2**ALO + 2**AI + 2**ALS; // ALU out A in
        MICROCODE[SUB][3] <= 16'd0;

        // STA
        MICROCODE[STA][0] <= 2**MO + 2**MAI;
        MICROCODE[STA][1] <= 2**AO + 2**MI;
        MICROCODE[STA][2] <= 16'd0;

        // LDI
        MICROCODE[LDI][0] <= 2**MO + 2**AI; // At this point, the MAR already contains the operand address
        MICROCODE[LDI][1] <= 16'd0;

        // JMP
        MICROCODE[JMP][0] <= 2**MO + 2**PCI;
        MICROCODE[JMP][1] <= 16'd0;

        // OUT
        MICROCODE[OUT][0] <= 2**AO + 2**OUI;
        MICROCODE[OUT][1] <= 16'd0;

        // CMP
        MICROCODE[CMP][0] <= 2**MO + 2**MAI; // Memory out (operand is in memory address register) memory address in
        MICROCODE[CMP][1] <= 2**MO + 2**BI + 2**ALS + 2**ALE;  // Memory out B in and ALU Subtract flag and ALU Latch Enable
        MICROCODE[CMP][2] <= 2**ALS + 2**ALE;  
        MICROCODE[CMP][3] <= 16'd0;

        // JZ
        MICROCODE[JZ][0] <= 2**JE;
        MICROCODE[JZ][1] <= 2**MO + 2**PCI;
        MICROCODE[JZ][2] <= 16'd0;   

    end

    always @ (posedge clk) begin
        case (step)  
            4'd0: begin
                ctrl = 2**PCO + 2**MAI + 2**PCS;
            end
            4'd1: begin
                ctrl = 2**MO + 2**II;
            end
            4'd2: begin
                ctrl = 2**PCO + 2**MAI + 2**PCS;
            end
            4'd3, 
            4'd4,
            4'd5,  
            4'd6: begin
                ctrl = MICROCODE[ireg][step - 3];
                if ( ctrl == 2**JE ) begin
                    if (zf != TRUE) step = 4'b1111; // Respond to zero flag check
                end else begin
                    if (ctrl == 16'd0) step = 4'b1111; // Will roll over to zero
                end
            end
        endcase
        step = step + 1;
    end

endmodule
