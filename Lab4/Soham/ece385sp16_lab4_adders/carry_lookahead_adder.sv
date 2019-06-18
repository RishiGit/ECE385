module carry_lookahead_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a CLA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
 
		//Combines four 4bit lookahead adders to create a 16 bit lookahead adder
		logic c0, c1, c2;
		logic [3:0] p;
		logic [3:0] g;
		
		fourbla fla0(.x(A[3:0]), .y(B[3:0]), .cin(0) , .sum(Sum[3:0]), .g(g[0]), .p(p[0]));
		fourbla fla1(.x(A[7:4]), .y(B[7:4]), .cin(c0) , .sum(Sum[7:4]), .g(g[1]), .p(p[1]));
		fourbla fla2(.x(A[11:8]), .y(B[11:8]), .cin(c1) , .sum(Sum[11:8]), .g(g[2]), .p(p[2]));
		fourbla fla3(.x(A[15:12]), .y(B[15:12]), .cin(c2) , .sum(Sum[15:12]), .g(g[3]), .p(p[3]));
		
		//Determines the carry bits for each four bit adder
		always_comb
			begin
					c0 = g[0];
					c1 = (g[0] & p[1]) | g[1];
					c2 = (g[0] & p[1] & p[2]) | (g[1] & p[2]) | g[2];
					CO = (g[0] & p[1] & p[2] & p[3]) | (g[1] & p[2] & p[3]) | (g[2] & p[3]) | g[3];
			end
			
		
 
 
 
endmodule

		//Module creates a four bit lookahead adder.
module fourbla(
		input [3:0] x,
		input [3:0] y,
		input cin,
		output logic [3:0] sum,
		output logic g,
		output logic p
		);
		
		logic [3:0] pbits;
		logic [3:0] gbits;
		logic c0, c1, c2;
		
		//Gbits and Pbits determine the carry in bits for the adders.
		//If Gbits is 1, then the carry in bit automatically 1.
		//If Pbits and the previous carry out bit are both 1, then the carry in bit is can also be 1.
		always_comb
		begin
		
				pbits = x ^ y;
				gbits = x & y;
				c0 = gbits[0] | (cin & pbits[0]);
				c1 = gbits[1] | (gbits[0] & pbits[1]) | (pbits[0] & pbits[1] & cin);
				c2 = gbits[2] | (gbits[1] & pbits[2]) | (gbits[0] & pbits[1] & pbits[2]) | (cin & pbits[0] & pbits[1] & pbits[2]);
				
				g = gbits[3] | (gbits[2] & pbits[3]) | (gbits[1] & pbits[2] & pbits[3]) | (gbits[0] & pbits[1] & pbits[2] & pbits[3]);
				p = pbits[0] & pbits[1] & pbits[2] & pbits[3];
		
		end
		
		fulladder fa0(.x(x[0]), .y(y[0]), .cin(cin), .s(sum[0]));
		fulladder fa1(.x(x[1]), .y(y[1]), .cin(c0), .s(sum[1]));
		fulladder fa2(.x(x[2]), .y(y[2]), .cin(c1), .s(sum[2]));
		fulladder fa3(.x(x[3]), .y(y[3]), .cin(c2), .s(sum[3]));
		
endmodule		




