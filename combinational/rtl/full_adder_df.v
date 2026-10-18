module full_adder_df(a,b,cin,sum,carry);
input a,b,cin;
output sum,carry;

// Sum output is the XOR of all three input bits.
assign sum=a^b^cin;
// Carry-out is high when at least two inputs are high.
assign carry=a&b|cin&(a^b);

endmodule