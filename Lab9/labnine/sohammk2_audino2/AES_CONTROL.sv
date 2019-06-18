module AES_CONTROL(input logic CLK, Reset, start,
							input logic [3:0] c1,
							input logic [3:0] c2,
							input logic [4:0] key_c,
							input logic [3:0] round,
							output logic i_c1, r_c1,
											 i_c2, r_c2,
											 i_k, r_k,
											 LD_S, done_s,
											 i_round, r_round,
											 firstARK
							);
	
	
	
/*need 4 (maybe 3) counters:
		C1>1 for iterating through 10 rounds
		C2>1 for INSTR_MUX signal to do 4 instructions every round for 9 interative rounds.
		C3>1 for mixCols_MUX as only 1 instance of mixcols is allowed, in-out is only 32 bits so iterate 4 times.
		C4>1 for lastRound_MUX to count to 3 for last 3 instructions after itreative is completed. C2 can be reused maybe?
		
	need 1 start singal that goes from 0 to 1 when decrypt signal from SW is received.
		Goes back to  0 once last lastRound_MUX counter hits 3 and decrypt is done.*/
		
		
		
		
		//state logic
	
	enum logic [3:0] {Halted, first,
								second, third,
								fourth, fifth,
								sixth, seventh,
								eigth, nineth,
								tenth, mixCols, last, done, keyex}   State, Next_state;
		logic next_AL;
								
		always_ff @ (posedge CLK)
			begin
				if (Reset) 
					State <= Halted;
				else 
					State <= Next_state;
			end
		
		always_comb
			begin
				
				Next_state = State;
				
				//default
				LD_S = 1'b0;
				done_s = 1'b0;
				i_c1 = 1'b0; 
				r_c1 = 1'b1;
				i_c2 = 1'b0;
				r_c2 = 1'b1;
				i_k = 1'b0;
				r_k = 1'b1;
				i_round = 1'b0;
				r_round = 1'b0;
				next_AL = 1'b1;
				firstARK = 1'b0;
				//start = 0;				
				unique case(State)
					Halted:
						if(start==1)
							Next_state = keyex;
						else
							Next_state = Halted;
					keyex:
						if(key_c==5'b11000)
							Next_state = first;
						else
							Next_state = keyex;
					first:
						//do first add round key
						if(c1==2'b10)
							Next_state = second;
						else
							Next_state = first;
					second:
						if(c1<2'b11)
							//c2<=c2+1;
							Next_state = second;
			
						else
							Next_state = mixCols;
					third:
						if(c1<2'b11)
							//c2=c2+1;
							Next_state = third;
						else
							//c1 = 2'b00;
							Next_state = mixCols;
					fourth:
						if(c1<2'b11)
							//c1=c1+1;
							Next_state = fourth;
						else
							//c1 = 2'b00;
							Next_state = mixCols;
					fifth:
						if(c1<2'b11)
							//c1=c1+1;
							Next_state = fifth;
						else
							//c1 = 2'b00;
							Next_state = mixCols;
					sixth:
						if(c1<2'b11)
							//c1=c1+1;
							Next_state = sixth;
						else
							//c1 = 2'b00;
							Next_state = mixCols;
					seventh:
						if(c1<2'b11)
							//c1=c1+1;
							Next_state = seventh;
						else
							//c1 = 2'b00;
							Next_state = mixCols;
					eigth:
						if(c1<2'b11)
							//c1=c1+1;
							Next_state = eigth;
						else
							//c1 = 2'b00;
							Next_state = mixCols;
					nineth:
						if(c1<2'b11)
							//c1=c1+1;
							Next_state = nineth;
						else
							//c1 = 2'b00;
							Next_state = mixCols;
					tenth:
						if(c1<2'b11)
							//c1=c1+1;
							Next_state = tenth;
						else
							//c1 = 2'b00;
							Next_state = mixCols;
					last:
						if(c1<2'b11)
							//c1=c1+1;
							Next_state = last;
						else
							//c1 = 2'b00;
							//AES_DONE = 1;
							Next_state = done;
					done:
						if(start == 0)
							Next_state = Halted;
							
					mixCols:
					
						if(c2==3'b100)
							begin
								case(round)
									4'b0010:
										Next_state = third;
									4'b0011:
										Next_state = fourth;
									4'b0100:
										Next_state = fifth;
									4'b0101:
										Next_state = sixth;
									4'b0110:
										Next_state = seventh;
									4'b0111:
										Next_state = eigth;
									4'b1000:
										Next_state = nineth;
									4'b1001:
										Next_state = tenth;
									4'b1010:
										Next_state = last;
									default : ;
								endcase
							end
						else
							Next_state = mixCols;
					default : Next_state = Halted;
				endcase
				case(State)
					Halted: ;
					keyex:
						begin
							if(key_c<5'b11000)
							begin
								i_k = 1'b1;
								firstARK = 1'b1;
							end
							else
								i_k = 1'b0;
						end
					mixCols:
						begin
							if(c2<3'b100)
								begin
									LD_S = 1'b0;
									r_c2 = 1'b0;
									i_c2 = 1'b1;
									r_c1 = 1'b0;
									next_AL = 1'b1;
									i_round = 1'b0;
									r_round = 1'b0;
								end
							else
								begin
									next_AL = 1'b0;
									LD_S = 1'b1;
									i_c2 = 1'b0;
									r_c2 = 1'b1;
									r_round = 1'b0;
									r_c1 = 1'b1;
								end
						end
					first:
						begin
							if(c1==2'b10)
								begin
									LD_S = 1'b1;
									r_c1 = 1'b1;
									i_c1 = 1'b0;
									next_AL = 1'b1;
									i_round = 1'b1;
								end
							else
								begin
									r_round = 1'b1;
									next_AL = 1'b0;
									LD_S = 1'b0;
									i_c1 = 1'b1;
									r_c1 = 1'b0;
									i_round = 1'b0;
								end
						end
					second: 
						begin
							if(c1<2'b11)
								begin
									LD_S = 1'b1;
									r_c1 = 1'b0;
									i_c1 = 1'b1;
									next_AL = 1'b1;
									i_round = 1'b0;
								end
							else
								begin
									//next_AL = 1'b0;
									LD_S = 1'b0;
									i_c1 = 1'b0;
									r_c1 = 1'b0;
									i_round = 1'b1;
								end
							//round = 4'b0001;
						end
					third:
						begin
							if(c1<2'b11)
								begin
									LD_S = 1'b1;
									r_c1 = 1'b0;
									i_c1 = 1'b1;
									next_AL = 1'b1;
									i_round = 1'b0;
								end
							else
								begin
									next_AL = 1'b0;
									LD_S = 1'b0;
									i_c1 = 1'b0;
									r_c1 = 1'b0;
									i_round = 1'b1;
								end
							//round = 4'b0010;
						end
					fourth: 
						begin
							if(c1<2'b11)
								begin
									LD_S = 1'b1;
									r_c1 = 1'b0;
									i_c1 = 1'b1;
									next_AL = 1'b1;
									i_round = 1'b0;
								end
							else
								begin
									next_AL = 1'b0;
									LD_S = 1'b0;
									i_c1 = 1'b0;
									r_c1 = 1'b0;
									i_round = 1'b1;
								end
							//round = 4'b0011;
						end
					fifth: 
						begin
							if(c1<2'b11)
								begin
									LD_S = 1'b1;
									r_c1 = 1'b0;
									i_c1 = 1'b1;
									next_AL = 1'b1;
									i_round = 1'b0;
								end
							else
								begin
									next_AL = 1'b0;
									LD_S = 1'b0;
									i_c1 = 1'b0;
									r_c1 = 1'b0;
									i_round = 1'b1;
								end
							//round = 4'b0100;
						end
					sixth:
						begin
							if(c1<2'b11)
								begin
									LD_S = 1'b1;
									r_c1 = 1'b0;
									i_c1 = 1'b1;
									next_AL = 1'b1;
									i_round = 1'b0;
								end
							else
								begin
									next_AL = 1'b0;
									LD_S = 1'b0;
									i_c1 = 1'b0;
									r_c1 = 1'b0;
									i_round = 1'b1;
								end
							//round = 4'b0101;
						end
					seventh:
						begin	
							if(c1<2'b11)
								begin
									LD_S = 1'b1;
									r_c1 = 1'b0;
									i_c1 = 1'b1;
									next_AL = 1'b1;
									i_round = 1'b0;
								end
							else
								begin
									next_AL = 1'b0;
									LD_S = 1'b0;
									i_c1 = 1'b0;
									r_c1 = 1'b0;
									i_round = 1'b1;
								end
							//round = 4'b0110;
						end
					eigth:
						begin
							if(c1<2'b11)
								begin
									LD_S = 1'b1;
									r_c1 = 1'b0;
									i_c1 = 1'b1;
									next_AL = 1'b1;
									i_round = 1'b0;
								end
							else
								begin
									next_AL = 1'b0;
									LD_S = 1'b0;
									i_c1 = 1'b0;
									r_c1 = 1'b0;
									i_round = 1'b1;
								end
							//round = 4'b0111;
						end
					nineth: 
						begin
							if(c1<2'b11)
								begin
									LD_S = 1'b1;
									r_c1 = 1'b0;
									i_c1 = 1'b1;
									next_AL = 1'b1;
									i_round = 1'b0;
								end
							else
								begin
									next_AL = 1'b0;
									LD_S = 1'b0;
									i_c1 = 1'b0;
									r_c1 = 1'b0;
									i_round = 1'b1;
								end
							//round = 4'b1000;
						end
					tenth: 
						begin
							if(c1<2'b11)
								begin
									LD_S = 1'b1;
									r_c1 = 1'b0;
									i_c1 = 1'b1;
									next_AL = 1'b1;
									i_round = 1'b0;
								end
							else
								begin
									next_AL = 1'b0;
									LD_S = 1'b0;
									i_c1 = 1'b0;
									r_c1 = 1'b0;
									i_round = 1'b1;
								end
							//round = 4'b1001;
						end
					last: 
						begin
							if(c1<2'b11)
								begin
									LD_S = 1'b1;
									r_c1 = 1'b0;
									i_c1 = 1'b1;
									next_AL = 1'b1;
									i_round = 1'b0;
								end
							else
								begin
									next_AL = 1'b0;
									LD_S = 1'b0;
									i_c1 = 1'b0;
									r_c1 = 1'b0;
									i_round = 1'b1;
								end
							//round = 4'b1010;
						end
					done:
						begin
							done_s =1;
						end
					default : ;
				endcase
		end				
		
endmodule
