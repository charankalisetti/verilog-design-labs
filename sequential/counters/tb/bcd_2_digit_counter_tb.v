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
endtask		
	
initial 
clock_gen();

initial
apply_reset();

initial begin
#100;
$finish;
end

endmodule