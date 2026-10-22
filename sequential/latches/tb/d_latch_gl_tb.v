module d_latch_gl_tb;


reg d,en;

d_latch_gl dut(d,en,q,qc);

initial
 begin:block
  integer i;
  for(i=0;i<=3;i=i+1)
   begin
    {en,d}=i;
    #5;
    end
$finish;

 end

endmodule 
	