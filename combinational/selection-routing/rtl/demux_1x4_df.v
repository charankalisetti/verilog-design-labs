module demux_1x4_df(i,out,s);

input i;
input [1:0]s;
output [3:0]out;

assign out[0]=(s==0)?i:0;
assign out[1]=(s==1)?i:0;
assign out[2]=(s==2)?i:0;
assign out[3]=(s==3)?i:0;

endmodule
