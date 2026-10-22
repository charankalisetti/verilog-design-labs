module mod_9_binary_updown_tb;

reg reset_low,clk,dir;
// Mistake:
// I forgot to declare 'count' in my testbench.
// Verilog implicitly (declared it) or (treated 'count') as a 1-bit wire instead of a 4-bit signal.
// As a result, the 4-bit counter output was connected to a 1-bit signal.

// What I learned:
// 1. Always declare signals used in module instantiations.
// 2. Ensure the testbench signal width matches the corresponding module port width.
// 3. For a 4-bit counter output, declare: wire [3:0] count;
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

initial
begin
    #1000;
    $finish;
end

endmodule
