module mod_14_counter_with_AALR_tb;

reg AALReset,clk;
wire [4:0]count;

mod_14_counter_with_AALR DUT(AALReset,clk,count);

task clock_gen;
	begin
		clk=0;
		forever #5 clk=~clk;
	end
endtask	

task apply_reset;
	begin
		AALReset=1;
		#5;
		AALReset=0;
		#5;
		AALReset=1;
	end
endtask

initial
clock_gen();

initial begin
apply_reset();
#10;
apply_reset();
end

initial begin
#100;
$finish;
end

endmodule
 	
	