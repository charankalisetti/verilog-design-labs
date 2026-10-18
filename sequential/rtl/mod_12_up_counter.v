module mod_12_up_counter(in,load,reset,count);

input [3:0]in;
input load,reset,clk;
output reg [3:0]count;

always@(posedge clk)
 begin
  if(reset)
   count=0;
   else if(load)
    count=in;
	 else if(count==12)
	  count=0;
	   else
	    count=count+1;
end

endmodule		
		
