module four_one(input logic [127:0] A,B,C,D,
				  input logic [1:0] S,
				  output logic [127:0] Out);
		
		always_comb
			begin
				case(S)
					2'b00:
						Out = A;
					2'b01:
						Out = B;
					2'b10:
						Out = C;
					2'b11:
						Out = D;
				endcase
			end
endmodule

module four_one32(input logic [31:0] A,B,C,D,
				  input logic [1:0] S,
				  output logic [31:0] Out);
		
		always_comb
			begin
				case(S)
					2'b00:
						Out = A;
					2'b01:
						Out = B;
					2'b10:
						Out = C;
					2'b11:
						Out = D;
				endcase
			end
endmodule

module one_four32(output logic [127:0] A,
				  input logic [1:0] S,
				  input logic clk,
				  input logic [31:0] in);
		//logic [127:0] temp;
		
		always_ff @ (posedge clk)
		begin
				case(S)
					2'b00:
						begin
							A[127:96] = in;
						end
					2'b01:
						begin
							A[95:64] = in;
						end
					2'b10:
						begin
							A[63:32] = in;
						end
					2'b11:
						begin
							A[31:0] = in;
						end
					default: ;
				endcase
		end
		/*always_comb
			begin
				case(S)
					2'b00:
						begin
							temp[127:96] = in;
							temp[95:0] = A[95:0];
						end
					2'b01:
						begin
							temp[127:96] = A[127:96];
							temp[95:64] = in;
							temp[63:0] = A[63:0];
						end
					2'b10:
						begin
							temp[127:64] = A[127:64];
							temp[63:32] = in;
							temp[31:0]=A[31:0];
						end
					2'b11:
						begin
							temp[127:32] = A[127:32];
							temp[31:0] = in;
						end
					default: ;
				endcase
			end*/
		//assign A = temp;
		/*logic [127:0] temp;
		if(S==2'b00)
			begin
				temp[127:96] = in;
				temp[95:64] = in2[95:64];
			end
		else if(S==2'b01)
			begin
				temp[127:96] = in2[127:96];
				temp[95:64] = in;
				temp[63:32] = in2[63:32];
			end
		else if(S==2'b10)
			begin
				temp[127:64] = in2[127:64];
				temp[63:32] = in;
				temp[31:0]=in2[31:0];
			end
		else if(S==2'b10)
			begin
				temp[127:32] = in2[127:32];
				temp[31:0] = in;
			end
		assign A = temp;*/
				
endmodule

module counter(input logic [3:0] in, 
					input logic inc, Clk,
					input logic Reset, 
					output logic [3:0] out);
					
		
		logic [3:0] temp;
		
		always_ff @ (posedge Clk)
		begin
			if(inc)
				out<=temp;
			else if(Reset)
				out<= 4'b0000;
		end
		
		always_comb
		begin
		if(out==4'b0100)
			temp = 4'b0000;
		else
			temp = out+4'b0001;
		end		
endmodule

module rcounter(input logic [3:0] in, 
					input logic inc, Clk,
					input logic Reset,
					output logic [3:0] out);
					
		
		logic [3:0] temp;
		
		always_ff @ (posedge Clk)
		begin
			if(inc)
				out<=temp;
			else if(Reset)
				out<= 4'b0000;
		end
		
		always_comb
		begin
		if(out==4'b1010)
			temp = 4'b0000;
		else
			temp = out+4'b0001;
		end		
endmodule

module keycounter(//input logic [4:0] in, 
					input logic inc, Clk,
					input logic Reset, 
					output logic [4:0] out);
					
		logic [4:0] temp;
		
		always_ff @ (posedge Clk)
		begin
			if(inc)
				out<=temp;
			else if(Reset)
				out<= 5'b00000;
		end
		
		always_comb
		begin
		if(out==5'b11000)
			temp = 5'b00000;
		else
			temp = out+5'b00001;
		end	
endmodule