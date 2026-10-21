module mod_12_up_counter_tb;

reg [3:0]in;
reg load,reset,clk;
wire [3:0]count;

mod_12_up_counter DUT(in,load,reset,clk,count);

task clock_gen;
	begin
		clk=0;
		forever #5 clk=~clk;
	end
endtask

task apply_reset;
	begin
		reset=0;
		load=0;
                in=0;
		@(negedge clk)
		reset=1;
		@(negedge clk)
		reset=0;
	end
endtask

task stimulus;
	begin
		repeat(20)
			begin
				@(posedge clk);
				load=0;
			end
			
		@(negedge clk);
		load=1;
		in=5;
		@(negedge clk);
		load=0;
	
	end	
endtask

initial 
clock_gen();

initial
apply_reset();

initial
stimulus();

initial begin
	#500;
	$finish;
end

endmodule	
