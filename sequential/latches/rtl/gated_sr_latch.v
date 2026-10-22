module gated_sr_latch (s,r,en,q,qc);

input s,r,en;
output wire q,qc;
wire sc,rc;

    nand g1(sc,s,en);
    nand g2(rc,r,en);
	 nand g3(q,sc,qc);
	 nand g4(qc,rc,q);
  
endmodule   