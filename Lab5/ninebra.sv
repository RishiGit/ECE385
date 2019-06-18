//ninebit adder taken from lab 4. Combines 9 full adders to make a 9bit carry ripple adder.

module  ninebra(

		input [7:0] xin,
		input [7:0] yin,
		input cin,
		output logic [8:0] sum
		);
		
		logic c0, c1, c2, c3, c4, c5, c6, c7;
		logic [8:0] twosy;
		assign twosy = yin ^ {8{cin}};
		
		fulladder fa0(.x(xin[0]), .y(twosy[0]), .cin(cin), .s(sum[0]), .cout(c0));
		fulladder fa1(.x(xin[1]), .y(twosy[1]), .cin(c0), .s(sum[1]), .cout(c1));
		fulladder fa2(.x(xin[2]), .y(twosy[2]), .cin(c1), .s(sum[2]), .cout(c2));
		fulladder fa3(.x(xin[3]), .y(twosy[3]), .cin(c2), .s(sum[3]), .cout(c3));
		fulladder fa4(.x(xin[4]), .y(twosy[4]), .cin(c3), .s(sum[4]), .cout(c4));
		fulladder fa5(.x(xin[5]), .y(twosy[5]), .cin(c4), .s(sum[5]), .cout(c5));
		fulladder fa6(.x(xin[6]), .y(twosy[6]), .cin(c5), .s(sum[6]), .cout(c6));
		fulladder fa7(.x(xin[7]), .y(twosy[7]), .cin(c6), .s(sum[7]), .cout(c7));
		fulladder fa8(.x(xin[7]), .y(twosy[7]), .cin(c7), .s(sum[8]), .cout());
		
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