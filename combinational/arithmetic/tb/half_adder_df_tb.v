//creat testbench module

module half_adder_df_tb;

/*declare signals for DUT inputs
my DUT has a,b 
the testbench needs to control them*/

reg a_tb;
reg b_tb;
wire sum_tb;
wire carry_tb;
/*instantiate DUT
DUT_name instance_name(.port(signal),.port(sigal));*/
half_adder_df DUT(.a(a_tb),.b(b_tb),.sum(sum_tb),.carry(carry_tb));
integer i;
initial begin
 for(i=0;i<=4;i=i+1)
  begin
   {a_tb,b_tb}=i;
   #10;
  end
$finish;
end
endmodule