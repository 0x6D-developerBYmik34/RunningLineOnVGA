`timescale 1ns / 1ps

module simple_480p_tb();

    // parameter CLK_PERIOD = 10;  // 10 ns == 100 MHz
    parameter CLK_PERIOD = 20;  // 10 ns == 100 MHz
    parameter CORDW = 10;  // screen coordinate width in bits

    logic rst;
    logic clk_50m;

    // generate pixel clock
    logic clk_pixel;         // pixel clock
    clock_480p clock_pix_inst (
       .clk(clk_50m),
       .reset(rst),
       .clk_pixel
    );

    // display sync signals and coordinates
    logic [CORDW - 1:0] sx, sy;
    logic hsync, vsync, de;
    
    simple_480p display_inst (
        .clk_pix(clk_pixel),
        .rst, // rst_pix(!clk_pix_locked),  // wait for clock lock
        .sx,
        .sy,
        .hsync,
        .vsync,
        .data_en(de)
    );

    // generate clock
    always #(CLK_PERIOD / 2) clk_50m = ~clk_50m;

    initial begin
        rst = 1;
        clk_50m = 1;

        #100 rst = 0;
        #20_000_000 $finish;  // 18 ms (one frame is 16.7 ms)(1/60HZ)
    end

endmodule
