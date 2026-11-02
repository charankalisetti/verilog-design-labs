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


/*
Design a two-digit BCD counter that counts 00 through 99 and repeats. Inputs are clk, active-high synchronous
reset rst, and enable en; outputs are tens[3:0] and ones[3:0].


Reset sets both digits to 0. With en=1, ones increments through 9; at ones=9 it wraps to 0 and tens increments. At
99, both digits wrap to 0. With en=0 both digits hold. One implementation:


module bcd_00_99(clk, rst, en,tens, ones);

input wire clk, rst, en,
output reg [3:0] tens, ones;


always @(posedge clk) 
  	begin
		if (rst) begin
			tens <= 4'd0;
			ones <= 4'd0;
			end else if (en) 
				begin
					if (ones == 4'd9) 
						begin
							ones <= 4'd0;
							if (tens == 4'd9) 
								tens <= 4'd0;
								else 
									tens <= tens + 4'd1;
						end 
					else 
						begin
							ones <= ones + 4'd1;
						end				
				end
	end
endmodule

            */