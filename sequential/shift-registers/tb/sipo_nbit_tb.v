module sipo_nbit_tb;

reg clk,reset,data_in,shift_en;
wire [3:0]data_out;

sipo_nbit DUT(clk,reset,data_in,data_out,shift_en);

task clock_gen;
	begin
		clk=0;
		forever #5 clk=~clk;
	end
endtask

task apply_reset;
	begin
		reset=0;
		data_in=0;
		@(negedge clk)
		reset=1;
		@(negedge clk)
		reset=0;
	end
endtask

task apply_stimulus;
	begin
		repeat(16)
			begin
                           @(negedge clk)
				shift_en=1;
				data_in=$random;
			end
		repeat(5)
			begin
                            @(negedge clk)
				shift_en=0;
			end
	end
endtask

initial 
clock_gen();

initial
	begin
		apply_reset();
		apply_stimulus();
	end

initial
	begin
		#1000;
		$finish;
	end
endmodule	