module simple_480p (
    input wire clk_pix,
    input wire rst,
    output logic [9:0] sx, // max 524 => 10 bit
    output logic [9:0] sy, // max 799 => 10 bit
    output logic hsync,
    output logic vsync,
    output logic data_en
    );

    // horizontal timings
    localparam HA_END = 640 - 1;       // end of active pixels
    localparam HS_STA = HA_END + 16;   // sync starts after front porch
    localparam HS_END = HS_STA + 96;   // sync ends
    localparam FULL_LINE   = 799;           // last pixel on line (after back porch)

    // vertical timings
    localparam VA_END = 480 - 1;       // end of active pixels
    localparam VS_STA = VA_END + 10;   // sync starts after front porch
    localparam VS_END = VS_STA + 2;    // sync ends
    localparam FULL_SCREEN = 524;           // last line on screen (after back porch
    
    // sync signals (is true, its write)
    always_comb begin
        hsync = ~(sx >= HS_STA && sx < HS_END); // negative: is false, to wait a true 
        vsync = ~(sy >= VS_STA && sy < VS_END);
        data_en = (sx <= HA_END && sy <= VA_END);
    end
    
    // calculate hor and vert screen positions
    always_ff @(posedge clk_pix or posedge rst) begin
        if (rst) begin
            sx <= 0;
            sy <= 0;
        end else if (sx == FULL_LINE) begin // last pixel on line?
            sx <= 0;
            sy <= (sy == FULL_SCREEN) ? 0 : sy + 1; // last line on screen?
        end else begin
            sx <= sx + 1;
        end
    end
        // is a system rst, not cloxk_pixel_rst
        //  ~~ProTip: The last assignment wins in Verilog,~~ 
        //  ~~so the reset overrides existing values for sx and sy.~~
endmodule
