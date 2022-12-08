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


module top_digital_clock(
        input resetn,
        input hour_in, min_in, sec_in,
        input start_stop, mode_in,
        input [1:0] S,
        input clk_100MHz, // assuming each module instantiates their own clock divider
        output [4:0] hour_out,
        output [5:0] min_out, sec_out
    );
    
    wire db_hour_button_out,db_min_button_out, db_sec_button_out; // debouncer wires
    wire clk_1Hz; // clock wires
    wire [4:0] timer_hour, stopwatch_hour, clk12_hour, clk24_hour;
    wire [5:0] timer_min, stopwatch_min, clk12_min, clk24_min;
    wire [5:0] timer_sec, stopwatch_sec, clk12_sec, clk24_sec;
    
    clock_1Hz clk_divider_100Mto1(.clk(clk_100MHz), .out_clk(clk_1Hz));
    
    debouncer DB_Hour(.clk(clk_1Hz), .resetn(resetn), .button_in(hour_in), .button_out(db_hour_button_out));
    debouncer DB_Min(.clk(clk_1Hz), .resetn(resetn), .button_in(min_in), .button_out(db_min_button_out));
    debouncer DB_Sec(.clk(clk_1Hz), .resetn(resetn), .button_in(sec_in), .button_out(db_sec_button_out));
    // CHANGE DEB TO 1 SEC CLK 1HZ *****************************
    
    
    clock_12hour clk12(.clk_1Hz(clk_1Hz), .resetn(resetn), .start_stop(start_stop), .mode_in(mode_in), .hour_in(db_hour_button_out), .min_in(db_min_button_out), 
                    .sec_in(db_sec_button_out), .hour_out(clk12_hour), .min_out(clk12_min), .sec_out(clk12_sec));
    clock_24hour clk24(.clk_1Hz(clk_1Hz), .resetn(resetn), .start_stop(start_stop), .mode_in(mode_in), .hour_in(db_hour_button_out), .min_in(db_min_button_out), 
                    .sec_in(db_sec_button_out), .hour_out(clk24_hour), .min_out(clk24_min), .sec_out(clk24_sec));
    stopwatch stopwatch(.clk_1Hz(clk_1Hz), .resetn(resetn), .start_stop(start_stop), .mode_in(mode_in), .hour_out(stopwatch_hour), .min_out(stopwatch_min), .sec_out(stopwatch_sec));
    timer Timer(.clk_1Hz(clk_1Hz), .resetn(resetn), .start_stop(start_stop), .mode_in(mode_in), .hour_in(db_hour_button_out), .min_in(db_min_button_out), 
                    .sec_in(db_sec_button_out), .hour_out(timer_hour), .min_out(timer_min), .sec_out(timer_sec));
    
    Multiplexer_5bit hour(.J(stopwatch_hour), .K(timer_hour), .L(clk12_hour), .M(clk24_hour), .S(S), .Y(hour_out));
    Multiplexer_6bit min(.J(stopwatch_min), .K(timer_min), .L(clk12_min), .M(clk24_min), .S(S), .Y(min_out));
    Multiplexer_6bit sec(.J(stopwatch_sec), .K(timer_sec), .L(clk12_sec), .M(clk24_sec), .S(S), .Y(sec_out));
    

endmodule
