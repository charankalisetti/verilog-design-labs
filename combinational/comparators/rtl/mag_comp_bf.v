
// ============================================================================
// Module Name: mag_comp_bf
// Description: 2-bit magnitude comparator using Behavioral Modeling
// Drives exactly one output high: GT (A > B), EQ (A == B), LT (A < B).
// ============================================================================

module mag_comp_bf (a,b,gt,eq,lt);
    input [1:0]a,b;
    output gt,eq,lt;
    
    reg gt,eq,lt;

    always @(*) begin
        // Default assignments to prevent latches
        gt = 1'b0;
        eq = 1'b0;
        lt = 1'b0;

        if (a > b)
            gt = 1'b1;
        else if (a == b)
            eq = 1'b1;
        else
            lt = 1'b1;
    end

endmodule


/*
// ============================================================================
// Module Name: mag_comp_dataflow
// Description: 2-bit magnitude comparator using Data Flow Modeling
// ============================================================================

module mag_comp_dataflow (a,b,gt,eq,lt);
    input [1:0]a,b;
    output gt,eq,lt;

    assign eq = ~(a[1] ^ b[1]) & ~(a[0] ^ b[0]);
    assign gt = (a[1] & ~b[1]) | (~(a[1] ^ b[1]) & a[0] & ~b[0]);
    assign lt = (~a[1] & b[1]) | (~(a[1] ^ b[1]) & ~a[0] & b[0]);

endmodule


*/