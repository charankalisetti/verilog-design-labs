module mod_12_up_counter(in,load,reset,clk,count);

input [3:0]in;
input load,reset,clk;
output reg [3:0]count;

always@(posedge clk)
 begin
  if(reset)
   count=0;
   else if(load&&(in<=11))
    count=in;
	 else if(count==11)
	  count=0;
	   else
	    count=count+1;
end

endmodule		


/*
===================================================================================================================
                                         PRIORITY CONTROL HIERARCHY
===================================================================================================================

       +-----------------------------------------------------------------------+
       | 1. RESET (Active-Low)   --> Force Q = 0000 (Overrides everything)    |
       +-----------------------------------------------------------------------+
                                           |
                                           v (if Reset = 1 / inactive)
       +-----------------------------------------------------------------------+
       | 2. LOAD (Active-High)   --> Q <= d_in (Overrides Enable/Count)        |
       +-----------------------------------------------------------------------+
                                           |
                                           v (if Load = 0)
       +-----------------------------------------------------------------------+
       | 3. ENABLE (Active-High) --> Increment / Rollover (if 1) or Hold (if 0)|
       +-----------------------------------------------------------------------+

===================================================================================================================
// ============================================================================
// Module Name: mod12_counter_async_rst
// Description: 4-Bit Mod-12 Loadable Up-Counter with Asynchronous Reset
// Count Sequence: 0 -> 1 -> 2 -> ... -> 11 -> 0
// Priority: Reset > Load > Enable
// ============================================================================

module mod12_counter_async_rst (
    input  wire       clk,     // System Clock
    input  wire       rst_n,   // Asynchronous Active-Low Reset (Highest Priority)
    input  wire       load,    // Synchronous Load (2nd Priority)
    input  wire       en,      // Synchronous Count Enable (3rd Priority)
    input  wire [3:0] d_in,    // 4-bit Parallel Load Data
    output reg  [3:0] q        // 4-bit Counter Output (0 to 11)
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= 4'b0000;                             // 1. Asynchronous Reset (Immediate)
        end else if (load) begin
            q <= (d_in > 4'd11) ? (d_in % 4'd12) : d_in; // 2. Load with Mod-12 constraint
        end else if (en) begin
            if (q == 4'd11)
                q <= 4'b0000;                         // 3. Mod-12 Rollover
            else
                q <= q + 1'b1;                        // 4. Count Up
        end
        // Implied Hold: when en = 0 and load = 0, q maintains current value
    end

endmodule
// ============================================================================
// Module Name: mod12_counter_sync_rst
// Description: 4-Bit Mod-12 Loadable Up-Counter with Synchronous Reset
// Count Sequence: 0 -> 1 -> 2 -> ... -> 11 -> 0
// Priority: Reset > Load > Enable
// ============================================================================

module mod12_counter_sync_rst (
    input  wire       clk,     // System Clock
    input  wire       rst_n,   // Synchronous Active-Low Reset (Highest Priority)
    input  wire       load,    // Synchronous Load (2nd Priority)
    input  wire       en,      // Synchronous Count Enable (3rd Priority)
    input  wire [3:0] d_in,    // 4-bit Parallel Load Data
    output reg  [3:0] q        // 4-bit Counter Output (0 to 11)
);

    always @(posedge clk) begin
        if (!rst_n) begin
            q <= 4'b0000;                             // 1. Synchronous Reset (Clock-Edge Aligned)
        end else if (load) begin
            q <= (d_in > 4'd11) ? (d_in % 4'd12) : d_in; // 2. Load with Mod-12 constraint
        end else if (en) begin
            if (q == 4'd11)
                q <= 4'b0000;                         // 3. Mod-12 Rollover
            else
                q <= q + 1'b1;                        // 4. Count Up
        end
        // Implied Hold: when en = 0 and load = 0, q maintains current value
    end

endmodule


*/
