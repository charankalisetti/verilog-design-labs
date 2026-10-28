/*Write RTL to implement a FIFO for the below-mentioned specification:

A synchronous FIFO with a size 16x8 (8 bits wide & 16 bytes depth) supports simultaneous read and write operations.
Empty, Full are status signals based on the read or write operations.

Inputs: clock, reset(asynchronous active low), data_in, read_n and write_n Outputs: data_out, full, empty */

module sync_fifo(clk,aalreset,data_in,read_en,write_en,data_out,full,empty);

input clk,aalreset,read_en,write_en;
input [7:0]data_in;
output wire full,empty;
output reg [7:0]data_out;

reg [7:0]fifo[15:0];

reg [4:0]read_p,write_p;

assign empty=(read_p==write_p);
assign full=((read_p[4]!=write_p[4])&&(read_p[3:0]==write_p[3:0]));

always@(posedge clk or negedge aalreset)
	begin
		if(!aalreset)
			write_p<=0;
			
// Write when write_en is high (active) and FIFO is not FULL
			
			else if(!full&&write_en)
				begin
					fifo[write_p]<=data_in;
					write_p<=write_p+1;
				end	
	end

    // ---------------------------------------------------------
    // Read Logic & Read Pointer Update
    // ---------------------------------------------------------
always@(posedge clk or negedge aalreset)
	begin
		if(!aalreset)
			begin
				read_p<=0;
				data_out<=0;
			end

// Read when read_n is high (active) and FIFO is not EMPTY			
			
			else if(!empty&&read_en)
				begin
					data_out<=fifo[read_p];
					read_p<=read_p+1;
				end
	end		

endmodule	



/*

====================================================================
                  SCENARIO 1: FIFO IS EMPTY
====================================================================
Situation: You wrote 3 items, and then read all 3 items. 
Now, both pointers are resting on Slot 3 on the same lap.

WR Pointer: 5'b0_0011  --> (Lap 0, Slot 3)
RD Pointer: 5'b0_0011  --> (Lap 0, Slot 3)

         Slot 0   Slot 1   Slot 2   Slot 3   Slot 4 ...   Slot 15
        +--------+--------+--------+--------+--------+   +--------+
Memory: |        |        |        |        |        |...|        |
        +--------+--------+--------+--------+--------+   +--------+
                                       ^
                                       |
                              [ WR_PTR & RD_PTR ]
                             (Same Lap, Same Slot)

Hardware Logic:
Is WR[4] == RD[4]?         YES (0 == 0) -> Same Lap
Is WR[3:0] == RD[3:0]?     YES (3 == 3) -> Same Slot
Result: EMPTY = 1



====================================================================
                  SCENARIO 2: PARTIALLY FILLED (Normal)
====================================================================
Situation: Write adds more data and moves ahead to Slot 6. 
Read stays behind at Slot 3.

WR Pointer: 5'b0_0110  --> (Lap 0, Slot 6)
RD Pointer: 5'b0_0011  --> (Lap 0, Slot 3)

         Slot 0   Slot 1   Slot 2   Slot 3   Slot 4   Slot 5   Slot 6
        +--------+--------+--------+--------+--------+--------+--------+
Memory: |        |        |        |  DATA  |  DATA  |  DATA  |        |
        +--------+--------+--------+--------+--------+--------+--------+
                                       ^                          ^
                                       |                          |
                                    RD_PTR                     WR_PTR 

Hardware Logic: 
Pointers are at different slots. FIFO is neither Full nor Empty.



====================================================================
                  SCENARIO 3: FIFO IS FULL
====================================================================
Situation: Write keeps adding data, goes past Slot 15, and wraps 
around back to Slot 3 (starting Lap 1). Read is still stuck at 
Slot 3 on Lap 0. The FIFO is now completely packed with unread data.

WR Pointer: 5'b1_0011  --> (Lap 1, Slot 3)   <-- Notice the '1'
RD Pointer: 5'b0_0011  --> (Lap 0, Slot 3)

         Slot 0   Slot 1   Slot 2   Slot 3   Slot 4 ...   Slot 15
        +--------+--------+--------+--------+--------+   +--------+
Memory: |  DATA  |  DATA  |  DATA  |  DATA  |  DATA  |...|  DATA  |
        +--------+--------+--------+--------+--------+   +--------+
                                       ^
                                       |
                           WR_PTR (Lap 1) --+
                           RD_PTR (Lap 0) --+
                         (Diff Lap, Same Slot)

Hardware Logic:
Is WR[4] != RD[4]?         YES (1 != 0) -> Different Laps!
Is WR[3:0] == RD[3:0]?     YES (3 == 3) -> Same Slot
Result: FULL = 1


*/
