//Control unit based on a moore state machine, taken from lab 4. Has 19 states from execute to hold.

module control(
		input run,
		input clear,
		input clk,
		input reset,
		input M,
		output logic clr_ld,
		output logic shift,
		output logic add,
		output logic sub);
		
		
		
		enum logic [4:0] {execute,hold,rerun,
						firstAdd,firstS,
						secondAdd,secondS,
						thirdAdd,thirdS,
						fourthAdd, fourthS,
						fifthAdd, fifthS,
						sixthAdd, sixthS,
						seventhAdd, seventhS,
						eightAdd, eightS} curr, next;
						
		always_ff @ (posedge clk or posedge reset)
		begin
				if(reset)
						curr <= execute;
				else
						curr <= next;
		end
		
		always_comb
		begin
			next = curr;
			unique case (curr)
				execute:		if(run)
									next = rerun;
				rerun:		next = firstAdd;
				firstAdd: 	next = firstS;
				firstS: 		next = secondAdd;
				secondAdd:	next = secondS;
				secondS:		next = thirdAdd;
				thirdAdd: 	next = thirdS;
				thirdS:		next = fourthAdd;
				fourthAdd: 	next = fourthS;
				fourthS:		next = fifthAdd;
				fifthAdd: 	next = fifthS;
				fifthS: 		next = sixthAdd;
				sixthAdd: 	next = sixthS;
				sixthS:		next = seventhAdd;
				seventhAdd:	next = seventhS;
				seventhS:	next = eightAdd;
				eightAdd:	next = eightS;
				eightS:		next = hold;
				hold:			if(~run)
									next = execute;
			endcase
		end
		
		always_comb
		begin
			case(curr)
				rerun:
					begin
						clr_ld = 1'b1;
						shift = 0;
						add = 0;
						sub = 0;
					end
				
				execute, hold:
					begin
						clr_ld=clear;
						shift = 0;
						add = 0;
						sub = 0;
					end
				firstAdd, secondAdd, thirdAdd, fourthAdd, fifthAdd,
				sixthAdd, seventhAdd:
					begin
						clr_ld = 0;
						shift = 0;
						if(M)
							begin
								add = 1;
								sub = 0;
							end
						else
							begin
								add = 0;
								sub = 0;
							end
					end
				eightAdd:
					begin
						clr_ld = 0;
						shift = 0;
						if(M)
							begin
								add = 0;
								sub = 1;
							end
						else
							begin
								add = 0;
								sub = 0;
							end
					end
				firstS, secondS, thirdS, fourthS, fifthS,
				sixthS, seventhS, eightS:
					begin
						clr_ld = 0;
						shift = 1;
						add = 0;
						sub = 0;
					end
			endcase
		end
endmodule