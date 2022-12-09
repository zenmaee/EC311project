`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2022 07:20:08 PM
// Design Name: 
// Module Name: project_VGA_top
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
//////////////////////////////////////////////////////////////////////////////////


module project_VGA_top(
    input hour_in, min_in, sec_in,
    input mode_in, start_stop, reset_top, reset_VGA,
    input S0, S1,
    input clk_100MHz,
    output wire VGA_HS, 
    output wire VGA_VS,
    output wire [3:0] VGA_R
    );
    
    wire [4:0] w_ptop_hour_out;
    wire [5:0] w_ptop_min_out, w_ptop_sec_out;
    
    project_top PROJECTTOP_TOP(.clk_100MHz(clk_100MHz), .resetn(reset_top), .hour_in(hour_in), .min_in(min_in), .sec_in(sec_in), .mode_in(mode_in), 
                                .start_stop(start_stop), .S0(S0), .S1(S1), .hour_out(w_ptop_hour_out), .min_out(w_ptop_min_out), .sec_out(w_ptop_sec_out));
                                
    top_square TOPSQUARE_TOP(.CLK(clk_100MHz), .RST_BTN(reset_VGA), .hours(w_ptop_hour_out), .minutes(w_ptop_min_out), .seconds(w_ptop_sec_out), .mode({S0, S1}),
                                .VGA_HS_O(VGA_HS), .VGA_VS_O(VGA_VS), .VGA_R(VGA_R));
    
endmodule
