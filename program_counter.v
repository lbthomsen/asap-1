// A single 8 bit register which can work as a counter
module program_counter_module (
    input               rst, 
    input               clk, 
    input               ie, 
    input               oe, 
    input               step, 
    output  reg [7:0]   data, 
    inout       [7:0]   bus
);

    assign bus = (oe == 1'b1) ? data : 8'bzzzzzzzz;

    initial begin
        data = 8'd0;
    end

    always @ (negedge clk) begin

        if (rst == 1'b1) begin
            data <= 8'd0;
        end else begin
            if (ie == 1'b1) begin
                 data <= bus;
            end else begin
                if (step == 1'b1) begin
                    data <= data + 1;
                end
            end
        end
 
    end

endmodule