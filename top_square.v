`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2020 12:29:25 PM
// Design Name: 
// Module Name: top_square
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////
module top_square(
    input wire CLK,             // board clock: 100 MHz on Arty/Basys3/Nexys
    input wire RST_BTN,  
    input wire[5:0] seconds,
    input wire[5:0] minutes,
    input wire[4:0] hours,     
    output wire VGA_HS_O,       // horizontal sync output
    output wire VGA_VS_O,        // vertical sync output
    output wire [3:0] VGA_R    // 4-bit VGA red output
    );

    wire rst = ~RST_BTN;    // reset is active low on Arty & Nexys Video
    

    // generate a 25 MHz pixel strobe
    reg [15:0] cnt;
    reg pix_stb;
    always @(posedge CLK)begin
        {pix_stb, cnt} <= cnt + 16'h4000;  // divide by 4: (2^16)/4 = 0x4000
    end

    wire [9:0] x;  // current pixel x position: 10-bit value: 0-1023
    wire [8:0] y;  // current pixel y position:  9-bit value: 0-511

    vga640x480 display (
        .i_clk(CLK),
        .i_pix_stb(pix_stb),
        .i_rst(rst),
        .o_hs(VGA_HS_O), 
        .o_vs(VGA_VS_O), 
        .o_x(x), 
        .o_y(y)
    );
    wire H01, H02, H03, H04, H05, H06, H07, H11, H12, H13, H14, H15, H16, H17, C01, C02, M01, M02, M03, M04, M05, M06, M07, M11, M12, M13, M14, M15, M16, M17, C11, C12, S01, S02, S03, S04, S05, S06, S07, S11, S12, S13, S14, S15, S16, S17, A1, A2, A3, A4, AP, M1, M2, M3, M4;
    assign H01 = ((x > 29) & (y > 136) & (x < 69) & (y < 150)) ? 1 : 0; 
    assign H02 = ((x > 13) & (y > 151) & (x < 27) & (y < 192)) ? 1 : 0; 
    assign H03 = ((x > 71) & (y > 151) & (x < 86) & (y < 190)) ? 1 : 0; 
    assign H04 = ((x > 29) & (y > 194) & (x < 69) & (y < 206)) ? 1 : 0; 
    assign H05 = ((x > 13) & (y > 208) & (x < 27) & (y < 249)) ? 1 : 0; 
    assign H06 = ((x > 71) & (y > 208) & (x < 86) & (y < 249)) ? 1 : 0; 
    assign H07 = ((x > 29) & (y > 250) & (x < 69) & (y < 264)) ? 1 : 0; 
    assign H11 = ((x > 116) & (y > 136) & (x < 155) & (y < 150)) ? 1 : 0; 
    assign H12 = ((x > 99) & (y > 151) & (x < 114) & (y < 192)) ? 1 : 0; 
    assign H13 = ((x > 158) & (y > 151) & (x < 172) & (y < 190)) ? 1 : 0; 
    assign H14 = ((x > 116) & (y > 194) & (x < 155) & (y < 206)) ? 1 : 0; 
    assign H15 = ((x > 99) & (y > 208) & (x < 114) & (y < 249)) ? 1 : 0; 
    assign H16 = ((x > 158) & (y > 208) & (x < 172) & (y < 249)) ? 1 : 0; 
    assign H17 = ((x > 116) & (y > 250) & (x < 155) & (y < 264)) ? 1 : 0; 
    assign C01 = ((x > 197) & (y > 159) & (x < 212) & (y < 173)) ? 1 : 0; 
    assign C02 = ((x > 197) & (y > 230) & (x < 212) & (y < 244)) ? 1 : 0; 
    assign S01 = ((x>475) & (y > 136) & (x<515) & (y<150)) ? 1:0;
    assign S02 = ((x>459) & (y > 151) & (x<473) & (y<192)) ? 1:0;
    assign S03 = ((x>517) & (y > 151) & (x<532) & (y<190)) ? 1:0;
    assign S04 = ((x>475) & (y > 194) & (x<515) & (y<206)) ? 1:0;
    assign S05 = ((x>459) & (y > 208) & (x<473) & (y<249)) ? 1:0;
    assign S06 = ((x>517) & (y > 208) & (x<532) & (y<249)) ? 1:0;
    assign S07 = ((x>475) & (y > 250) & (x<515) & (y<264)) ? 1:0;
    assign S11 = ((x>562) & (y > 136) & (x<601) & (y<150)) ? 1:0;
    assign S12 = ((x>545) & (y > 151) & (x<560) & (y<192)) ? 1:0;
    assign S13 = ((x>604) & (y > 151) & (x<618) & (y<190)) ? 1:0;
    assign S14 = ((x>562) & (y > 194) & (x<601) & (y<206)) ? 1:0;
    assign S15 = ((x>545) & (y > 208) & (x<560) & (y<249)) ? 1:0;
    assign S16 = ((x>604) & (y > 208) & (x<618) & (y<249)) ? 1:0;
    assign S17 = ((x>562) & (y > 250) & (x<601) & (y<264)) ? 1:0;
    /* assign A1 = ((x>519) & (y > 281) & (x<548) & (y<285)) ? 1:0;
    assign A2 = ((x>519) & (y > 285) & (x<523) & (y<330)) ? 1:0;
    assign A3 = ((x>524) & (y > 298) & (x<543) & (y<302)) ? 1:0;
    assign A4 = ((x>544) & (y > 285) & (x<548) & (y<302)) ? 1:0;
    assign AP = ((x>544) & (y > 301) & (x<548) & (y<330)) ? 1:0;
    assign M1 = ((x>566) & (y > 281) & (x<595) & (y<285)) ? 1:0;
    assign M2 = ((x>566) & (y > 285) & (x<570) & (y<330)) ? 1:0;
    assign M3 = ((x>591) & (y > 285) & (x<595) & (y<330)) ? 1:0;
    assign M4 = ((x>579) & (y > 285) & (x<583) & (y<302)) ? 1:0;
    */
    assign M01 = ((x>252) & (y > 136) & (x<292) & (y<150)) ? 1:0;
    assign M02 = ((x>236) & (y > 151) & (x<250) & (y<192)) ? 1:0;
    assign M03= ((x>294) & (y > 151) & (x<309) & (y<190)) ? 1:0;
    assign M04 = ((x>252) & (y > 194) & (x<292) & (y<206)) ? 1:0;
    assign M05= ((x>236) & (y > 208) & (x<250) & (y<249)) ? 1:0;
    assign M06 = ((x>294) & (y > 208) & (x<309) & (y<249)) ? 1:0;
    assign M07 = ((x>252) & (y > 250) & (x<292) & (y<264)) ? 1:0;
    assign M11 = ((x>339) & (y > 136) & (x<378) & (y<150)) ? 1:0;
    assign M12 = ((x>322) & (y > 151) & (x<337) & (y<192)) ? 1:0;
    assign M13= ((x>381) & (y > 151) & (x<395) & (y<190)) ? 1:0;
    assign M14 = ((x>339) & (y > 194) & (x<378) & (y<206)) ? 1:0;
    assign M15= ((x>322) & (y > 208) & (x<337) & (y<249)) ? 1:0;
    assign M16 = ((x>381) & (y > 208) & (x<395) & (y<249)) ? 1:0;
    assign M17 = ((x>339) & (y > 250) & (x<378) & (y<264)) ? 1:0;
    assign C11 = ((x>420) & (y > 159) & (x<435) & (y<173)) ? 1:0;
    assign C12 = ((x>420) & (y > 230) & (x<435) & (y<244)) ? 1:0;
    reg grid;
    assign VGA_R[3] = grid;
always @(*)begin
grid = H01 + H02+ H03+ H04+ H05+ H06+ H07+ H11+ H12+ H13+ H14+ H15+ H16+ H17+ C01+ C02+ M01+ M02+ M03+ M04+ M05+ M06+ M07+ M11+ M12+ M13+ M14+ M15+ M16+ M17+ C11+ C12+ S01+ S02+ S03+ S04+ S05+ S06+ S07+ S11+ S12+ S13+ S14+ S15+ S16+ S17; // A1+ A2+ A3+ A4+ AP+ M1+ M2+ M3+ M4;
    case(seconds)
        0 : grid = grid - S04 - S14;
        1 : grid = grid - S11 - S12 - S14 - S15 - S17 - S04;
        2 : grid = grid - S12 - S16 - S04;
        3 : grid = grid - S12 - S15 - S04;
        4 : grid = grid - S11 - S15 - S17 - S04;
        5 : grid = grid - S13 - S15 - S04;
        6 : grid = grid - S13 - S04;
        7 : grid = grid - S12 - S14 - S15 - S17 - S04;
        8 : grid = grid - S04;
        9 : grid = grid - S15 - S17 - S04;
        10 : grid = grid - S01 - S02 - S04 - S05 - S07 - S14;
        11 : grid = grid - S11 - S12 - S14 - S15 - S17 - S01 - S02 - S04 - S05 - S07;
        12 : grid = grid - S12 - S16 - S01 - S02 - S04 - S05 - S07;
        13 : grid = grid - S01 - S02 - S04 - S05 - S07 - S12 - S15;
        14 : grid = grid - S01 - S02 - S04 - S05 - S07 - S11 - S15 - S17;
        15 : grid = grid - S01 - S02 - S04 - S05 - S07 - S13 - S15;
        16 : grid = grid - S01 - S02 - S04 - S05 - S07 - S13;
        17 : grid = grid - S01 - S02 - S04 - S05 - S07 - S12 - S14 - S15 - S17;
        18 : grid = grid - S01 - S02 - S04 - S05 - S07;
        19 : grid = grid - S01 - S02 - S04 - S05 - S07 - S15 - S17;
        20 : grid = grid - S02 - S06 - S14;
        21 : grid = grid - S11 - S12 - S14 - S15 - S17 - S02 - S06;
        22 : grid = grid - S12 - S16 - S02 - S06;
        23 : grid = grid - S02 - S06 - S12 - S15;
        24 : grid = grid - S02 - S06 - S11 - S15 - S17;
        25 : grid = grid - S02 - S06 - S13 - S15;
        26 : grid = grid - S02 - S06 - S13;
        27 : grid = grid - S02 - S06 - S12 - S14 - S15 - S17;
        28 : grid = grid - S02 - S06;
        29 : grid = grid - S02 - S06 - S15 - S17;
        30 : grid = grid - S02 - S05 - S14;
        31 : grid = grid - S11 - S12 - S14 - S15 - S17 - S02 - S05;
        32 : grid = grid - S12 - S16 - S02 - S05;
        33 : grid = grid - S02 - S05 - S12 - S15;
        34 : grid = grid - S02 - S05 - S11 - S15 - S17;
        35 : grid = grid - S02 - S05 - S13 - S15;
        36 : grid = grid - S02 - S05 - S13;
        37 : grid = grid - S02 - S05 - S12 - S14 - S15 - S17;
        38 : grid = grid - S02 - S05;
        39 : grid = grid - S02 - S05 - S15 - S17;
        40 : grid = grid - S01 - S05 - S07 - S14;
        41 : grid = grid - S11 - S12 - S14 - S15 - S17 - S01 - S05 - S07;
        42 : grid = grid - S12 - S16 - S01 - S05 - S07;
        43 : grid = grid - S01 - S05 - S07 - S12 - S15;
        44 : grid = grid - S01 - S05 - S07 - S11 - S15 - S17;
        45 : grid = grid - S01 - S05 - S07 - S13 - S15;
        46 : grid = grid - S01 - S05 - S07 - S13;
        47 : grid = grid - S01 - S05 - S07 - S12 - S14 - S15 - S17;
        48 : grid = grid - S01 - S05 - S07;
        49 : grid = grid - S01 - S05 - S07 - S15 - S17;
        50 : grid = grid - S03 - S05 - S14;
        51 : grid = grid - S11 - S12 - S14 - S15 - S17 - S03 - S05;
        52 : grid = grid - S12 - S16 - S03 - S05;
        53 : grid = grid - S03 - S05 - S12 - S15;
        54 : grid = grid - S03 - S05 - S11 - S15 - S17;
        55 : grid = grid - S03 - S05 - S13 - S15;
        56 : grid = grid - S03 - S05 - S13;
        57 : grid = grid - S03 - S05 - S12 - S14 - S15 - S17;
        58 : grid = grid - S03 - S05;
        59 : grid = grid - S03 - S05 - S15 - S17;
        60 : grid = grid - S03 - S14;
     endcase
     case(minutes)
        0 : grid = grid - M04 - M14;
        1 : grid = grid - M11 - M12 - M14 - M15 - M17 - M04;
        2 : grid = grid - M12 - M16 - M04;
        3 : grid = grid - M12 - M15 - M04;
        4 : grid = grid - M11 - M15 - M17 - M04;
        5 : grid = grid - M13 - M15 - M04;
        6 : grid = grid - M13 - M04;
        7 : grid = grid - M12 - M14 - M15 - M17 - M04;
        8 : grid = grid - M04;
        9 : grid = grid - M15 - M17 - M04;
        10 : grid = grid - M01 - M02 - M04 - M05 - M07 - M14;
        11 : grid = grid - M11 - M12 - M14 - M15 - M17 - M01 - M02 - M04 - M05 - M07;
        12 : grid = grid - M12 - M16 - M01 - M02 - M04 - M05 - M07;
        13 : grid = grid - M01 - M02 - M04 - M05 - M07 - M12 - M15;
        14 : grid = grid - M01 - M02 - M04 - M05 - M07 - M11 - M15 - M17;
        15 : grid = grid - M01 - M02 - M04 - M05 - M07 - M13 - M15;
        16 : grid = grid - M01 - M02 - M04 - M05 - M07 - M13;
        17 : grid = grid - M01 - M02 - M04 - M05 - M07 - M12 - M14 - M15 - M17;
        18 : grid = grid - M01 - M02 - M04 - M05 - M07;
        19 : grid = grid - M01 - M02 - M04 - M05 - M07 - M15 - M17;
        20 : grid = grid - M02 - M06 - M14;
        21 : grid = grid - M11 - M12 - M14 - M15 - M17 - M02 - M06;
        22 : grid = grid - M12 - M16 - M02 - M06;
        23 : grid = grid - M02 - M06 - M12 - M15;
        24 : grid = grid - M02 - M06 - M11 - M15 - M17;
        25 : grid = grid - M02 - M06 - M13 - M15;
        26 : grid = grid - M02 - M06 - M13;
        27 : grid = grid - M02 - M06 - M12 - M14 - M15 - M17;
        28 : grid = grid - M02 - M06;
        29 : grid = grid - M02 - M06 - M15 - M17;
        30 : grid = grid - M02 - M05 - M14;
        31 : grid = grid - M11 - M12 - M14 - M15 - M17 - M02 - M05;
        32 : grid = grid - M12 - M16 - M02 - M05;
        33 : grid = grid - M02 - M05 - M12 - M15;
        34 : grid = grid - M02 - M05 - M11 - M15 - M17;
        35 : grid = grid - M02 - M05 - M13 - M15;
        36 : grid = grid - M02 - M05 - M13;
        37 : grid = grid - M02 - M05 - M12 - M14 - M15 - M17;
        38 : grid = grid - M02 - M05;
        39 : grid = grid - M02 - M05 - M15 - M17;
        40 : grid = grid - M01 - M05 - M07 - M14;
        41 : grid = grid - M11 - M12 - M14 - M15 - M17 - M01 - M05 - M07;
        42 : grid = grid - M12 - M16 - M01 - M05 - M07;
        43 : grid = grid - M01 - M05 - M07 - M12 - M15;
        44 : grid = grid - M01 - M05 - M07 - M11 - M15 - M17;
        45 : grid = grid - M01 - M05 - M07 - M13 - M15;
        46 : grid = grid - M01 - M05 - M07 - M13;
        47 : grid = grid - M01 - M05 - M07 - M12 - M14 - M15 - M17;
        48 : grid = grid - M01 - M05 - M07;
        49 : grid = grid - M01 - M05 - M07 - M15 - M17;
        50 : grid = grid - M03 - M05 - M14;
        51 : grid = grid - M11 - M12 - M14 - M15 - M17 - M03 - M05;
        52 : grid = grid - M12 - M16 - M03 - M05;
        53 : grid = grid - M03 - M05 - M12 - M15;
        54 : grid = grid - M03 - M05 - M11 - M15 - M17;
        55 : grid = grid - M03 - M05 - M13 - M15;
        56 : grid = grid - M03 - M05 - M13;
        57 : grid = grid - M03 - M05 - M12 - M14 - M15 - M17;
        58 : grid = grid - M03 - M05;
        59 : grid = grid - M03 - M05 - M15 - M17;
        60 : grid = grid - M03 - M14;
    endcase
    case(hours)
        0 : grid = grid - H04 - H14;
        1 : grid = grid - H11 - H12 - H14 - H15 - H17 - H04;
        2 : grid = grid - H12 - H16 - H04;
        3 : grid = grid - H12 - H15 - H04;
        4 : grid = grid - H11 - H15 - H17 - H04;
        5 : grid = grid - H13 - H15 - H04;
        6 : grid = grid - H13 - H04;
        7 : grid = grid - H12 - H14 - H15 - H17 - H04;
        8 : grid = grid - H04;
        9 : grid = grid - H15 - H17 - H04;
        10 : grid = grid - H01 - H02 - H04 - H05 - H07 - H14;
        11 : grid = grid - H11 - H12 - H14 - H15 - H17 - H01 - H02 - H04 - H05 - H07;
        12 : grid = grid - H12 - H16 - H01 - H02 - H04 - H05 - H07;
        13 : grid = grid - H01 - H02 - H04 - H05 - H07 - H12 - H15;
        14 : grid = grid - H01 - H02 - H04 - H05 - H07 - H11 - H15 - H17;
        15 : grid = grid - H01 - H02 - H04 - H05 - H07 - H13 - H15;
        16 : grid = grid - H01 - H02 - H04 - H05 - H07 - H13;
        17 : grid = grid - H01 - H02 - H04 - H05 - H07 - H12 - H14 - H15 - H17;
        18 : grid = grid - H01 - H02 - H04 - H05 - H07;
        19 : grid = grid - H01 - H02 - H04 - H05 - H07 - H15 - H17;
        20 : grid = grid - H02 - H06 - H14;
        21 : grid = grid - H11 - H12 - H14 - H15 - H17 - H02 - H06;
        22 : grid = grid - H12 - H16 - H02 - H06;
        23 : grid = grid - H02 - H06 - H12 - H15;
        24 : grid = grid - H02 - H06 - H11 - H15 - H17;
    endcase
end  
endmodule
