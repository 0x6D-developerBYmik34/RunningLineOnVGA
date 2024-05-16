module square (
    input [9:0] sx, sy,
    output logic [2:0] paint_rgb
    );

    localparam SQUARE_COLOR = 3'b111; 
    localparam BACKGROUND_COLOR = 3'b101;
    
    // square shape
    logic square;
    always_comb begin
        square = (sx > 220 && sx < 420) && (sy > 140 && sy < 340);
    end

    assign paint_rgb = (square) ? SQUARE_COLOR : BACKGROUND_COLOR;

    // paint colour: white inside square, blue outside
    // colorised: on every pixel color by RGB
    //logic [3:0] paint_r, paint_g, paint_b;
    //always_comb begin
    //    paint_r = (square) ? 4'hF : 4'b0000;
    //    paint_g = (square) ? 4'hF : 4'b0000;
    //    paint_b = (square) ? 4'hF : 4'b1000;
    //end


    // logic [4:0] display_r, display_g, display_b;
    //always_comb begin
    //    display_r = (data_en) ? paint_r : 4'h0;
     //   display_g = (data_en) ? paint_r : 4'h0;
      //  display_b = (data_en) ? paint_r : 4'h0;
    //end

endmodule
