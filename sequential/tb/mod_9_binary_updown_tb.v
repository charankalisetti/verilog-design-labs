module mod_9_binary_updown_tb;

reg reset_low,clk,dir;
wire [3:0]count;

mod_9_binary_updown DUT(reset_low,dir,clk,count);

task clock_gen;
begin
clk=0;
forever #5 clk=~clk;
end
endtask

task reset;
 begin
 dir=0;
  @(negedge clk);
  reset_low=0;
  @(negedge clk);
  reset_low=1;
 end
endtask

task apply_Stimulus;
 begin
  repeat(20)
   begin
   @(negedge clk);
   dir=1;
  end

 repeat(20)
  begin
  @(negedge clk);
  dir=0;
  end
 end
endtask 

initial
  clock_gen();

initial
 begin
  reset();
  apply_Stimulus();
 end  
  
endmodule
