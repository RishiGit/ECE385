module carry_select_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a carry select.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	  
	  //Creates separate instances of the sum of each four bit subarray of the 16 bit
	  //arrays, one with a carry in bit of 1 and one with a carry in bit of 0.
	  //The correct sum is then selected based on whether the carry in bit ends up
	  //being one or zero.
	  
	   logic c0, c10, c11, c20,c21,CO1,CO2;
		logic [15:0] Sum0,Sum1;
		fourbra fra0(.x(A[3:0]), .y(B[3:0]), .cin(0) , .sum(Sum[3:0]), .cout(c0));
		fourbra fra1(.x(A[7:4]), .y(B[7:4]), .cin(0) , .sum(Sum0[7:4]), .cout(c11));
		fourbra fra12(.x(A[7:4]), .y(B[7:4]), .cin(1) , .sum(Sum1[7:4]), .cout(c12));
		fourbra fra2(.x(A[11:8]), .y(B[11:8]), .cin(0) , .sum(Sum0[11:8]), .cout(c21));
		fourbra fra22(.x(A[11:8]), .y(B[11:8]), .cin(1) , .sum(Sum1[11:8]), .cout(c22));	
		fourbra fra3(.x(A[15:12]), .y(B[15:12]), .cin(0) , .sum(Sum0[15:12]), .cout(CO1));
		fourbra fra32(.x(A[15:12]), .y(B[15:12]), .cin(1) , .sum(Sum1[15:12]), .cout(CO2));
		MUX m0(.D1(Sum0[7:4]),.D2(Sum1[7:4]),.select(c0),.c1(c11),.c2(c12),.Dout(Sum[7:4]),.c(c1));
		MUX m1(.D1(Sum0[11:8]),.D2(Sum1[11:8]),.select(c1),.c1(c21),.c2(c22),.Dout(Sum[11:8]),.c(c2));
		MUX m2(.D1(Sum0[15:12]),.D2(Sum1[15:12]),.select(c2),.c1(CO1),.c2(CO2),.Dout(Sum[15:12]),.c(CO));
	  
		
				
endmodule

//Created a module MUX to simulate a multiplexer to select between the sum
//with the carry in bit of 0 and the one with the carry in bit of 1.
module MUX
(
	input[3:0] D1,
	input[3:0] D2,
	input select,
	input c1, 
	input c2,
	output logic [3:0] Dout,
	output logic c
);

	always_comb
			begin
				if(select == 0)begin
					Dout = D1;
					c=c1;
				end else begin
					Dout = D2;
					c=c2;
				end
			end
			
endmodule
