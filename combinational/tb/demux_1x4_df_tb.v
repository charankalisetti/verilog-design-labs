module demux_1x4_df_tb;

reg i;
reg [1:0]s;
wire [3:0]out;
integer k,j;

demux_1x4_df dut(i,out,s);

initial 

begin
for(k=0;k<=3;k=k+1)
begin
 s=k;
 for(j=0;j<=1;j=j+1)
begin
i=j;
#5; 
end
 end
$finish;
end
endmodule 
 
