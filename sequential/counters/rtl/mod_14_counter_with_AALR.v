/*Write a RTL & TB code for MOD 14 counter which counts from 3 to 16 with active low 
asynchronous reset. Upon reset, the counting should start from 3.*/

module mod_14_counter_with_AALR(AALReset,clk,count);

input AALReset,clk;
output reg [4:0]count;

always@(posedge clk or negedge AALReset)
	begin
		if(!AALReset)
			count=3;
			else if(count==16)
				count=3;
				else
					count=count+1;
	end

endmodule	