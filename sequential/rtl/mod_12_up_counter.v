module mod_12_up_counter(in,load,reset,clk,count);

input [3:0]in;
input load,reset,clk;
output reg [3:0]count;

always@(posedge clk)
 begin
  if(reset)
   count=0;
   else if(load&&(in<=11))
    count=in;
	 else if(count==11)
	  count=0;
	   else
	    count=count+1;
end

endmodule		
		
