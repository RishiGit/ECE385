//top level entry for multiplier. Referenced from 8bit logic processor (lab4). Instantiates all modules and makes them work together.

module Processor (input logic clk,
										reset,
										execute,
										clear,
						output logic extendbit,
						input logic [7:0] switches,				// DEBUG
                  output logic [7:0]  Aval,    // DEBUG
                                Bval,    // DEBUG
                  output logic [6:0]  AhexL,
                                AhexU,
                                BhexL,
                                BhexU);
	 
	 logic [7:0] A,B;
	 logic [8:0] extendA;
	 logic reset_SH, clear_SH,execute_SH, bIN, add, sub, clr_ld, shift;
	 //Instantiation of modules here
	 ninebra		adder(.xin(A),.yin(switches),.cin(sub),.sum(extendA));
	 flip_flop	xholder(.clk(clk),.load(add | sub),.reset(reset_SH | clr_ld)
								,.in(extendA[8]),.out(extendbit));
	 register    registerA (
                        .Clk(clk),
                        .Reset(clr_ld | reset_SH),
                        .Shift_In(extendbit),
								.Load(add | sub),
								.Shift_En(shift),
								.D(extendA[7:0]),
								.Shift_Out(bIN),
								.Data_Out(A));
	 
     register    registerB (
                        .Clk(clk),
                        .Reset(reset_SH),
                        .Shift_In(bIN),
								.Load(clear_SH),
								.Shift_En(shift),
								.D(switches),
								.Shift_Out(),
								.Data_Out(B));
		control 			controllogic(.clk(clk),
								.reset(reset_SH),
								.clear(clear_SH),
								.run(execute_SH),
								.M(B[0]),
								.shift(shift),
								.clr_ld(clr_ld),
								.add(add),
								.sub(sub));
								
	 HexDriver        HexAL (
                        .In0(A[3:0]),
                        .Out0(AhexL) );
	 HexDriver        HexBL (
                        .In0(B[3:0]),
                        .Out0(BhexL) );
								
	 //When you extend to 8-bits, you will need more HEX drivers to view upper nibble of registers, for now set to 0
	 HexDriver        HexAU (
                        .In0(A[7:4]),
                        .Out0(AhexU) );	
	 HexDriver        HexBU (
                       .In0(B[7:4]),
                        .Out0(BhexU) );
		assign Aval = A;
		assign Bval = B;
								
	  //Input synchronizers required for asynchronous inputs (in this case, from the switches)
	  //These are array module instantiations
	  //Note: S stands for SYNCHRONIZED, H stands for active HIGH
	  //Note: We can invert the levels inside the port assignments
	  sync button_sync[2:0] (clk, {~reset, ~clear,~execute}, {reset_SH, clear_SH, execute_SH});
	  //sync Din_sync[7:0] (Clk, Din, Din_S);
	  //sync F_sync[2:0] (Clk, F, F_S);
	  //sync R_sync[1:0] (Clk, R, R_S);
endmodule