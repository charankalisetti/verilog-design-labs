module testing_tb;

reg a,b;
wire y;

assign y=a+b;

initial begin
a=0;
b=1;
 $strobe("strobe =a=%b,b=%b,y=%b",a,b,y);
$display("display =a=%b,b=%b,y=%b",a,b,y);
end
endmodule
