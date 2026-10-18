module mux_4x1_using_bufif_decoder_df(i,s,y);
input [3:0]i;
input [1:0]s;
output y;
wire [3:0]en;

decoder_2x4_df dut(s[1],s[0],en[0],en[1],en[2],en[3]);

bufif1(y,i[0],en[0]);
bufif1(y,i[1],en[1]);
bufif1(y,i[2],en[2]);
bufif1(y,i[3],en[3]);

endmodule

