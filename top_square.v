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
    input wire[1:0] mode,
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
    wire H01, H02, H03, H04, H05, H06, H07, H11, H12, H13, H14, H15, H16, H17, C01, C02, M01, M02, M03, M04, M05, M06, M07, M11, M12, M13, M14, M15, M16, M17, C11, C12, S01, S02, S03, S04, S05, S06, S07, S11, S12, S13, S14, S15, S16, S17, A1, A2, A3, A4, AP, M1, M2, M3, M4, SP1, SP2, SP3, SP4, SP5, W1, W2, W3, W4, T1, T2, O1, TW01, TW02, TW03, TW04, TW05, TW11, TW12, TW13, TW14, TW15, F1, F2, F3;
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
    assign SP1 = ((x>40) & (y > 358) & (x<82) & (y<370)) ? 1:0;
    assign SP2 = ((x>40) & (y > 370) & (x<52) & (y<392)) ? 1:0;
    assign SP3 = ((x>40) & (y > 392) & (x<82) & (y<404)) ? 1:0;
    assign SP4 = ((x>70) & (y > 404) & (x<82) & (y<426)) ? 1:0;
    assign SP5 = ((x>40) & (y > 426) & (x<82) & (y<438)) ? 1:0;
    assign W1 = ((x>101) & (y > 358) & (x<113) & (y<438)) ? 1:0;
    assign W2 = ((x>144) & (y > 358) & (x<156) & (y<438)) ? 1:0;
    assign W3 = ((x>113) & (y > 426) & (x<144) & (y<438)) ? 1:0;
    assign W4 = ((x>124) & (y > 402) & (x<136) & (y<438)) ? 1:0;
    assign T1 = ((x>207) & (y > 358) & (x<285) & (y<370)) ? 1:0;
    assign T2 = ((x>240) & (y > 370) & (x<252) & (y<438)) ? 1:0;
    assign O1 = ((x>343) & (y > 358) & (x<355) & (y<438)) ? 1:0;
    assign TW01 = ((x>378) & (y > 358) & (x<427) & (y<370)) ? 1:0;
    assign TW02 = ((x>415) & (y > 370) & (x<427) & (y<392)) ? 1:0;
    assign TW03 = ((x>378) & (y > 392) & (x<427) & (y<404)) ? 1:0;
    assign TW04 = ((x>378) & (y > 404) & (x<390) & (y<426)) ? 1:0;
    assign TW05 = ((x>378) & (y > 426) & (x<427) & (y<438)) ? 1:0;
    assign TW11 = ((x>485) & (y > 358) & (x<534) & (y<370)) ? 1:0;
    assign TW12 = ((x>522) & (y > 370) & (x<534) & (y<392)) ? 1:0;
    assign TW13 = ((x>485) & (y > 392) & (x<534) & (y<404)) ? 1:0;
    assign TW14 = ((x>485) & (y > 404) & (x<497) & (y<426)) ? 1:0;
    assign TW15 = ((x>485) & (y > 426) & (x<534) & (y<438)) ? 1:0;
    assign F1 = ((x>555) & (y > 358) & (x<567) & (y<398)) ? 1:0;
    assign F2 = ((x>567) & (y > 383) & (x<586) & (y<398)) ? 1:0;
    assign F3 = ((x>586) & (y > 358) & (x<598) & (y<438)) ? 1:0;
    
    reg grid;
    assign VGA_R[3] = grid;
always @(*)begin
grid = H01 + H02+ H03+ H04+ H05+ H06+ H07+ H11+ H12+ H13+ H14+ H15+ H16+ H17+ C01+ C02+ M01+ M02+ M03+ M04+ M05+ M06+ M07+ M11+ M12+ M13+ M14+ M15+ M16+ M17+ C11+ C12+ S01+ S02+ S03+ S04+ S05+ S06+ S07+ S11+ S12+ S13+ S14+ S15+ S16+ S17 +SP1+ SP2+ SP3+ SP4+ SP5+ W1+ W2+ W3+ W4+ T1+ T2+ O1+ TW01+ TW02+ TW03+ TW04+ TW05+ TW11+ TW12+ TW13+ TW14+ TW15+ F1+ F2+ F3; // A1+ A2+ A3+ A4+ AP+ M1+ M2+ M3+ M4;
    case(seconds)
        6'd0 : grid = grid - S04 - S14;
        6'd1 : grid = grid - S11 - S12 - S14 - S15 - S17 - S04;
        6'd2 : grid = grid - S12 - S16 - S04;
        6'd3 : grid = grid - S12 - S15 - S04;
        6'd4 : grid = grid - S11 - S15 - S17 - S04;
        6'd5 : grid = grid - S13 - S15 - S04;
        6'd6 : grid = grid - S13 - S04;
        6'd7 : grid = grid - S12 - S14 - S15 - S17 - S04;
        6'd8 : grid = grid - S04;
        6'd9 : grid = grid - S15 - S17 - S04;
        6'd10 : grid = grid - S01 - S02 - S04 - S05 - S07 - S14;
        6'd11 : grid = grid - S11 - S12 - S14 - S15 - S17 - S01 - S02 - S04 - S05 - S07;
        6'd12 : grid = grid - S12 - S16 - S01 - S02 - S04 - S05 - S07;
        6'd13 : grid = grid - S01 - S02 - S04 - S05 - S07 - S12 - S15;
        6'd14 : grid = grid - S01 - S02 - S04 - S05 - S07 - S11 - S15 - S17;
        6'd15 : grid = grid - S01 - S02 - S04 - S05 - S07 - S13 - S15;
        6'd16 : grid = grid - S01 - S02 - S04 - S05 - S07 - S13;
        6'd17 : grid = grid - S01 - S02 - S04 - S05 - S07 - S12 - S14 - S15 - S17;
        6'd18 : grid = grid - S01 - S02 - S04 - S05 - S07;
        6'd19 : grid = grid - S01 - S02 - S04 - S05 - S07 - S15 - S17;
        6'd20 : grid = grid - S02 - S06 - S14;
        6'd21 : grid = grid - S11 - S12 - S14 - S15 - S17 - S02 - S06;
        6'd22 : grid = grid - S12 - S16 - S02 - S06;
        6'd23 : grid = grid - S02 - S06 - S12 - S15;
        6'd24 : grid = grid - S02 - S06 - S11 - S15 - S17;
        6'd25 : grid = grid - S02 - S06 - S13 - S15;
        6'd26 : grid = grid - S02 - S06 - S13;
        6'd27 : grid = grid - S02 - S06 - S12 - S14 - S15 - S17;
        6'd28 : grid = grid - S02 - S06;
        6'd29 : grid = grid - S02 - S06 - S15 - S17;
        6'd30 : grid = grid - S02 - S05 - S14;
        6'd31 : grid = grid - S11 - S12 - S14 - S15 - S17 - S02 - S05;
        6'd32 : grid = grid - S12 - S16 - S02 - S05;
        6'd33 : grid = grid - S02 - S05 - S12 - S15;
        6'd34 : grid = grid - S02 - S05 - S11 - S15 - S17;
        6'd35 : grid = grid - S02 - S05 - S13 - S15;
        6'd36 : grid = grid - S02 - S05 - S13;
        6'd37 : grid = grid - S02 - S05 - S12 - S14 - S15 - S17;
        6'd38 : grid = grid - S02 - S05;
        6'd39 : grid = grid - S02 - S05 - S15 - S17;
        6'd40 : grid = grid - S01 - S05 - S07 - S14;
        6'd41 : grid = grid - S11 - S12 - S14 - S15 - S17 - S01 - S05 - S07;
        6'd42 : grid = grid - S12 - S16 - S01 - S05 - S07;
        6'd43 : grid = grid - S01 - S05 - S07 - S12 - S15;
        6'd44 : grid = grid - S01 - S05 - S07 - S11 - S15 - S17;
        6'd45 : grid = grid - S01 - S05 - S07 - S13 - S15;
        6'd46 : grid = grid - S01 - S05 - S07 - S13;
        6'd47 : grid = grid - S01 - S05 - S07 - S12 - S14 - S15 - S17;
        6'd48 : grid = grid - S01 - S05 - S07;
        6'd49 : grid = grid - S01 - S05 - S07 - S15 - S17;
        6'd50 : grid = grid - S03 - S05 - S14;
        6'd51 : grid = grid - S11 - S12 - S14 - S15 - S17 - S03 - S05;
        6'd52 : grid = grid - S12 - S16 - S03 - S05;
        6'd53 : grid = grid - S03 - S05 - S12 - S15;
        6'd54 : grid = grid - S03 - S05 - S11 - S15 - S17;
        6'd55 : grid = grid - S03 - S05 - S13 - S15;
        6'd56 : grid = grid - S03 - S05 - S13;
        6'd57 : grid = grid - S03 - S05 - S12 - S14 - S15 - S17;
        6'd58 : grid = grid - S03 - S05;
        6'd59 : grid = grid - S03 - S05 - S15 - S17;
     endcase
     case(minutes)
        6'd0 : grid = grid - M04 - M14;
        6'd1 : grid = grid - M11 - M12 - M14 - M15 - M17 - M04;
        6'd2 : grid = grid - M12 - M16 - M04;
        6'd3 : grid = grid - M12 - M15 - M04;
        6'd4 : grid = grid - M11 - M15 - M17 - M04;
        6'd5 : grid = grid - M13 - M15 - M04;
        6'd6 : grid = grid - M13 - M04;
        6'd7 : grid = grid - M12 - M14 - M15 - M17 - M04;
        6'd8 : grid = grid - M04;
        6'd9 : grid = grid - M15 - M17 - M04;
        6'd10 : grid = grid - M01 - M02 - M04 - M05 - M07 - M14;
        6'd11 : grid = grid - M11 - M12 - M14 - M15 - M17 - M01 - M02 - M04 - M05 - M07;
        6'd12 : grid = grid - M12 - M16 - M01 - M02 - M04 - M05 - M07;
        6'd13 : grid = grid - M01 - M02 - M04 - M05 - M07 - M12 - M15;
        6'd14 : grid = grid - M01 - M02 - M04 - M05 - M07 - M11 - M15 - M17;
        6'd15 : grid = grid - M01 - M02 - M04 - M05 - M07 - M13 - M15;
        6'd16 : grid = grid - M01 - M02 - M04 - M05 - M07 - M13;
        6'd17 : grid = grid - M01 - M02 - M04 - M05 - M07 - M12 - M14 - M15 - M17;
        6'd18 : grid = grid - M01 - M02 - M04 - M05 - M07;
        6'd19 : grid = grid - M01 - M02 - M04 - M05 - M07 - M15 - M17;
        6'd20 : grid = grid - M02 - M06 - M14;
        6'd21 : grid = grid - M11 - M12 - M14 - M15 - M17 - M02 - M06;
        6'd22 : grid = grid - M12 - M16 - M02 - M06;
        6'd23 : grid = grid - M02 - M06 - M12 - M15;
        6'd24 : grid = grid - M02 - M06 - M11 - M15 - M17;
        6'd25 : grid = grid - M02 - M06 - M13 - M15;
        6'd26 : grid = grid - M02 - M06 - M13;
        6'd27 : grid = grid - M02 - M06 - M12 - M14 - M15 - M17;
        6'd28 : grid = grid - M02 - M06;
        6'd29 : grid = grid - M02 - M06 - M15 - M17;
        6'd30 : grid = grid - M02 - M05 - M14;
        6'd31 : grid = grid - M11 - M12 - M14 - M15 - M17 - M02 - M05;
        6'd32 : grid = grid - M12 - M16 - M02 - M05;
        6'd33 : grid = grid - M02 - M05 - M12 - M15;
        6'd34 : grid = grid - M02 - M05 - M11 - M15 - M17;
        6'd35 : grid = grid - M02 - M05 - M13 - M15;
        6'd36 : grid = grid - M02 - M05 - M13;
        6'd37 : grid = grid - M02 - M05 - M12 - M14 - M15 - M17;
        6'd38 : grid = grid - M02 - M05;
        6'd39 : grid = grid - M02 - M05 - M15 - M17;
        6'd40 : grid = grid - M01 - M05 - M07 - M14;
        6'd41 : grid = grid - M11 - M12 - M14 - M15 - M17 - M01 - M05 - M07;
        6'd42 : grid = grid - M12 - M16 - M01 - M05 - M07;
        6'd43 : grid = grid - M01 - M05 - M07 - M12 - M15;
        6'd44 : grid = grid - M01 - M05 - M07 - M11 - M15 - M17;
        6'd45 : grid = grid - M01 - M05 - M07 - M13 - M15;
        6'd46 : grid = grid - M01 - M05 - M07 - M13;
        6'd47 : grid = grid - M01 - M05 - M07 - M12 - M14 - M15 - M17;
        6'd48 : grid = grid - M01 - M05 - M07;
        6'd49 : grid = grid - M01 - M05 - M07 - M15 - M17;
        6'd50 : grid = grid - M03 - M05 - M14;
        6'd51 : grid = grid - M11 - M12 - M14 - M15 - M17 - M03 - M05;
        6'd52 : grid = grid - M12 - M16 - M03 - M05;
        6'd53 : grid = grid - M03 - M05 - M12 - M15;
        6'd54 : grid = grid - M03 - M05 - M11 - M15 - M17;
        6'd55 : grid = grid - M03 - M05 - M13 - M15;
        6'd56 : grid = grid - M03 - M05 - M13;
        6'd57 : grid = grid - M03 - M05 - M12 - M14 - M15 - M17;
        6'd58 : grid = grid - M03 - M05;
        6'd59 : grid = grid - M03 - M05 - M15 - M17;
    endcase
    case(hours)
        5'd0 : grid = grid - H04 - H14;
        5'd1 : grid = grid - H11 - H12 - H14 - H15 - H17 - H04;
        5'd2 : grid = grid - H12 - H16 - H04;
        5'd3 : grid = grid - H12 - H15 - H04;
        5'd4 : grid = grid - H11 - H15 - H17 - H04;
        5'd5 : grid = grid - H13 - H15 - H04;
        5'd6 : grid = grid - H13 - H04;
        5'd7 : grid = grid - H12 - H14 - H15 - H17 - H04;
        5'd8 : grid = grid - H04;
        5'd9 : grid = grid - H15 - H17 - H04;
        5'd10 : grid = grid - H01 - H02 - H04 - H05 - H07 - H14;
        5'd11 : grid = grid - H11 - H12 - H14 - H15 - H17 - H01 - H02 - H04 - H05 - H07;
        5'd12 : grid = grid - H12 - H16 - H01 - H02 - H04 - H05 - H07;
        5'd13 : grid = grid - H01 - H02 - H04 - H05 - H07 - H12 - H15;
        5'd14 : grid = grid - H01 - H02 - H04 - H05 - H07 - H11 - H15 - H17;
        5'd15 : grid = grid - H01 - H02 - H04 - H05 - H07 - H13 - H15;
        5'd16 : grid = grid - H01 - H02 - H04 - H05 - H07 - H13;
        5'd17 : grid = grid - H01 - H02 - H04 - H05 - H07 - H12 - H14 - H15 - H17;
        5'd18 : grid = grid - H01 - H02 - H04 - H05 - H07;
        5'd19 : grid = grid - H01 - H02 - H04 - H05 - H07 - H15 - H17;
        5'd20 : grid = grid - H02 - H06 - H14;
        5'd21 : grid = grid - H11 - H12 - H14 - H15 - H17 - H02 - H06;
        5'd22 : grid = grid - H12 - H16 - H02 - H06;
        5'd23 : grid = grid - H02 - H06 - H12 - H15;
    endcase
    if(mode == 2'b00)
        grid = grid - T1 - T2 - O1 - TW01 - TW02 - TW03 - TW04 - TW05 - TW11 - TW12 - TW13 - TW14 - TW15 - F1 - F2 - F3;
    else if(mode == 2'b01)
        grid = grid - O1 - TW01 - TW02 - TW03 - TW04 - TW05 - TW11 - TW12 - TW13 - TW14 - TW15 - F1 - F2 - F3 - SP1 - SP2 - SP3 - SP4 - SP5 - W1 - W2 - W3 - W4;
    else if(mode == 2'b10)
        grid = grid - SP1 - SP2 - SP3 - SP4 - SP5 - W1 - W2 - W3 - W4- T1 - T2- TW11 - TW12 - TW13 - TW14 - TW15 - F1 - F2 - F3;
    else if(mode == 2'b11)
        grid = grid - SP1 - SP2 - SP3 - SP4 - SP5 - W1 - W2 - W3 - W4- T1 - T2- O1 - TW01 - TW02 - TW03 - TW04 - TW05;
end  
endmodule
