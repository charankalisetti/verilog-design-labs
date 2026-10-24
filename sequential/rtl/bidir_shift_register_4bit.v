 /*Design a 4-bit bidirectional shift register with synchronous active-high reset and mode controls.
Mode 00 = hold,
01 = shift right with serial input sr entering Q3,
10 = shift left with serial input sl entering Q0,
and 11 = parallel load D.
(a) Give the next-state expression for each mode. (3 marks)
(b) Write synthesizable Verilog RTL. (5 marks) 
(c)Starting at Q=1010, find Q after four rising edges for these successive (mode, input) operations: 
(01, sr=1), 
(10,sl=0),
(11, D=0110),
(00). (2 marks)	 


*/

module bidir_shift_register_4bit(clk,reset,mode,sr_in,sl_in,D,so_left,so_right);

parameter hold=2'b00,shift_right=2'b01,shift_left=2'b10,parallel_load=2'b11;

input clk,reset,sr_in,sl_in;
input [1:0]mode;
input [3:0]D;
output wire so_left,so_right;

reg [3:0]shift_reg;

always@(posedge clk)
	begin
		if(reset)
			shift_reg=0;
			else
				begin
					case(mode)
					hold:shift_reg<=shift_reg;
					shift_right:shift_reg<={sr_in,shift_reg[3:1]};
					shift_left:shift_reg<={shift_reg[2:0],sl_in};
					parallel_load:shift_reg<=D;
					endcase
				end
	end


assign so_right=shift_reg[0];
assign so_left=shift_reg[3];


endmodule	

/*	

					   +-----------------------------------+
                       | 4-Bit Bidirectional Shift Register|
                       +-----------------------------------+
                       |                                   |
             clk  ---->| clk                               |
             rst  ---->| rst (Active-High)                 |
                       |                                   |
       mode[1:0]  ---->| mode                              |
                       |  00: Hold                         |
                       |  01: Shift Right                  |
                       |  10: Shift Left                   |
                       |  11: Parallel Load                |
                       |                                   |
           sr_in  ---->| sr_in (Shift Right Serial In)     |
           sl_in  ---->| sl_in (Shift Left Serial In)      |
          D[3:0]  ---->| D[3:0] (Parallel Data In)         |
                       |                                   |
                       |                           so_left |----> Serial Out Left  (Tapped from Q3)
                       |                          so_right |----> Serial Out Right (Tapped from Q0)
                       |                            Q[3:0] |====> Parallel Output
                       |                                   |
                       +-----------------------------------+
					 




             STAGE 3 (MSB)                           STAGE 2                                STAGE 1                             STAGE 0 (LSB)


           +-----------+                          +-----------+                          +-----------+                          +-----------+
    d0 --->| 11: load  |                   d0 --->| 11: load  |                   d0 --->| 11: load  |                   d0 --->| 11: load  |
     ----->| 10: Left  |                   ------>| 10: Left  |                   ------>| 10: Left  |                   sl --->| 10: sl(in)|
           |           |  +------+                |           |  +------+                |           |  +------+                |           |  +------+
sr+------->| 01: sr(in)|->| FF 3 |---Q3--+------->| 01: Right |->| FF 2 |---Q2--+------->| 01: Right |->| FF 1 |---Q1--+------->| 01: Right |->| FF 0 |---Q0--+---> Q0 (Out)
           |           |  +------+       |        |           |  +------+       |        |           |  +------+       |        |           |  +------+       |
  +------->| 00: Hold  |                 | +----->| 00: Hold  |                 | +----->| 00: Hold  |                 | +----->| 00: Hold  |                 |
  |        +-----------+                 | |      +-----------+                 | |      +-----------+                 | |      +-----------+                 |
  |                                      | |                                    | |                                    | |                                    |
  |--------------------------------------+ |------------------------------------+ |------------------------------------+ |------------------------------------+
                     (Hold Feedback)      |               (Hold Feedback)        |              (Hold Feedback loop)          |             (Hold Feedback loop)
  |                                      |                                      |                                        |
  |      (Left Shift Feedback from Q2)  |        (Left Shift Feedback from Q1) |       (Left Shift Feedback from Q0)     |
  +----------------------------------- |    +----------------------------------    +-------------------------------------+					 
  
  
  
  */