
// ============================================================================
// Module Name: stand_encoder
// Description: 4-to-2 Standard Binary Encoder using if-else constructs 
//              and a tri-state enable control.
//              Uses pre-initialized default assignments to streamline case logic.
// ============================================================================

module stand_encoder (
    input wire       En,    // Enable signal (Active High)
    input wire [3:0] In,    // 4-bit input vector (I3, I2, I1, I0)
    output reg [1:0] out,   // 2-bit encoded output vector
    output reg       valid  // Valid indicator flag
);

    always @(*) begin
        if (En)
			begin
            valid = 1'b1;             // Pre-initialize default: assume valid 1-hot input

            case (In)
                4'b0001: out = 2'b00;  // Input I0 active -> inherits valid = 1
                4'b0010: out = 2'b01;  // Input I1 active -> inherits valid = 1
                4'b0100: out = 2'b10;  // Input I2 active -> inherits valid = 1
                4'b1000: out = 2'b11;  // Input I3 active -> inherits valid = 1
                default: 
					begin
						out   = 2'b00;
						valid = 1'b0;     // Overrides default to 0 for invalid inputs
					end
            endcase
        end else 
			begin
            out   = 2'bzz;            // High-impedance (Tri-state) when disabled
            valid = 1'b0;            // Output invalid when disabled
        end
    end

endmodule


/*



A Standard Encoder (or binary encoder) is a combinational circuit that converts 2^N input lines into an N-bit binary output code.
Unlike a Priority Encoder, a standard encoder operates under the strict operational assumption 
that only one input line is active (HIGH) at any given time (a one-hot input). 
If multiple input lines are asserted simultaneously, the output of a standard encoder becomes invalid or undefined.





               +-----------------------+
               |                       |
     En ------>| Enable                |
               |                       |
     In[3] --->|                       |
     In[2] --->|  4:2 Standard Encoder |---> out[1]
     In[1] --->|                       |---> out[0]
     In[0] --->|                       |
               |                       |
               +-----------------------+
			   
			   
			   */