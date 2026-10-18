module jk_ff (j,k,sreset,clk,q,qc);

input j,k,sreset,clk;
output reg q;
output wire qc;
parameter hold=2'b00,toggle=2'b11,set=2'b10,reset=2'b01;

always@(posedge clk)
begin
 if(sreset)
  q=0;
  else
   begin
    case({j,k})
	 hold:q<=q;
	 toggle:q<=~q;
	 set:q<=1;
	 reset:q<=0;
	endcase
end
end
assign qc=~q;
endmodule	