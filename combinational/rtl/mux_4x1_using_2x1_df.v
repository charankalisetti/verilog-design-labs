module mux_4x1_using_2x1_df(i,s,y);
input [3:0]i;
input [2:0]s;
output y;
wire w1,w2;

mux_2x1_df mux1(.s(s[0]),
                .i_0(i[0]),
				    .i_1(i[1]),
				    .y(w1));
				
mux_2x1_df mux2(.s(s[0]),
                .i_0(i[2]),
				    .i_1(i[3]),
				    .y(w2));
				
mux_2x1_df mux3(.s(s[1]),
                .i_0(w1),
				    .i_1(w2),
				    .y(y));
endmodule				