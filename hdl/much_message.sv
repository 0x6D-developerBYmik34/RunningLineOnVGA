module much_message (
    input [9:0] sx, sy,
    input data_en,
    input clk_pix, // clk_pix 25Mhz to clock 5hz  
    input rst,
    output logic [2:0] paint_rgb
    );

    localparam TEXT_COLOR = 3'b110;
    localparam BACKGROUND_COLOR = 3'b001;

    // frame - 20; 60 - 20 = 40 for shit_cnt
    localparam bit [0:14][0:59] HER_BMAP = {
        60'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000,
        60'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000,
        60'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000,
        60'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000,
        60'b0000_0000_0000_0000_0000_0110_0000_1110_1110_1110_1010_0000_0000_0000_0000,
        60'b0000_0000_0000_0000_0000_1010_0000_1000_1000_1000_1010_0000_0000_0000_0000,
        60'b0000_0000_0000_0000_0000_0110_0000_1110_1110_1000_1110_0000_0000_0000_0000,
        60'b0000_0000_0000_0000_0000_1010_0000_1010_1000_1000_0100_0000_0000_0000_0000,
        60'b0000_0000_0000_0000_0000_1010_0000_1110_1110_1000_1000_0000_0000_0000_0000,
        60'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000,
        60'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000,
        60'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000,
        60'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000,
        60'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000,
        60'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000
    };

    localparam PAINT_FREQ_HZ = 10;
    localparam CONTER_LEN = $clog2(25_000_000 / PAINT_FREQ_HZ);

    // count 1 million number => enble with freq 5hz
    // logic banner_clk;
    logic [CONTER_LEN - 1:0] cnt_for_enbl;
    always_ff @(posedge clk_pix or posedge rst) begin
        if (rst) cnt_for_enbl <= 'b0;
        else cnt_for_enbl <= cnt_for_enbl + 'b1;
    end
    wire banner_clk = (cnt_for_enbl == {CONTER_LEN{1'b0}});

    logic [5:0] shift_counter;
    always_ff @(posedge clk_pix or posedge rst) begin
        if (rst) shift_counter <= 'b0;
        else if (banner_clk) 
            shift_counter <= shift_counter + 'b1;
        else if(shift_counter == 6'd40) shift_counter <= 'b0;
    end

    // paint at 32x scale in active screen area
    logic msg_place;
    logic [4:0] x;  // 20 columns need five bits
    logic [3:0] y;  // 15 rows need four bits
    always_comb begin
        x = sx[9:5];    // every 32 horizontal pixels
        y = sy[8:5];    // every 32 vertical pixels
        msg_place = (data_en) ? HER_BMAP[y][x + shift_counter]: 0;
    end
    
    assign paint_rgb = (msg_place) ? TEXT_COLOR : BACKGROUND_COLOR;

endmodule
