 module bidir_shift_register_4bit_tb;
 
reg clk,reset,sr_in,sl_in;
reg [1:0]mode;
reg [3:0]D;

bidir_shift_register_4bit DUT(clk,reset,mode,sr_in,sl_in,D,so_left,so_right);

task clock_gen;
	begin
		clk=0;
		forever clk=~clk;
	end
endtask

task apply_reset;
	begin	
		reset=0;
		sr_in=0;
		sl_in=0;
		@(negedge clk)
		reset=1;
		@(negedge clk)
		reset=0;
	end
endtask

task apply_stimulus;
	begin
		repeat(7)
			begin
			    @(posedge clk)
				mode=1;
				sr_in={$random}%2;
			end
        repeat(7)
			begin
			    @(posedge clk)
				mode=2;
				sl_in={$random}%2;
			end
        repeat(7)
			begin	
				@(posedge clk)
				mode=0;
			end
		repeat(7)
			begin
				@(posedge clk)
				mode=3;
				D={$random}%16
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
		#500;
		$finish;
	end
	
endmodule	
		