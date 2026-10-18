module priority_encoder_8x3_bf_tb;

reg [7:0]i_tb;
wire [2:0]y_tb;
wire vaild_tb;

priority_encoder_8x3_bf DUT(i_tb,y_tb,vaild_tb);

task apply_input;
input [7:0]x;
 begin
 i_tb=x;
 #5;
 end
endtask

initial
 begin:block
 integer i;
  for(i=0;i<=255;i=i+1)
   apply_input(i);
 end
endmodule 