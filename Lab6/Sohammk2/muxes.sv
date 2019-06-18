module mux_PC(input logic [15:0] A, B, C,
				  input logic [1:0] S,
				  output logic [15:0] Out);
		
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
						Out = 16'h0000;
				endcase
			end
endmodule

module mux_MDR(input logic [15:0] A, B,
				  input logic S,
				  output logic [15:0] Out);
		
		always_comb
			begin
				case(S)
					1'b0:
						Out = A;
					1'b1:
						Out = B;
				endcase
			end
endmodule

module mux_GATES(input logic [15:0] A, B, C, D, //ordering maybe an issue?
				  input logic [3:0] S,
				  output logic [15:0] Out);
		
		always_comb
			begin
				case(S)
					4'b1000:
						Out = A;
					4'b0100:
						Out = B;
					4'b0010:
						Out = C;
					4'b0001:
						Out = D;
					default:
						Out = 16'h0000;
				endcase
			end
endmodule

module mux_ADDR2(input logic [15:0] A, B, C, D,
				  input logic [1:0] S,
				  output logic [15:0] Out);
		
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
					default:
						Out = 16'h0000;
				endcase
			end
endmodule

module mux_ADDR1(input logic [15:0] A, B,
				  input logic S,
				  output logic [15:0] Out);
		
		always_comb
			begin
				case(S)
					1'b0:
						Out = A;
					1'b1:
						Out = B; 
					default:
						Out = 16'h0000;
				endcase
			end
endmodule

module mux_DR(input logic [2:0] A,
				  input logic S,
				  output logic [2:0] Out);
		
		always_comb
			begin
				case(S)
					1'b0:
						Out = A;
					1'b1:
						Out = 3'b111;
				endcase
			end
endmodule
module mux_SR1(input logic [2:0] A,B,
				  input logic S,
				  output logic [2:0] Out);
		
		always_comb
			begin
				case(S)
					1'b0:
						Out = A;
					1'b1:
						Out = B;
				endcase
			end
endmodule
module mux_SR2(input logic [15:0] A,B,
				  input logic S,
				  output logic [15:0] Out);
		
		always_comb
			begin
				case(S)
					1'b0:
						Out = A;
					1'b1:
						Out = B;
				endcase
			end
endmodule

module NZP(input logic Clk, NI, ZI, PI, LD_CC,
				output logic NO, ZO, PO);
		always_ff @ (posedge Clk)
			begin
				 if(LD_CC)
					begin
						NO<=NI;
						ZO<=ZI;
						PO<=PI;
					end
			end
endmodule

	
