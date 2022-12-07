`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2022 05:36:07 PM
// Design Name: 
// Module Name: timer_top_testbench
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


module stopwatch_top_testbench(

    );
    
    reg clk_100MHz, resetn, mode_in, start_stop /* stop = 0, start = 1 */;
    wire [4:0] hour_out;
    wire [5:0] min_out, sec_out;
    
    stopwatch_top TB_stopwatch_module(.resetn(resetn), .clk_100MHz(clk_100MHz), .start_stop(start_stop), .mode_in(mode_in), .hour_out(hour_out), .min_out(min_out), .sec_out(sec_out));
                    
    always #1 clk_100MHz=~clk_100MHz; // instantiating clock
    initial begin
        clk_100MHz=0; // initialize clock 
        mode_in=0;
        start_stop=0;
        resetn=1; // active low reset activated
        
        #5 resetn=0; // negedge resetn
        #5 resetn=1;
        #5 start_stop=1; // countup starts
        /*#200 start_stop=0;
        #50 start_stop=1;*/
    end
endmodule
