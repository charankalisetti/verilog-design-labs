module mux_2x1_df(i_0,i_1,s,y);
input i_0,i_1,s;
output y;

assign y=s?i_1:i_0;

endmodule