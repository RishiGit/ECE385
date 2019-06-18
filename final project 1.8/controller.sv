module controller(input logic Clk,
						input logic start,
						//output logic iscore,
						input logic Reset,
						output logic [1:0] currentstate,
						input logic killed,
						output logic finalkilled
										);
		
		
		//elements for game
		//counter
		enum logic[2:0] {halted, 
								alive, dead} state, next_state;
		//assign currentstate = state;						
		always_ff @ (posedge Clk)
			begin
				if(Reset)
					state<=halted;
				else
					state<=next_state;
			end
		
		always_comb
			begin
				next_state = state;
				
				unique case(state)
					halted:
						if(start == 1'b1)
							next_state = alive;
						else
							next_state = halted;
					alive:
						if(killed == 1'b1)
							next_state = dead;
						else
							next_state = alive;
					dead:
						if(start == 1'b1)
						begin
							next_state = halted;
						end
						else
						begin
							next_state = dead;
						end
					default : next_state = halted;
				endcase
				case(state)
					halted:
						begin
							finalkilled = 1'b0;
							currentstate = 0;
						end
					alive:
						begin
							currentstate = 1;
							finalkilled = 1'b0;
						end
					dead:
						begin
							currentstate = 2;
							finalkilled = 1'b1;
						end
					default: 
						begin
							currentstate = 0;
							finalkilled = 1'b0;
						end
				endcase
			end
endmodule
						
							
							
			