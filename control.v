// CPU control logic
module control_module (

    input                                   clk, 

    input                                   zf,     // Zero flag
    input                                   cf,     // Carry flag

    input           [7:0]                   ireg,     // Instruction register direct data
    input           [7:0]                   oreg,     // Operand register direct data
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
        MICROCODE[LDA][0] <= $pow(2, MO) + $pow(2, MAI);
        MICROCODE[LDA][1] <= $pow(2, MO) + $pow(2, AI);
        MICROCODE[LDA][2] <= 16'd0;

        // ADD
        MICROCODE[ADD][0] <= $pow(2, MO) + $pow(2, MAI); // Memory out (operand is in memory address register) memory address in
        MICROCODE[ADD][1] <= $pow(2, MO) + $pow(2, BI);  // Memory out B in
        MICROCODE[ADD][2] <= $pow(2, ALO) + $pow(2, AI); // ALU out A in
        MICROCODE[ADD][3] <= 16'd0;

        // SUB
        MICROCODE[SUB][0] <= $pow(2, MO) + $pow(2, MAI); // Memory out (operand is in memory address register) memory address in
        MICROCODE[SUB][1] <= $pow(2, MO) + $pow(2, BI) + $pow(2, ALS);  // Memory out B in and ALU Subtract flag
        MICROCODE[SUB][2] <= $pow(2, ALO) + $pow(2, AI) + $pow(2, ALS); // ALU out A in
        MICROCODE[SUB][3] <= 16'd0;

        // STA
        MICROCODE[STA][0] <= $pow(2, MO) + $pow(2, MAI);
        MICROCODE[STA][1] <= $pow(2, AO) + $pow(2, MI);
        MICROCODE[STA][2] <= 16'd0;

        // LDI
        MICROCODE[LDI][0] <= $pow(2, MO) + $pow(2, AI);
        MICROCODE[LDI][1] <= 16'd0;

        // JMP
        MICROCODE[JMP][0] <= $pow(2, MO) + $pow(2, PCI);
        MICROCODE[JMP][1] <= 16'd0;

        // OUT
        MICROCODE[OUT][0] <= $pow(2, AO) + $pow(2, OUI);
        MICROCODE[OUT][1] <= 16'd0;

    end

    always @ (posedge clk) begin
        case (step)  
            4'd0: begin
                ctrl = $pow(2, PCO) + $pow(2, MAI);
            end
            4'd1: begin
                ctrl = $pow(2, MO) + $pow(2, II) + $pow(2, PCS);
            end
            4'd2: begin
                ctrl = $pow(2, PCO) + $pow(2, MAI);
            end
            4'd3: begin
                ctrl = $pow(2, MO) + $pow(2, OI) + $pow(2, PCS);
            end
            4'd4, 
            4'd5, 
            4'd6, 
            4'd7: begin
                ctrl = MICROCODE[ireg][step - 4];
                if (ctrl == 16'd0) step = 4'b1111; // Will roll over to zero
            end
/*             default: begin
                ctrl = 0;
            end */
        endcase
        step = step + 1;
    end

endmodule
