// ============================================================================
// Module Name: ring_johnson_counter_6bit
// Description: Dual-Mode 6-Bit Counter supporting:
//                - Ring Counter Mode    (enable = 1): Modulus 6, 1-hot circulating bit
//                - Johnson Counter Mode (enable = 0): Modulus 12, inverted feedback
//
// KEY HARDWARE & DESIGN ARCHITECTURE POINTS:
//
// 1. DYNAMIC FEEDBACK MULTIPLEXING:
//    - When enable = 1: feedback_bit = Q[0]  (Direct Ring feedback)
//    - When enable = 0: feedback_bit = ~Q[0] (Inverted Johnson feedback)
//
// 2. MODE-DEPENDENT INITIALIZATION ON RESET:
//    - Ring Counter Mode (enable = 1): MUST reset to a 1-hot state (6'b100000).
//      Resetting to 6'b000000 causes permanent zero-lockup because Q[0]=0 keeps
//      feeding 0 back into Q[5] endlessly.
//    - Johnson Counter Mode (enable = 0): Safely resets to all zeros (6'b000000).
//      Because feedback is ~Q[0], ~0 = 1 is naturally injected into Q[5] on the 
//      very first clock pulse following reset.
//
// 3. MODE-SWITCHING HAZARD CONSIDERATION:
//    - If 'enable' is toggled dynamically while running (without asserting reset):
//        a) Johnson -> Ring (enable 0 -> 1): The multi-bit patterns of Johnson mode 
//           (e.g., 6'b111000) will circulate as invalid multi-hot Ring patterns.
//        b) Zero-State Lockup: If state is 6'b000000 when switching to Ring mode, 
//           the counter freezes permanently at zero.
//    - Operational Rule: Assert 'rst' whenever changing the 'enable' mode.
// ============================================================================

module ring_johnson_counter_6bit (
    input wire clk,       // System Clock (Rising-edge active)
    input wire rst,       // Synchronous Active-High Reset
    input wire enable,    // Mode Select: 1 = Ring Counter, 0 = Johnson Counter
    output reg [5:0] q    // 6-bit Counter Output State
);

    // Dynamic Feedback Selection via 2-to-1 Multiplexer
    wire feedback_bit;
    assign feedback_bit = enable ? q[0] : ~q[0];

    // Synchronous Sequential State Register
    always @(posedge clk) begin
        if (rst) begin
            // Initialization Logic:
            // - Enable = 1 -> Preset to 1-hot state (6'b100000)
            // - Enable = 0 -> Clear to all-zero state (6'b000000)
            if (enable)
                q <= 6'b100000;
            else
                q <= 6'b000000;
        end else begin
            // Right-Shift Register with Selected Feedback injected at MSB (q[5])
            q <= {feedback_bit, q[5:1]};
        end
    end

endmodule





/*
===================================================================================================================================
                                           KEY DIFFERENCES: RING COUNTER vs. JOHNSON COUNTER
===================================================================================================================================
+---------------------------+--------------------------------------------------------+--------------------------------------------+
| Feature                   | Ring Counter (Straight Ring)                           | Johnson Counter (Twisted Ring)             |
+---------------------------+--------------------------------------------------------+--------------------------------------------+
| Feedback Connection       | Direct output (Q) of the last flip-flop to the input   | Inverted output (Q_bar) of the last        |
|                           | (D) of the first flip-flop.                            | flip-flop to the input (D) of the first.   |
+---------------------------+--------------------------------------------------------+--------------------------------------------+
| Number of States (Modulus)| n states for n flip-flops.                             | 2n states for n flip-flops.                |
+---------------------------+--------------------------------------------------------+--------------------------------------------+
| Initial State Requirement | Requires a Preset (e.g., 1000) on at least one         | Requires a Clear / Reset (all 0s, 0000).   |
|                           | flip-flop (1-hot state).                               |                                            |
+---------------------------+--------------------------------------------------------+--------------------------------------------+
| Pattern / Sequence        | A single 1 circulating through the register:           | A moving block of 1s followed by 0s:       |
|                           | (1000 -> 0100 -> 0010 -> 0001)                         | (0000 -> 1000 -> 1100 -> 1110 ->          |
|                           |                                                        |  1111 -> 0111 -> 0011 -> 0001)            |
+---------------------------+--------------------------------------------------------+--------------------------------------------+
| Decoding                  | Self-decoding; requires no extra combinational logic.  | Requires extra logic gates (such as AND    |
|                           |                                                        | gates) to decode individual states.        |
+---------------------------+--------------------------------------------------------+--------------------------------------------+
===================================================================================================================================


Why We Do Not Need a Preset for a Johnson Counter

1. Self-Starting from All Zeros:
	• In a ring counter, if all flip-flops are accidentally set to 0 (0000),
	the 0 keeps feeding back into the first flip-flop forever, and the counter gets stuck (0 → 0 → 0).
	To prevent this deadlock, you must force an initial 1 using a Preset.
	• In a Johnson counter, the feedback comes from the inverted output (Q̄) of the last flip-flop. 
	When the register is in the all-zero state (0000), the inverted output of the last stage is 1.
	• On the very first clock pulse, that 1 shifts into the first flip-flop, naturally breaking the zero-lock and starting the normal counting sequence (1000, 1100, etc.).
	
	
	
	
	
	
===================================================================================================================================
                                          STATE SEQUENCE COMPARISON TABLE (6-BIT WIDTH)
===================================================================================================================================
+-------------+---------------------------------------------------+---------------------------------------------------+
| Clock Cycle | 6-Bit Ring Counter (enable = 1, Modulus = 6)      | 6-Bit Johnson Counter (enable = 0, Modulus = 12)  |
+-------------+---------------------------------------------------+---------------------------------------------------+
| Reset       | 100000 (Preset 1-Hot)                             | 000000 (Clear All-Zero)                           |
+-------------+---------------------------------------------------+---------------------------------------------------+
| 1           | 010000                                            | 100000                                            |
+-------------+---------------------------------------------------+---------------------------------------------------+
| 2           | 001000                                            | 110000                                            |
+-------------+---------------------------------------------------+---------------------------------------------------+
| 3           | 000100                                            | 111000                                            |
+-------------+---------------------------------------------------+---------------------------------------------------+
| 4           | 000010                                            | 111100                                            |
+-------------+---------------------------------------------------+---------------------------------------------------+
| 5           | 000001                                            | 111110                                            |
+-------------+---------------------------------------------------+---------------------------------------------------+
| 6           | 100000 (Repeats)                                  | 111111                                            |
+-------------+---------------------------------------------------+---------------------------------------------------+
| 7           | 010000                                            | 011111                                            |
+-------------+---------------------------------------------------+---------------------------------------------------+
| 8           | 001000                                            | 001111                                            |
+-------------+---------------------------------------------------+---------------------------------------------------+
| 9           | 000100                                            | 000111                                            |
+-------------+---------------------------------------------------+---------------------------------------------------+
| 10          | 000010                                            | 000011                                            |
+-------------+---------------------------------------------------+---------------------------------------------------+
| 11          | 000001                                            | 000001                                            |
+-------------+---------------------------------------------------+---------------------------------------------------+
| 12          | —                                                 | 000000 (Repeats)                                  |
+-------------+---------------------------------------------------+---------------------------------------------------+
===================================================================================================================================



	*/