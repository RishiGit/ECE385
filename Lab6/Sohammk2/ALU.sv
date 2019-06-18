module ALU (input logic [15:0] A, B,
				input logic [1:0] ALUK,
				output logic [15:0] dout);
				
				
			always_comb
			
			begin
			
						case(ALUK)
							
								2'b00:
								
										dout = A + B;
										
								2'b01:
								
										dout = A & B;
										
								2'b10:
								
										dout = ~A;
										
								2'b11:
								
										dout = A;
										
						endcase
						
			end
			
			
endmodule 