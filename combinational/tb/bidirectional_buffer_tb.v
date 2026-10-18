module bidirectional_buffer_tb;

reg clt;
reg temp_a,temp_b;
wire a,b;
integer i,j;
bidirectional_buffer DUT(a,b,clt);

assign a=clt?temp_a:1'bz;
assign b=~clt?temp_b:1'bz;

initial
 begin
  for(i=0;i<=1;i=i+1)
   begin
    clt=i;
    for(j=0;j<=3;j=j+1)
     begin
	  {temp_a,temp_b}=j;
	  #5;
	 end
   end
   $finish;
 end
endmodule 
      	 


