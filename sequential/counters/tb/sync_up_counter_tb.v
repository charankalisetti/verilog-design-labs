module sync_counter_up_tb;

reg [3:0]in;
reg load,reset,clk;
wire [3:0]count;

sync_up_counter dut(in,load,clk,reset,count);

task gen_clk;
begin
clk=0;
forever #5 clk=~clk;
end
endtask

// apply input at neg edge
task apply_input;
input rst,ld;
input [3:0]data;

 begin
 @(negedge clk);
  reset=rst;
  load=ld;
  in=data;
 end
endtask

initial 
begin:block
 integer i,j,k,y;
 reset = 1;
    load  = 0;
    in    = 0;

@(posedge clk);
#1;
reset =0;
for(i=0;i<=1;i=i+1)
 begin
  for(j=0;j<=1;j=j+1)
   begin
   for(k=0;k<=15;k=k+1)
    begin
	 apply_input(i,j,k);
	 @(posedge clk);
	 #1;
	 apply_input(0,0,k);
	
	  repeat(15-k)
	   begin
	    @(posedge clk)
	    #1
	    $display("reset=%b, load=%b, input=%b=>%d, count=%d",reset,load,in,in,count);
	   end
    end
   end 
 end
 $finish;
end 

initial 
gen_clk();

endmodule