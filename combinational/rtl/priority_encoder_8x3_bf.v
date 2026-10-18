module priority_encoder_8x3_bf(i,y,valid);

input [7:0]i;
output reg [2:0]y;
output wire valid;

always@(*)
 begin
  if(i[7])
   y=7;
   else if(i[6])
    y=6;
	else if(i[5])
	 y=5;
	 else if(i[4])
	  y=4;
	  else if(i[3])
	   y=3;
	    else if(i[2])
		 y=2;
		  else if(i[1])
		   y=1;
		    else
			 y=0;
 end
 
assign valid=i?1'b1:1'b0;

endmodule 
			 