module bcd_2_digit_counter_tb;

reg reset,clk;
wire [3:0]tens,units;

bcd_2_digit_counter DUT(reset,clk,tens,units);

task clock_gen;
	begin
		clk=0;
		forever #5 clk=~clk;
	end
endtask

task apply_reset;
	begin
		reset=0;
		@(negedge clk);
		reset=1;
		@(negedge clk);
		reset=0;
	end	
			
initial begin
clock_gen();
initial begin
apply_reset();

endmodule