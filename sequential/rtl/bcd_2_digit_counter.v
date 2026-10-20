module bcd_2_digit_counter(reset,clk,tens,units);

input reset,clk;
output reg [3:0]tens,units;

always@(posedge clk)
	begin
		if(reset)
			{tens,units}=0;
			else if(units==9)
				begin
					units=0;
					if(tens==9)
						tens=0;
					else
						tens=tens+1;
				end  
		else
			units=units+1;
	end

endmodule   