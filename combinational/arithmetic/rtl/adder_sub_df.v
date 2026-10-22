module adder_sub_df(a,b,cin,sum,cout);

input [3:0]a,b;
input cin;
output [3:0]sum;
output cout;
wire [3:0]modified_b;
rca_4_bit_df block(a,modified_b,cin,sum,cout);

assign modified_b=cin?~b:b;

endmodule
