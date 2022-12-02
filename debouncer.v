`timescale 1ns / 1ps

module debouncer(
    input clk, resetn, button_in,
    output reg button_out
    );
    
    reg output_exist, deb_count_start;
    reg [2:0]deb_count; // Change bus for simulations (3 bits [2:0]) and for testing FPGA (16 bits [15:0])
    
    always@(posedge clk or negedge resetn) begin
        if (!resetn) begin 
            button_out <= 0;
            deb_count_start <= 0;
            deb_count <= 0;
            output_exist <= 0;
        end else begin
            if (button_in == 1 & output_exist == 0) begin
                if (deb_count == 3'b001) begin // Change MAX value for simulations (1) and for testing FPGA (40000)
                    button_out <= 1;
                    deb_count_start <= 0;
                    deb_count <= 0;
                    output_exist <= 1;
                end else if (deb_count_start == 0) begin
                    deb_count_start <= 1;
                    deb_count <= deb_count + 1'b1;
                end else begin
                    deb_count <= deb_count + 1'b1;
                end              
            end else if (button_in == 1 & output_exist == 1) begin
                button_out <= 0;
            end else if (button_in == 0) begin
                output_exist <= 0;
                deb_count_start <= 0;
                deb_count <= 0;
                button_out <= 0;
            end 
        end // else block after reset
    end // always 
endmodule
