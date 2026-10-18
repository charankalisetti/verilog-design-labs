module decoder_2x4_df_tb;
reg s_0_tb,s_1_tb;
wire i_0_tb,i_1_tb,i_2_tb,i_3_tb;
integer i;
decoder_2x4_df DUT(.s_0(s_0_tb),.s_1(s_1_tb),.i_0(i_0_tb),.i_1(i_1_tb),.i_2(i_2_tb),.i_3(i_3_tb));
initial
 begin 
  for(i=0;i<=3;i=i+1)
   begin
   {s_0_tb,s_1_tb}=i;
   #10;
   end
$finish;  
 end
endmodule  
    