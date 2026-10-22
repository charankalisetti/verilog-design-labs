module async_single_port_ram(we,en,addr,data_out);

input we,en;
input [3:0]addr; //4-bit Address Bus (16 locations)
inout [7:0]data  // Single bi-directional data bus

// 16-location memory array, each 8 bits wide
reg [7:0]mem[15:0];

// Asynchronous write operation
always@(*)
	begin
		if(en&&we)
			mem[addr]=data;
	end
	
	// Tri-state control for asynchronous read operation
    // Drive data bus during Read (en = 1, we = 0), otherwise put bus in High-Z state
	assign data=(en && !we)?mem[addr]:8'bzzzzzzzz;
	
endmodule
/*	


                       +-------------------------+
                       |  Async Single-Port RAM  |
                       |      (16 x 8-bit)       |
                       +-------------------------+
    Chip Enable  ----->| en                      |
                       |                         |
   Write Enable  ----->| we                      |
                       |                         |
   Address Bus   ----->| addr[3:0]               |
                       |                         |
                       |              data[7:0]  |<=====> Data Bus
                       |                         |        (Bi-directional)
                       +-------------------------+
					   
					   
					   */