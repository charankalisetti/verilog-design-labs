module full_adder_df_tb;
reg a_tb,b_tb,cin_tb;
wire sum_tb,carry_tb;
integer i;
full_adder_df dut(.a(a_tb),.b(b_tb),.cin(cin_tb),.sum(sum_tb),.carry(carry_tb));
initial 
begin
 for(i=0;i<=8;i=i+1)
  begin
   {a_tb,b_tb,cin_tb}=i;
   #10;
  end
   $finish;
end
endmodule  

