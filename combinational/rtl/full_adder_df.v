module full_adder_df(a,b,cin,sum,carry);
input a,b,cin;
output sum,carry;

assign sum=a^b^cin;
assign carry=a&b|cin&(a^b);

endmodule