module Multiplexer_6bit(
    input [5:0] J, 
    input [5:0] K,
    input [5:0] L, 
    input [5:0] M,
    input [1:0] S,
    output reg [5:0]Y
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
