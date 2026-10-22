module loadable_bin_syn_updown_tb;

reg reset,load,dir,clk;
reg [3:0]in_data;
wire [3:0]count;

loadable_bin_syn_updown DUT(reset,load,in_data,dir,clk,count);

task clock_gen;
	begin
		clk=0;
		forever #5 clk=~clk;
	end
endtask

task apply_reset;
	begin
		load=0;
		dir=1;
		reset=0;
		in_data=0;
		@(negedge clk)
		reset=1;
		@(negedge clk)
		reset=0;
	end
endtask

task stimulus;
	begin
		@(negedge clk)
		load=1;
		in_data=5;
		@(negedge clk)
		load=0;
		repeat(10)
			begin
				dir=1;
			end
                repeat(10)
			begin
				dir=0;
			end
    end
endtask

initial
clock_gen();

initial
	begin
		apply_reset();
		stimulus();
	end

initial
	begin
		#100;
		$finish;
	end

endmodule	