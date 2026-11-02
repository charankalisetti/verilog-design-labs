// ============================================================================
// Module Name: johnson4_self_correcting
// Description: 4-Bit Self-Correcting Left-Shift Johnson Counter
//              - Legal Sequence: 0000 -> 0001 -> 0011 -> 0111 -> 1111 -> 1110 -> 1100 -> 1000
//              - Active-low asynchronous reset (rst_n)
//              - Active-high enable (en); holds state when en = 0
//              - Recovers to 0000 on next clock cycle from any illegal state
// ============================================================================

module johnson4_self_correcting (
    input  wire       clk,    // Clock input
    input  wire       rst_n,  // Active-Low Asynchronous Reset
    input  wire       en,     // Active-High Enable
    output reg  [3:0] q       // 4-bit output vector [q3, q2, q1, q0]
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= 4'b0000;     // Asynchronous reset to initial legal state
        end else if (en) begin
            case (q)
                // 8 Legal States: Normal left-shift with inverted MSB fed into LSB
                4'b0000, 4'b0001, 4'b0011, 4'b0111,
                4'b1111, 4'b1110, 4'b1100, 4'b1000: begin
                    q <= {q[2:0], ~q[3]};
                end

                // 8 Unused/Illegal States: Force recovery to 0000 on next clock edge
                default: begin
                    q <= 4'b0000;
                end
            endcase
        end
        // Implied hold when en = 0
    end

endmodule

/*

// ============================================================================
// Module Name: johnson4
// Description: Refactored 4-bit self-correcting Johnson counter.
//              Uses an external 'else if (en)' wrapper for clean enable control.
// ============================================================================

module johnson4 (
    input  wire       clk,    // Clock input
    input  wire       rst_n,  // Active-low asynchronous reset
    input  wire       en,     // Active-high enable
    output reg  [3:0] q       // 4-bit state output
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= 4'b0000;
        end else if (en) begin
            case (q)
                4'b0000: q <= 4'b0001;
                4'b0001: q <= 4'b0011;
                4'b0011: q <= 4'b0111;
                4'b0111: q <= 4'b1111;
                4'b1111: q <= 4'b1110;
                4'b1110: q <= 4'b1100;
                4'b1100: q <= 4'b1000;
                4'b1000: q <= 4'b0000;
                default: q <= 4'b0000; // Recovers from 8 unused states when enabled
            endcase
        end
        // Implied hold when en = 0
    end

endmodule

*/