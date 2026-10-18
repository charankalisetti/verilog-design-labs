module priority_circuit_df(a,i);
input [7:0]a;
output [7:0]i;

assign i[7]=a[7];
assign i[6]=~a[7]&a[6];
assign i[5]=~a[7]&~a[6]&a[5];
assign i[4]=~a[7]&~a[6]&~a[5]&a[4];
assign i[3]=~a[7]&~a[6]&~a[5]&~a[4]&a[3];
assign i[2]=~a[7]&~a[6]&~a[5]&~a[4]&~a[3]&a[2];
assign i[1]=~a[7]&~a[6]&~a[5]&~a[4]&~a[3]&~a[2]&a[1];
assign i[0]=~a[7]&~a[6]&~a[5]&~a[4]&~a[3]&~a[2]&~a[1]&a[0];

endmodule