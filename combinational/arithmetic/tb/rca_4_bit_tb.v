module rca_4_bit_tb;
reg [3:0]a,b;
reg cin;
wire [3:0]sum;
wire cout;
integer i,j;

rca_4_bit_df DUT(a,b,cin,sum,cout);
initial
 begin
 cin=1'b0;
  for(i=0;i<=15;i=i+1)
   begin
    a=i;
	for(j=0;j<=15;j=j+1)
	 begin
	  b=j;
	  #2;
	 end
   end
   $finish;   
 end
endmodule