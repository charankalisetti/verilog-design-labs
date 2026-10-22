module mod_9_binary_updown(reset_low,dir,clk,count);

input reset_low,dir,clk;
output reg [3:0]count;

always@(posedge clk)
 begin
 if(!reset_low)
  count<=0;
   else if(count==8 && dir)
    count<=0;
    else if(count==0 && !dir)
     count<=8;
     else if(dir)
      count<=count+1;
      else
       count<=count-1;
         
 end
 
endmodule 