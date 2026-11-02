/*Write synthesizable Verilog for a 3:8 decoder with active-high enable en and active-high one-hot outputs y[7:0]. When
en=0, all outputs must be zero*/

module decoder_3to8_shift(en,a,y);
input wire en;
input wire [2:0] a;
output reg [7:0] y;

always @(*) 
	begin
		y = 8'b0;
			if (en) 
				y = 8'b00000001 << a;
    end
endmodule



/*
===================================================================================================================
                       3-TO-8 DECODER IMPLEMENTATION ANALYSIS: SHIFT vs. CASE
===================================================================================================================

1. SHIFT-BASED METHOD (y = 8'b00000001 << a):
   - Concept: Moves a single HIGH bit ('1') to index 'a', forming a one-hot vector.
   - Example Tracing:
       a = 3'b000 -> 8'b00000001 << 0 = 8'b00000001 (y[0] active)
       a = 3'b100 -> 8'b00000001 << 4 = 8'b00010000 (y[4] active)
   - Advantage: Highly compact code (1 line), naturally scales for parameterized widths.

2. TRADITIONAL CASE METHOD:
   - Explicitly lists all 8 binary combinations (3'b000 to 3'b111).
   - Verbose, but straightforward for introductory RTL code.

3. HARDWARE SYNTHESIS RESULT:
   - Both implementations synthesize to identical hardware gate netlists (3-to-8 decoder logic tree).
===================================================================================================================

// ============================================================================
// STYLE 1: SHIFT-BASED DECODER (Your Code - Mathematical/Concise)
// ============================================================================
always @(*) begin
    y = 8'b0;
    if (en) y = 8'b00000001 << a;
end

// ============================================================================
// STYLE 2: `case` STATEMENT DECODER (Most Common Traditional Style)
// ============================================================================
always @(*) begin
    if (!en) begin
        y = 8'b00000000;
    end else begin
        case (a)
            3'b000:  y = 8'b00000001;
            3'b001:  y = 8'b00000010;
            3'b010:  y = 8'b00000100;
            3'b011:  y = 8'b00001000;
            3'b100:  y = 8'b00010000;
            3'b101:  y = 8'b00100000;
            3'b110:  y = 8'b01000000;
            3'b111:  y = 8'b10000000;
            default: y = 8'b00000000;
        endcase
    end
end

// ============================================================================
// STYLE 3: DATAFLOW / BOOLEAN EXPRESSION DECODER (Gate-Level Mapping)
// ============================================================================
assign y[0] = en & ~a[2] & ~a[1] & ~a[0];
assign y[1] = en & ~a[2] & ~a[1] &  a[0];
assign y[2] = en & ~a[2] &  a[1] & ~a[0];
assign y[3] = en & ~a[2] &  a[1] &  a[0];
assign y[4] = en &  a[2] & ~a[1] & ~a[0];
assign y[5] = en &  a[2] & ~a[1] &  a[0];
assign y[6] = en &  a[2] &  a[1] & ~a[0];
assign y[7] = en &  a[2] &  a[1] &  a[0];

*/