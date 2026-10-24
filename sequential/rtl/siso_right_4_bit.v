module siso_right_4_bit(clk,reset,sin,sout)

input clk,reset,sin;
output wire sout;

reg [3:0]shift_reg;

always@(posedge clk)
	begin
		if(reset)
			begin
				sout=0;
				shift_reg=0;
				end
		else
			shift_reg={sin,[3:1]shift_reg}
	end

assign sout=shift_reg[0];

endmodule


/*     ========================================================================
     * RTL DESIGN NOTE: AVOIDING ACCIDENTAL 5-BIT SHIFT REGISTERS
     * ========================================================================
     * 
     * WHAT I DID WRONG IN MY ORIGINAL HANDWRITTEN CODE:
     * I declared a 4-bit internal register (`reg [3:0] q`) AND I updated 
     * `s_out <= q[0]` inside the clocked `always @(posedge clk)` block. 
     * 
     * WHAT I LEARNED ABOUT HARDWARE INFERENCE:
     * Every variable assigned with `<=` inside a clocked always block 
     * generates a physical Flip-Flop in hardware. 
     * 
     * By doing this, I accidentally created 5 Flip-Flops:
     *   - 4 Flip-Flops for `q[3:0]`
     *   - 1 additional Flip-Flop for `s_out`
     * 
     * THE RESULTING DELAY (5 CLOCK CYCLES):
     * It took 4 clock edges for the input `s_in` to travel through q[3], q[2], 
     * q[1], and q[0]. Then, it took a 5th clock edge to move the data from 
     * q[0] into the `s_out` register. This made it a 5-bit shift register 
     * instead of a 4-bit shift register.
     * 
     * THE FIX FOR A TRUE 4-BIT SHIFT REGISTER:
     * Approach 1: Use a 3-bit internal register (`reg [2:0] q`) and let 
     *             `s_out` act as the 4th clocked Flip-Flop.
     * Approach 2: Keep `q` as 4 bits, but do NOT clock `s_out`. Instead, use 
     *             a continuous wire connection outside the always block: 
     *             `assign s_out = q[0];`
     * ========================================================================
     

				   
				   
				   
				   
        +-------+    +-------+    +-------+    +-------+    +-------+
 s_in   |       |    |       |    |       |    |       |    |       |  s_out
------->|D  q[3]|--->|D  q[2]|--->|D  q[1]|--->|D  q[0]|--->|D s_out|------->
        |   (Q) |    |   (Q) |    |   (Q) |    |   (Q) |    |   (Q) |
        +-------+    +-------+    +-------+    +-------+    +-------+
         Cycle 1      Cycle 2      Cycle 3      Cycle 4      Cycle 5	
		 
		 
		                   
                                         
        +-------+       +-------+       +-------+       +-------+
 s_in   |       |       |       |       |       |       |       |  s_out
------->|D  q[3]|------>|D  q[2]|------>|D  q[1]|------>|D  q[0]|=======>>
        |   (Q) |       |   (Q) |       |   (Q) |       |   (Q) | (Wire)
        +-------+       +-------+       +-------+       +-------+
         Cycle 1         Cycle 2         Cycle 3         Cycle 4				   
				   

				   
		 */