module dff_tb;

reg d,clk,reset;
wire q;
parameter cycle=10;

d_ff DUT(d,clk,reset,q);

task clock_gen;
begin
clk=0;
forever
begin
 #(cycle/2);
 clk<=~clk;
end
end
endtask

task apply_input;
input [1:0]in;
begin
 reset=in[1];
 d=in[0];
 #(cycle);
$display("reset=%b,d=%b",reset,d);
end
endtask 

task stimulus;
integer i;

begin:block
 for(i=0;i<=3;i=i+1)
begin
  apply_input(i);
$display("i=%d",i);
end
$finish;
end
endtask

initial
  clock_gen();
initial
  stimulus();

endmodule
