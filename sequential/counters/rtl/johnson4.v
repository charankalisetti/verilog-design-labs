// ============================================================================
// Module Name: johnson4
// Description: 4-Bit Left-Shifting Johnson Counter (Twisted Ring Counter)
//              - Asynchronous Active-Low Reset (clr_n)
//              - Modulus-8 operation (2n = 8 states)
//              - Feedback: Inverted MSB (~q[3]) injected into LSB (q[0])
// ============================================================================

module johnson4 (
    input  wire       clk,    // System Clock (Rising-edge active)
    input  wire       clr_n,  // Asynchronous Active-Low Clear
    output reg  [3:0] q       // 4-bit State Vector [Q3, Q2, Q1, Q0]
);

    // Asynchronous Sequential State Register
    always @(posedge clk or negedge clr_n) begin
        if (!clr_n) begin
            q <= 4'b0000;     // Force clear to 0000 on active-low reset
        end else begin
            // Left Shift: Move bits towards MSB, inject ~q[3] into LSB q[0]
            q <= {q[2:0], ~q[3]};
        end
    end

endmodule



/*
===================================================================================================================================
                                      4-BIT LEFT-SHIFT JOHNSON COUNTER ANALYSIS
===================================================================================================================================

1. HARDWARE FEEDBACK & SHIFT DIRECTION
-----------------------------------------------------------------------------------------------------------------------------------
- Shift Direction : Left shift (q[2:0] shift into q[3:1]).
- Feedback Path   : Inverted MSB output (~q[3]) connects directly to LSB input (D0).
- D-Input Logic   : D0 = ~Q3
                    D1 = Q0
                    D2 = Q1
                    D3 = Q2


2. STATE SEQUENCE TRANSITION TABLE (Modulus 8)
-----------------------------------------------------------------------------------------------------------------------------------
+-------------+----------------+----------------+-------------------------------------------------------------------------+
| Clock Cycle | Output q[3:0]  | Feedback (~q[3])| Next State Transition Logic                                             |
+-------------+----------------+----------------+-------------------------------------------------------------------------+
| Reset       | 0000           | 1              | Asynchronous clear initializes register to 0000                        |
| 1           | 0001           | 1              | ~Q3 (1) enters LSB Q0, Q[2:0] (000) shifts left -> 0001                  |
| 2           | 0011           | 1              | ~Q3 (1) enters LSB Q0, Q[2:0] (001) shifts left -> 0011                  |
| 3           | 0111           | 1              | ~Q3 (1) enters LSB Q0, Q[2:0] (011) shifts left -> 0111                  |
| 4           | 1111           | 0              | ~Q3 (1) enters LSB Q0, Q[2:0] (111) shifts left -> 1111                  |
| 5           | 1110           | 0              | ~Q3 (0) enters LSB Q0, Q[2:0] (111) shifts left -> 1110                  |
| 6           | 1100           | 0              | ~Q3 (0) enters LSB Q0, Q[2:0] (110) shifts left -> 1100                  |
| 7           | 1000           | 0              | ~Q3 (0) enters LSB Q0, Q[2:0] (100) shifts left -> 1000                  |
| 8           | 0000 (Repeats) | 1              | ~Q3 (0) enters LSB Q0, Q[2:0] (000) shifts left -> 0000 (Loop repeats)   |
+-------------+----------------+----------------+-------------------------------------------------------------------------+

===================================================================================================================================

// ============================================================================
// Module Name: johnson4_right_shift
// Description: 4-Bit Right-Shifting Johnson Counter
//              - Injects inverted LSB (~q[0]) into MSB q[3] on each clock edge.
//              - First cycle after reset shifts 1 into MSB: 0000 -> 1000
// ============================================================================


module johnson4_right_shift (
    input  wire       clk,    // System Clock
    input  wire       clr_n,  // Asynchronous Active-Low Clear
    output reg  [3:0] q       // 4-bit State Vector [Q3, Q2, Q1, Q0]
);

    always @(posedge clk or negedge clr_n) begin
        if (!clr_n) begin
            q <= 4'b0000;     // Force clear to 0000 on active-low reset
        end else begin
            // Right Shift: Move bits towards LSB, inject ~q[0] into MSB q[3]
            q <= {~q[0], q[3:1]};
        end
    end

endmodule



===================================================================================================================================
                             STATE SEQUENCE: LEFT-SHIFT vs. RIGHT-SHIFT JOHNSON COUNTERS
===================================================================================================================================
+-------------+---------------------------------------------------+---------------------------------------------------+
| Clock Cycle | Left-Shift: q <= {q[2:0], ~q[3]}                  | Right-Shift: q <= {~q[0], q[3:1]}                 |
|             | (1 enters at LSB q[0] first)                      | (1 enters at MSB q[3] first)                      |
+-------------+---------------------------------------------------+---------------------------------------------------+
| Reset       | 0000                                              | 0000                                              |
| 1           | 0001                                              | 1000  <-- MSB q[3] becomes 1 first            |
| 2           | 0011                                              | 1100                                              |
| 3           | 0111                                              | 1110                                              |
| 4           | 1111                                              | 1111                                              |
| 5           | 1110                                              | 0111                                              |
| 6           | 1100                                              | 0011                                              |
| 7           | 1000                                              | 0001                                              |
| 8           | 0000 (Repeats)                                    | 0000 (Repeats)                                    |
+-------------+---------------------------------------------------+---------------------------------------------------+
===================================================================================================================================



===================================================================================================================================
                                      RIGHT-SHIFT JOHNSON COUNTER GATE-LEVEL DIAGRAM
===================================================================================================================================

            +-----------+         +-----------+         +-----------+         +-----------+
            |   D FF3   |         |   D FF2   |         |   D FF1   |         |   D FF0   |
    +------>|D3       Q3|-------->|D2       Q2|-------->|D1       Q1|-------->|D0       Q0|------+
    |       |  (MSB)    |         |           |         |           |         |  (LSB)    |      |
    |       |  clk clr_n|         |  clk clr_n|         |  clk clr_n|         |  clk clr_n|      |
    |       +---+-----+-+         +---+-----+-+         +---+-----+-+         +---+-----+-+      |
    |           |     |               |     |               |     |               |     |        |
 clk|-----------+-----|---------------+-----|---------------+-----|---------------+     |        |
clr_n|----------------+---------------------+---------------------+---------------------+        |
    |                                                                                            |
    |       +-------+                                                                            |
    +-------|  NOT  |<----------------------------------------------------------------------------+
            | (~Q0) |
            +-------+
			
			
			*/
