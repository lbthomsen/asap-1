//
// Clock Module
//

module clock_module (
    input       rst, 
    input       clk_i, 
    input       clk_start_stop_i, 
    input       clk_step_i, 
    input       clk_speed_i,
    output      clk
);

    reg        clk_o;
    reg        clk_step_o;

    reg         running = 1'b1;
    reg [31:0]  counter = 0;
    reg [31:0]  count_max[0:3];

    reg [1:0]   count_max_idx = 2'b00;

    initial begin 
        count_max[0] = 32'd12500000;
        count_max[1] = 32'd1250000;
        count_max[2] = 32'd125000;
        count_max[3] = 32'd12500;
    end;

    assign clk = running ? clk_o : clk_step_o;

    always @(posedge clk_i) begin
        if (rst) begin
            if (running) begin
                counter++;
                if (counter >= count_max[count_max_idx] - 1) 
                begin
                    clk_o = ~clk_o;
                    counter = 0;
                end
            end else  begin
                clk_o = 1'b0;
                counter = 0;
            end
        end else begin
            clk_o = 1'b0;
            counter = 0;            
        end
    end

    always @(posedge clk_start_stop_i) begin
        running = ~running;
    end

    always @(posedge clk_speed_i) begin
        count_max_idx = count_max_idx + 1;
    end

    always @(clk_step_i) begin
        clk_step_o = clk_step_i; 
    end


endmodule
