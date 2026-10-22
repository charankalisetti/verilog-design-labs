module bidirectional_buffer(a,b,clt);

inout a,b;
input clt;

bufif1(b,a,clt);
bufif0(a,b,clt);

endmodule
