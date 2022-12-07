`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2022 11:22:22 AM
// Design Name: 
// Module Name: timer_top
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


module stopwatch_top(
        input resetn,
        input start_stop, mode_in,
        input clk_100MHz, // assuming each module instantiates their own clock divider
        output [4:0] hour_out,
        output [5:0] min_out, sec_out
    );
    
    wire db_hour_button_out,db_min_button_out, db_sec_button_out; // debouncer wires
    wire clk_1Hz; // clock wires
    
    clock_1Hz clk_divider_100Mto1(.clk(clk_100MHz), .out_clk(clk_1Hz));
    
    stopwatch stopwatch(.clk_1Hz(clk_1Hz), .resetn(resetn), .start_stop(start_stop), .mode_in(mode_in), .hour_out(hour_out), .min_out(min_out), .sec_out(sec_out));
                    
endmodule
