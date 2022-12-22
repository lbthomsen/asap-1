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

    // Define the instruction set
    parameter 
        NOP = 8'h00;

    reg [15:0] MICROCODE [0:254] [0:7];

    reg [3:0]   step;

    initial begin
        ctrl <= 16'b0000000000000000;
        step <= 4'b1111;
        MICROCODE[0][0] <= 16'b0000000000000000;
    end

    always @ (posedge clk) begin
        step = step + 1;
    end

    always @ (step) begin
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
            default: begin
                ctrl = 0;
            end
        endcase
    end

endmodule
