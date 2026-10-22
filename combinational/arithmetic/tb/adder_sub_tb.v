module adder_sub_tb;

reg [3:0]a,b;
reg cin;
wire [3:0]sum;
wire cout;
integer i,j,k;

adder_sub_df DUT(a,b,cin,sum,cout);

initial
 begin
  for(i=0;i<=1;i=i+1)
   begin
    cin=i;
    for(j=0;j<=15;j=j+1)
     begin
      a=j;
      for(k=0;k<=15;k=k+1)
       begin
        b=k;
        #5;
       end
     end
   end
     $finish;
 end  
endmodule
