`timescale 1ns / 1ps

module clock_1Hz(
    input clk, /* 1Mhz clock */
    output reg out_clk = 0
    );
    reg [31:0]count = 32'd0;
    
    always@(posedge clk) begin 
        if (count == 32'd100000000) begin // for simulation (count == 32'd5) and for FPGA (count == 32'd100000000) 
            out_clk <= ~out_clk;
            count <= 0;
        end else begin
            count = count + 1;
        end
    end 
endmodule
