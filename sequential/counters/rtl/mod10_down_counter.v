module mod10_down_counter(clk,AAlreset,count);

input clk,AAlreset; // Active-low asynchronous reset
output reg [3:0]count;

always@(posedge clk,negedge AAlreset) 
	begin
		if(!AAlreset)
		// Reset state initializes to 9 (1001) for a down counter
			count<=9;
			else if(count==0 || count>9)
			// Wrap around from 0 back to 9
				// Safe recovery mechanism for unused/illegal states (10-15)
					count<=9;
					else 
					// Decrement the count
						count<=count-1;
	end

endmodule	
					
