`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2022 04:47:24 PM
// Design Name: 
// Module Name: top
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


module top(
    input wire CLK,
    input wire RST_BTN,
    input wire[5:0] seconds,
    input wire[5:0] minutes,
    input wire[4:0] hours, 
    output wire VGA_HS_O,       // horizontal sync output
    output wire VGA_VS_O,        // vertical sync output
    output wire [3:0] VGA_R
    );
    top_square t1(CLK, RST_BTN, seconds, minutes, hours, VGA_HS_O, VGA_VS_O, VGA_R, VGA_G, VGA_B);
endmodule
