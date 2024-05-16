`timescale 1ns / 1ps

module clock_tb();

    parameter CLK_PERIOD = 20;

    logic rst, clk_50m;

    // 640x480p60 clocks
    logic clk_480p;

    clock_480p clock_480p_inst (
       .clk(clk_50m),
       .reset(rst),
       .clk_pixel(clk_480p)
    );

    always #(CLK_PERIOD / 2) clk_50m = ~clk_50m;

    initial begin
        clk_50m = 1;
        rst = 1;
        #100
        rst = 0;

        #12000
        $dumpvars;
        $finish;
    end

endmodule
