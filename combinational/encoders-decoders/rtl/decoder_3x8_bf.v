module decoder_3x8_bf(i,en,y);

input [2:0]i;
input en;
output reg [7:0]y;

always@(*)
 begin
 if(en)
 begin
  case(i)
   0:y=8'd1;
   1:y=8'd2;
   2:y=8'd4;
   3:y=8'd8;  
   4:y=8'd16;
   5:y=8'd32;
   6:y=8'd64;
   7:y=8'd128;
   endcase
   end
   else
    y=0;
 end 
endmodule
   