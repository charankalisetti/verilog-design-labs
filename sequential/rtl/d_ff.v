module d_ff(d,clk,reset,q);

input d,clk,reset;
output reg q;

always@(posedge clk)
begin
 if(reset)
  q<=1'b0;
  else
   q<=d;
end

endmodule
