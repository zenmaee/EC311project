`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2022 06:41:49 PM
// Design Name: 
// Module Name: project_top
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


module project_top(
    input hour_in, min_in, sec_in,
    input mode_in, start_stop, resetn,
    input S0, S1,
    input clk_100MHz,
    output reg [4:0] hour_out,
    output reg [5:0] min_out, sec_out
    );
    
    wire db_hour_button_out,db_min_button_out, db_sec_button_out; // debouncer wires
    wire clk_1Hz; // clock wires
    reg S0_reg, S1_reg;
    wire [4:0] w_timer_hour_out, w_stopwatch_hour_out, w_clk_12_out, w_clk_24_out;
    wire [5:0] w_timer_min_out, w_timer_sec_out, w_stopwatch_min_out, w_stopwatch_sec_out, 
                w_clk_12_min_out, w_clk_12_sec_out, w_clk_24_min_out, w_clk_24_out;
                
    assign S0 = S0_reg;
    assign S1 = S1_reg;
    
    clock_1Hz clk_divider_100Mto1(.clk(clk_100MHz), .out_clk(clk_1Hz));
    
    debouncer DB_Hour(.clk(clk_1Hz), .resetn(resetn), .button_in(hour_in), .button_out(db_hour_button_out));
    debouncer DB_Min(.clk(clk_1Hz), .resetn(resetn), .button_in(min_in), .button_out(db_min_button_out));
    debouncer DB_Sec(.clk(clk_1Hz), .resetn(resetn), .button_in(sec_in), .button_out(db_sec_button_out));
    
    timer_1 T_TIMER(.clk_1Hz(clk_1Hz), .resetn(resetn), .start_stop(start_stop), .mode_in(mode_in), .hour_in(db_hour_button_out), .min_in(db_min_button_out), 
                    .sec_in(db_sec_button_out), .hour_out(w_timer_hour_out), .min_out(w_timer_minute_out), .sec_out(w_timer_second_out));
    stopwatch T_STOPWATCH(.clk_1Hz(clk_1Hz), .resetn(resetn), .start_stop(start_stop), .mode_in(mode_in), .hour_out(w_stopwatch_hour_out), 
                     .min_out(w_stopwatch_minute_out), .sec_out(w_stopwatch_second_out)); // NO INPUTS FOR STOPWATCH
    clock_12hour T_CLK12HOUR(.clk_1Hz(clk_1Hz), .resetn(resetn), .start_stop(start_stop), .mode_in(mode_in), .hour_in(db_hour_button_out), .min_in(db_min_button_out), 
                    .sec_in(db_sec_button_out), .hour_out(w_clk_12_hour_out), .min_out(w_clk_12_min_out), .sec_out(w_clk_12_sec_out));
    clock_24hour T_CLK24HOUR(.clk_1Hz(clk_1Hz), .resetn(resetn), .start_stop(start_stop), .mode_in(mode_in), .hour_in(db_hour_button_out), .min_in(db_min_button_out), 
                    .sec_in(db_sec_button_out), .hour_out(w_clk_24_hour_out), .min_out(w_clk_24_min_out), .sec_out(w_clk_24_sec_out));
                    
    always@(*) begin // HOUR MUX - need to change signals in sensitivity list?
        case({S0_reg, S1_reg}) 
            2'b00: hour_out <= w_timer_hour_out;
            2'b01: hour_out <= w_stopwatch_hour_out;
            2'b10: hour_out <= w_clk_12_hour_out;
            2'b11: hour_out <= w_clk_24_hour_out;
        endcase
    end
    
    always@(*) begin // MINUTE MUX - need to change signals in sensitivity list?
        case({S0_reg, S1_reg}) 
            2'b00: min_out <= w_timer_min_out;
            2'b01: min_out <= w_stopwatch_min_out;
            2'b10: min_out <= w_clk_12_min_out;
            2'b11: min_out <= w_clk_24_min_out;
        endcase
    end
    
    always@(*) begin // SECOND MUX - need to change signals in sensitivity list?
        case({S0_reg, S1_reg}) 
            2'b00: sec_out <= w_timer_sec_out;
            2'b01: sec_out <= w_stopwatch_sec_out;
            2'b10: sec_out <= w_clk_12_sec_out;
            2'b11: sec_out <= w_clk_24_sec_out;
        endcase
    end
    
endmodule
