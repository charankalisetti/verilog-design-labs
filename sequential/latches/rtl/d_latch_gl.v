module d_latch_gl(d,en,q,qc);

input d,en;
output wire q,qc;
wire s,r;

nand(s,en,d);
nand(r,en,~d);
nand(q,s,qc);
nand(qc,r,q);

endmodule