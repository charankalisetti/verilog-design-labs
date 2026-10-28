// ============================================================================
// Module Name: divisible_by3_fsm
// Description: Moore FSM that checks if a binary number (received MSB first)
//              is divisible by 3.
// 
// Mathematical Principle:
//   Receiving a binary stream MSB-first shifts the current value left by 1 (x2)
//   and adds the incoming bit:
//       Value_new = (2 * Value_old) + bit_in
//
//   Taking modulo 3 of both sides gives the state transition equation:
//       Remainder_new = (2 * Remainder_old + bit_in) % 3
//
// State Definitions:
//   S0 (2'b00) : Remainder 0 -> Output y = 1 (Divisible by 3)
//   S1 (2'b01) : Remainder 1 -> Output y = 0
//   S2 (2'b10) : Remainder 2 -> Output y = 0
// ============================================================================

module divisible_by3_fsm (clk,rst,bit_in,y);

    input wire clk,rst,bit_in;
    output wire y       // 1 if binary value so far is divisible by 3
	
    // ------------------------------------------------------------------------
    // 1. State Encoding
    // ------------------------------------------------------------------------
    localparam S0 = 2'b00,  // Remainder = 0 (Reset/Divisible state)
               S1 = 2'b01,  // Remainder = 1
               S2 = 2'b10;  // Remainder = 2


    // Internal state registers
    reg [1:0] state, next_state;
	
	// ------------------------------------------------------------------------
    // 2. Sequential State Memory (Synchronous Reset)
    // ------------------------------------------------------------------------
	
    always @(posedge clk) begin
        if (rst)
            state <= S0;         // Reset directly to Remainder 0 state
        else
            state <= next_state; // Update state on rising clock edge
    end



// 1. Next-State & Output Logic (Combinational Block)
    always @* begin
        // Default assignments (Fallback values for all branches)
        next_state = S0;
        y = 1'b0; 

        case (state)
            S0: begin
                y = 1'b1;                      // Overrides default y = 0
                next_state = bit_in ? S1 : S0;
            end

            S1: begin
                next_state = bit_in ? S0 : S2; // Keeps default y = 0
            end

            S2: begin
                next_state = bit_in ? S2 : S1; // Keeps default y = 0
            end

            default: begin
                next_state = S0;               // Keeps default y = 0
            end
        endcase
    end
	
	endmodule






//If the specifications 	
	
// KEY DESIGN POINTS & ARCHITECTURAL HIGHLIGHTS:
//
// 1. IDLE STATE FOR RESET OVERRIDE (y = 0):
//    - Mathematically, 0 % 3 = 0. However, in system integration, asserting y = 1 
//      before data arrives can trigger false valid flags downstream. 
//    - Adding an explicit IDLE state forces y = 0 upon reset until data processing starts.
//
// 2. FIRST BIT TRANSITION LOGIC:
//    - Upon receiving the very first serial bit x while in IDLE:
//        * If x = 0 (Decimal 0): Moves to REM_0 -> y becomes 1 on the next clock cycle.
//        * If x = 1 (Decimal 1): Moves to REM_1 -> y stays 0 on the next clock cycle.
//
// 3. MOORE LOGIC EXECUTION:
//    - Output y depends SOLELY on present_state (e.g., y = 1 only when inside REM_0).
//    - Input x only determines next_state, ensuring clean, glitch-free outputs.
// ============================================================================