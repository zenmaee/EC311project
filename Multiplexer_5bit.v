`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2022 10:15:06 PM
// Design Name: 
// Module Name: Multiplexer_5bit
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


module Multiplexer_5bit(
    input [4:0] J, 
    input [4:0] K,
    input [4:0] L, 
    input [4:0] M,
    input [1:0] S,
    output reg [4:0]Y
    );
    always @ (J or K or L or M or S) begin
        case (S)
            2'b00 : Y <= J;
            2'b01 : Y <= K;
            2'b10 : Y <= L;
            2'b11 : Y <= M;
      endcase
   end
    
endmodule
