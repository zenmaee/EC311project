`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2022 04:58:36 PM
// Design Name: 
// Module Name: timer_1
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


module clock_24hour(
    input clk_1Hz, // from clock divider
    input start_stop, // switch
    input mode_in, // switch
    input hour_in, // from debouncer
    input min_in, // from debouncer
    input sec_in, // from debouncer
    input resetn, // active low (red)
    output [4:0] hour_out, 
    output [5:0] min_out, sec_out
    );
    
    localparam [1:0]
        STATE_IDLE = 2'b00,
        STATE_INPUT = 2'b01,
        STATE_COUNTUP = 2'b10;
        
    reg [1:0] state_reg, state_next;
    reg [4:0] hour_value_reg, hour_value_next; // goes up to 12 and 24
    reg [5:0] sec_value_reg, sec_value_next, min_value_reg, min_value_next; // goes up to 59
    // reg x_reg, x_next, y_reg, y_next;
    
    assign hour_out = hour_value_reg; // assigning reg to outputs
    assign min_out = min_value_reg;
    assign sec_out = sec_value_reg;
    
    always@(posedge clk_1Hz or negedge resetn) begin
        if (!resetn) begin
            state_reg <= STATE_IDLE;
            hour_value_reg <= 0;
            min_value_reg <= 0;
            sec_value_reg <= 0;
            //x_reg <= 0;
            //y_reg <= 0;
        end else begin 
            state_reg <= state_next;
            hour_value_reg <= hour_value_next;
            min_value_reg <= min_value_next;
            sec_value_reg <= sec_value_next;
            //x_reg <= x_next;
            //y_reg <= y_next;
        end
    end 
    
    always@(*) begin
        state_next = state_reg; // required for when no case statement is satisfied
        //x_next = 0;     // to hardcode x to this value if it is not assigned a value in a certain state
        //y_next = y_reg; // to remember the value of y  
        hour_value_next = hour_value_reg;
        min_value_next = min_value_reg;
        sec_value_next = sec_value_reg;
        
        case(state_reg) 
            STATE_IDLE:
            begin 
                state_next = STATE_IDLE;
                hour_value_next = 0;
                min_value_next = 0;
                sec_value_next = 0; // idle state values
                if ((mode_in == 1) & (start_stop == 0)) begin // if mode_in == 1 (input mode) - has priority over first statement
                    state_next = STATE_INPUT;                 // start_stop == 0 condition ensures start_stop is not activated before entering state_input
                    //y_next = 1;
                end
            end
            STATE_INPUT:
            begin
                state_next = STATE_INPUT;   
                if (start_stop) begin
                    state_next = STATE_COUNTUP; // clock starts
                end else if (!mode_in) begin
                    state_next = STATE_IDLE; // reset
                end
                   
                if (hour_in) begin
                    hour_value_next = hour_value_reg + 1;
                    if (hour_value_reg == 23) begin // for 24 hour clock
                        hour_value_next = 0;
                    end
                end
                
                if (min_in) begin
                    min_value_next = min_value_reg + 1;
                    if (min_value_reg == 59) begin
                        min_value_next = 0;
                            if (hour_value_reg == 12) begin // limit for 12 hour clock - incrementing min does not work if hour is at 12
                                min_value_next = 0;
                            end
                    end
                end
                
                if (sec_in) begin
                    sec_value_next = sec_value_reg + 1;
                    if (sec_value_reg == 59) begin
                        sec_value_next = 0;
                            if (hour_value_reg == 12) begin // for 12 hour timer
                                sec_value_next = 0;
                            end
                    end
                    //x_next = 1; 
                end
            end
            STATE_COUNTUP:
            begin
                state_next = STATE_COUNTUP;
                if (!mode_in) begin 
                    state_next = STATE_IDLE; // resets the clock
                end
                
                if (sec_value_reg == 6'd59) begin
                    sec_value_next = 0;
                    min_value_next = min_value_reg + 1;
                    if (min_value_reg == 6'd59) begin
                        sec_value_next = 0;
                        min_value_next = 0;
                        hour_value_next = hour_value_reg + 1;
                        if (hour_value_reg == 5'd23) begin
                            sec_value_next = 0;
                            min_value_next = 0;
                            hour_value_next = 0; // for 12 hour clock ******************************
                        end
                    end
                end else begin
                    sec_value_next = sec_value_reg + 1;
                end
            end
        endcase
    end
        
endmodule
