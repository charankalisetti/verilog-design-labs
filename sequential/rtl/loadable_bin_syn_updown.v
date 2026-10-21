module loadable_bin_syn_updown(reset,load,in_data,dir,clk,count);

input reset,load,dir,clk;
input [3:0]in_data;
output reg [3:0]count;

always@(posedge clk)
begin
	if(reset)
		count=0;
		else if(load&&(in_data<=15))
			count=in_data;
			else if(dir)
				count=count+1;
				else
					count=count-1;
end

endmodule					