module mux_4x1_using_2x1_df_tb;
reg [3:0]i_tb;
reg [1:0]s;
wire y;
integer i,j;
mux_4x1_using_2x1_df DUT(i_tb,s,y);
initial 
 begin
  for(j=0;j<=3;j=j+1)
   begin
    s=j;
    #10;
	for(i=0;i<=15;i=i+1)
	 begin
	  i_tb=i;
          #10;
	 end
   end	
$finish;
 end 
endmodule