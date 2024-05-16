module clock_480p (
    input wire clk,
    input wire reset,
    output logic clk_pixel
    );

    localparam BOARD_CLK_MHZ = 50;
    localparam VGA_PIXEL_CLOCK_MHZ = 25;

    localparam COUNTER_VALUE = (BOARD_CLK_MHZ / VGA_PIXEL_CLOCK_MHZ) - 1;

    logic [3:0] clk_en_cnt;
    logic clk_en;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            clk_en_cnt <= 3'b0;
            clk_en <= 1'b0;
        end else begin
            if (clk_en_cnt == COUNTER_VALUE) begin 
            	clk_en_cnt <= 3'b0;
            	clk_en <= 1'b1;
            end else begin
            	clk_en_cnt <= clk_en_cnt + 1;
            	clk_en <= 1'b0;
            end
        end
    end

    assign clk_pixel = clk_en;

endmodule
