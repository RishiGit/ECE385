module ripple_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a ripple adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	
	  logic c0, c1, c2;
	  //combines four 4bit ripple adders to make a 16 bit ripple adder
	  fourbra fra0(.x(A[3:0]), .y(B[3:0]), .cin(0) , .sum(Sum[3:0]), .cout(c0));
	  fourbra fra1(.x(A[7:4]), .y(B[7:4]), .cin(c0) , .sum(Sum[7:4]), .cout(c1));
	  fourbra fra2(.x(A[11:8]), .y(B[11:8]), .cin(c1) , .sum(Sum[11:8]), .cout(c2));
     fourbra fra3(.x(A[15:12]), .y(B[15:12]), .cin(c2) , .sum(Sum[15:12]), .cout(CO));
	  
endmodule


//four bit ripple adder
module  fourbra(

		input [3:0] x,
		input [3:0] y,
		input cin,
		output logic [3:0] sum,
		output logic cout
		);
		
		logic c0, c1, c2;
		
		fulladder fa0(.x(x[0]), .y(y[0]), .cin(cin), .s(sum[0]), .cout(c0));
		fulladder fa1(.x(x[1]), .y(y[1]), .cin(c0), .s(sum[1]), .cout(c1));
		fulladder fa2(.x(x[2]), .y(y[2]), .cin(c1), .s(sum[2]), .cout(c2));
		fulladder fa3(.x(x[3]), .y(y[3]), .cin(c2), .s(sum[3]), .cout(cout));
		
endmodule

//full adder
module fulladder(
			input x,
			input y,
			input cin,
			output logic s,
			output logic cout
			);
		
		assign s = x ^ y ^ cin;
		assign cout = (x & y) | (y & cin) | (x & cin);
		
endmodule