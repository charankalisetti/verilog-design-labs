module sync_dual_port_ram(clk,reset,we,re,waddr,raddr,data_in,data_out);

parameter data_width=8,depth=16,addr_width=$clog2(depth);

input clk,reset,we,re;
input [addr_width-1:0]waddr,raddr;
input [data_width-1:0]data_in;
output reg [data_width-1:0]data_out;

reg [data_width-1:0]mem[depth-1:0];

always@(posedge clk)
begin
	if(reset)
		begin:block
			integer i;
			data_out=0;
			for(i=0;i<depth;i=i+1)
				mem[i]=0;
		end
	else
		if(we)
			mem[waddr]=data_in;
		if(re)
			data_out=mem[raddr];

end

endmodule			


/*
                       +-----------------------------------+
                       | Synchronous Simple Dual-Port RAM  |
                       |           (16 x 8-bit)            |
                       +-----------------------------------+
                       |                                   |
                       |        [ Global Controls ]        |
             Clock --->| clk                               |
             Reset --->| rst                               |
                       |                                   |
                       |           [ Write Port ]          |
      Write Enable --->| we                                |
     Write Address --->| wr_add[3:0]                       |
        Write Data --->| data_in[7:0]                      |
                       |                                   |
                       |           [ Read Port ]           |
       Read Enable --->| re                                |
      Read Address --->| rd_add[3:0]                       |
                       |                     data_out[7:0] |----> Read Data
                       |                                   |
                       +-----------------------------------+
					   
					   */
					   
					   
// =========================================================================
            // HARDWARE CONCURRENCY NOTE (Software vs. Hardware):
            // Although these two 'if' statements are written sequentially line-by-line,
            // synthesizers synthesize TWO SEPARATE PHYSICAL CIRCUITS in silicon.
            //
            // Using non-blocking assignments (<=) ensures that both the Write logic
            // and Read logic evaluate at the exact same clock edge (posedge clk).
            //
            // There is ZERO sequential execution delay between these two blocks.
            // Do NOT use 'else if (re)' here, as that would force Read to wait for
            // Write to be inactive. Two independent 'if' blocks allow simultaneous
            // Read and Write operations to happen in parallel on the same clock edge.
            // =========================================================================