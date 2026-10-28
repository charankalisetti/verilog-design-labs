 module bidir_shift_register_4bit_tb;
 
reg clk,reset,sr_in,sl_in;
reg [1:0]mode;
reg [3:0]D;
wire so_left,so_right;

bidir_shift_register_4bit DUT(clk,reset,mode,sr_in,sl_in,D,so_left,so_right);

task clock_gen;
	begin
		clk=0;
		forever #5 clk=~clk;
	end
endtask

task apply_reset;
	begin	
		reset=0;
		sr_in=0;
		sl_in=0;
                D=0;
		@(negedge clk)
		reset=1;
		@(negedge clk)
		reset=0;
	end
endtask

task apply_stimulus;
	begin
		repeat(14)
			begin
			    @(negedge clk)
				mode=1;
				sr_in=$random;// Fix: Automatically takes a random 1-bit value (0 or 1)
			end
        repeat(7)
			begin
			    @(negedge clk)
				mode=2;
				sl_in=$random;
			end
        repeat(7)
			begin	
				@(negedge clk)
				mode=0;
			end
		repeat(7)
			begin
				@(negedge clk)
				mode=3;
				D={$random}%16; 
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




/// Print exactly at the positive edge of the clock
    always @(posedge clk)
    begin
        $strobe("Posedge at Time=%0t | rst=%b mode=%b sr=%b sl=%b D=%b | Internal Reg=%b | so_left=%b so_right=%b", 
                 $time, reset, mode, sr_in, sl_in, D, DUT.shift_reg, so_left, so_right);
    end

    // Print exactly at the negative edge of the clock
    always @(negedge clk) 
    begin
        $strobe("Negedge at Time=%0t | rst=%b mode=%b sr=%b sl=%b D=%b | Internal Reg=%b | so_left=%b so_right=%b", 
                 $time, reset, mode, sr_in, sl_in, D, DUT.shift_reg, so_left, so_right);
    end



initial
	begin
		#500;
		$finish;
	end
	
endmodule	
		