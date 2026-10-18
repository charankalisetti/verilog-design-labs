module priority_encoder_df(i,y,vaild);

input [7:0]i;
output [2:0]y;
output vaild;
wire [7:0]w;

priority_circuit_df block0(i,w);
encoder_8x3_df block1(w,y);

assign vaild=i?1'b1:1'b0;

endmodule
