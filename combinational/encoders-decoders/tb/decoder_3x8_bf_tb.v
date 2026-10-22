module decoder_3x8_bf_tb;

reg [2:0]i_tb;
reg en_tb;
wire [7:0]y_tb;

decoder_3x8_bf DUT(i_tb,en_tb,y_tb);

task apply_input;
input x;
input [2:0]y;
 begin
 i_tb=y;
 en_tb=x;
 #5;
 end
endtask 

task stimulus;
integer j,k;

 begin:block
 for(j=0;j<=1;j=j+1)
  begin
  for(k=0;k<=7;k=k+1)
   begin
    apply_input(j,k);
   end
  end
  $finish;
 end
endtask

initial
begin
 stimulus();
end

endmodule 