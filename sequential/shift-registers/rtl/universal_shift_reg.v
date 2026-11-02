// ============================================================================
// Module Name: universal_shift_reg
// Description: Parameterized Universal Shift Register with explicit, dedicated 
//              output ports for Parallel, Serial-Right, and Serial-Left outputs.
// ============================================================================

module universal_shift_reg #(
    parameter WIDTH = 4
)(
    // ------------------------------------------------------------------------
    // INPUT PORTS
    // ------------------------------------------------------------------------
    input  wire             clk,          // System Clock (Rising-edge active)
    input  wire             rst,          // Synchronous Active-High Reset
    input  wire [1:0]       select,       // Mode Select: 00=Hold, 01=Shift Right, 10=Shift Left, 11=Parallel Load
    input  wire             s_in_msb,     // Serial Data Input for Shift Right (enters at MSB)
    input  wire             s_in_lsb,     // Serial Data Input for Shift Left  (enters at LSB)
    input  wire [WIDTH-1:0] d_in,         // Parallel Data Input Bus

    // ------------------------------------------------------------------------
    // DEDICATED OUTPUT PORTS
    // ------------------------------------------------------------------------
    output wire [WIDTH-1:0] parallel_out, // Full N-bit Parallel Data Output Bus
    output wire             s_out_right,  // Dedicated Serial Output for Shift Right (LSB: q[0])
    output wire             s_out_left    // Dedicated Serial Output for Shift Left  (MSB: q[WIDTH-1])
);

    // Internal State Register
    reg [WIDTH-1:0] q;

    // ------------------------------------------------------------------------
    // Continuous Output Driving
    // ------------------------------------------------------------------------
    assign parallel_out = q;             // Drives the full parallel bus
    assign s_out_right  = q[0];          // Drives LSB out for Shift Right (SISO / PISO)
    assign s_out_left   = q[WIDTH-1];    // Drives MSB out for Shift Left  (SISO / PISO)

    // Mode Encoding Local Parameters
    localparam HOLD          = 2'b00,
               SHIFT_RIGHT   = 2'b01,
               SHIFT_LEFT    = 2'b10,
               PARALLEL_LOAD = 2'b11;

    // ------------------------------------------------------------------------
    // Synchronous Sequential Logic
    // ------------------------------------------------------------------------
    always @(posedge clk) begin
        if (rst) begin
            q <= {WIDTH{1'b0}}; // Clear register on active-high reset
        end else begin
            case (select)
                HOLD: begin
                    q <= q;     // Retain present state
                end

                SHIFT_RIGHT: begin
                    // Shift Right: Insert s_in_msb at MSB, shift remaining bits right
                    q <= {s_in_msb, q[WIDTH-1:1]};
                end

                SHIFT_LEFT: begin
                    // Shift Left: Insert s_in_lsb at LSB, shift remaining bits left
                    q <= {q[WIDTH-2:0], s_in_lsb};
                end

                PARALLEL_LOAD: begin
                    q <= d_in;  // Load parallel input vector synchronously
                end

                default: begin
                    q <= q;     // Fallback safety assignment
                end
            endcase
        end
    end

endmodule