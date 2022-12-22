// Program counter
module program_counter_module (
    
    input               clk, 
    input               ie, 
    input               oe, 
    input               step, 
    output  reg [7:0]   data, 
    inout       [7:0]   bus

);

    assign bus = (oe == 1'b1) ? data : 'bzzzzzzzz;

    initial begin
        data <= 8'd0;
    end

    always @ (negedge clk) begin

        if (ie == 1'b1) begin
            data = bus;
        end else begin
            if (step == 1'b1) begin
                data = data + 1;
            end
        end

    end

endmodule