module top (
    input clk,                  // 50 MHz clock
    input rst_n,                  // reset button
    output logic vga_hs,           // VGA horizontal sync
    output logic vga_vs,           // VGA vertical sync
//  output logic [2:0] vga_rgb     // 1 bit - one color (total: 2^3 = 8 colors)))
    output logic [4:0] vga_r,
    output logic [5:0] vga_g,
    output logic [4:0] vga_b
    );

    wire rst = ~rst_n;

    logic clk_pixel;
    clock_480p current_pix_clock (
        .clk(clk),
        .reset(rst),
        .clk_pixel(clk_pixel)
    );

    logic [9:0] sx, sy;
    logic hsync, vsync, data_en;
    simple_480p sync_generator (
        .clk_pix(clk_pixel),
        .rst(rst),
        .sx(sx),
        .sy(sy),
        .hsync,
        .vsync,
        .data_en
    );

    logic [2:0] paint_rgb, display_rgb;
    much_message crrnt_msg (
        .sx,
        .sy,
        .data_en,
        .clk_pix(clk_pixel),
        .rst,
        .paint_rgb
    );
    //message current_msg (
    //    .sx,
    //    .sy,
    //    .data_en,
    //    .paint_rgb
    //);
    //square current_square (
    //    .sx(sx),
    //    .sy(sy),
    //    .paint_rgb
    //);
    assign display_rgb = (data_en) ? paint_rgb : 3'b000;

    always_ff @(posedge clk_pixel or posedge rst) begin
        if (rst) begin
            vga_hs <= 1'b0;
            vga_vs <= 1'b0;
            vga_r <= 'b0;
            vga_g <= 'b0;
            vga_b <= 'b0;
        end else begin
            vga_hs <= hsync;
            vga_vs <= vsync;
            // vga_rgb <= display_rgb;   // 1 bit - one color (total: 2^3 = 8 colors)))
            vga_r <= {4{display_rgb[0]}};
            vga_g <= {5{display_rgb[1]}};
            vga_b <= {4{display_rgb[2]}};
        end
    end

endmodule
