module decoder_2x4_df(s_1,s_0,i_0,i_1,i_2,i_3);
input s_1,s_0;
output i_0,i_1,i_2,i_3;

assign i_0=~s_1&~s_0;
assign i_1=~s_1&s_0;
assign i_2=s_1&~s_0;
assign i_3=s_1&s_0;

endmodule