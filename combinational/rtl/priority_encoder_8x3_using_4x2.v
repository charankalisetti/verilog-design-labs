module priority_encoder_8x3_using_4x2(i,y,vaild);

input [7:0]i;
output wire [2:0]y;
output wire vaild;
wire [3:0]w;
wire [1:0]v;

priority_encoder_4x2 pe1(i[7:4],1,w[3:2],v[1]);
priority_encoder_4x2 pe2(i[3:0],1,w[1:0],v[0]);

assign y[2]=v[1];
assign y[1]=w[3]|w[1];
assign y[0]=w[2]|w[0];
assign vaild=v[1]|v[0];

endmodule
