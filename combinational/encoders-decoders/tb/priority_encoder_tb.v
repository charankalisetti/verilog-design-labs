module priority_encoder_tb;

reg [7:0]i;
wire [2:0]y;
wire valid;
integer j;

priority_encoder_df DUT(i,y,valid);
 
initial 
 begin
  for(j=0;j<=255;j=j+1)
   begin
    i=j;
	#1;
   end
   $finish;
 end
endmodule