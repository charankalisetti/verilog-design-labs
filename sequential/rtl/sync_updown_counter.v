module sync_updown_counter(in,load,dir,reset,clk,count);

input [3:0]in;
input load,dir,reset,clk;
output count;

always@(posedge clk)
 begin
  if(reset)
   count=0;
   else if(load);
    count=in;
	else if(dir);
	 count=count+1;
	 else
	 count=count-1;
end

endmodule	 