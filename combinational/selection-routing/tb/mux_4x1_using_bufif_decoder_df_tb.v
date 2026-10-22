module mux_4x1_using_bufif_decoder_df_tb;
reg [3:0]i;
reg [1:0]s;
wire y;
integer k,j;
mux_4x1_using_bufif_decoder_df DUT(i,s,y);
initial
 begin
  for(k=0;k<4;k=k+1)
   begin
    s=j;
	for(j=0;j<16;j=j+1)
	 begin
	  i=j;
      #5;	 
	 end 
   end
   $finish;
 end
endmodule 