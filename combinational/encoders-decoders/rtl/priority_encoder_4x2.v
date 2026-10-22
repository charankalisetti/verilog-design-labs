module priority_encoder_4x2(in,en,y,vaild);

input [3:0]in;
input en;
output reg [1:0]y;
output reg vaild;

always@(*)
 begin 
 // 1. Assign default values to guarantee no latches are inferred
   
    vaild = 1'b1;
  if(en==0)
   begin
   y=0;
   vaild=0;
	end
   else if(in[3]==1)
    y=3;
	else if(in[2]==1)
	 y=2;
	 else if(in[1]==1)
	  y=1;
	  else if(in[0]==1)
	   y=0;
	   else
	    y = 2'd0;
	    vaild=0;
end

endmodule		
		