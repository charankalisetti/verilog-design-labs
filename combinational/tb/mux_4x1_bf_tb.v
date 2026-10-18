module mux_4x1_bf_tb;

reg [3:0]i;
reg [1:0]s;
wire y;
 
mux_4x1_bf dut(i,s,y);

task apply_input;
 input [1:0]x;
 input [3:0]z;
 begin
  s=x;
  i=z;
  #5;
 end
endtask

initial
 begin:block1
 integer sel,data;
 for(sel=0;sel<=3;sel=sel+1)
  begin
  for(data=0;data<=15;data=data+1)
   begin
    apply_input(sel,data);
 end
 end
    $finish;
 end
endmodule 
	
  
   