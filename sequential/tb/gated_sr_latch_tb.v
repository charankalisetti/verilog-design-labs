module gated_sr_latch_tb;

reg s,r,en;
wire q,qc;

gated_sr_latch dut(s,r,en,q,qc);

initial
 begin:block
  integer i,j;
  for(i=0;i<=1;i=i+1)
   begin
    en=i;
   for(j=0;j<=3;j=j+1)
    begin
    {s,r}=j;
    #5;
    end
   end
$finish;
 end

endmodule 
  