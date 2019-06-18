//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//                                                                       --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------

// color_mapper: Decide which color to be output to VGA for each pixel.
module  color_mapper ( input              is_bird, Clk, is_pipe, Reset, killed,          // Whether current pixel belongs to ball 
                                                              //   or background (computed in ball.sv)
                       input        [9:0] birdy, DrawX, DrawY, pipex,       // Current pixel coordinates
                       output logic [7:0] VGA_R, VGA_G, VGA_B, // VGA RGB output
							  input logic [1:0] currentstate
                     );
    
    logic [7:0] Red, Green, Blue;
	 //logic [7:0] tempr, tempg, tempb;
    logic [3:0] color;
	 logic [3:0] pipecolor,startcolor,bgcolor;
	 logic [10:0] x,y;
	 logic [18:0] bgx,bgy;
	 logic [15:0] px,py;
	 logic [11:0] sx, sy;
	 assign bgx = DrawX;
	 assign bgy = DrawY;
	 assign x =DrawX-10'd320+10'd20;
	 assign y =DrawY-birdy+10'd20;
	 assign px = DrawX-pipex+10'd40;
	 assign py = DrawY;
	 assign sx = DrawX-10'd320+10'd101;
	 assign sy = DrawY-10'd240+10'd10;
    ram colors(.read_address(x+(y*10'd40)),.Clk(Clk),.data_Out(color));
	 piperam pipecolors(.read_address(px+(py*10'd80)),.Clk(Clk),.data_Out(pipecolor));
	 //startram startcolors(.read_address(sx+(sy*10'd203)),.Clk(Clk),.data_Out(startcolor));
	 background background(.read_address(bgx+(bgy*10'd640)),.Clk(Clk),.data_Out(bgcolor));
    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
    
    // Assign color based on is_ball signal
    always_comb
	 begin
		if(Reset)
		begin
			Red = 8'h4d;
			Green = 8'hc1;
			Blue = 8'hcb;
		end
		/*if(currentstate == 0)
			begin
				Red = 8'h00;
				Green = 8'hff;
				Blue = 8'h00;
			end
		if(currentstate == 2)
			begin
				Red = 8'hff;
				Green = 8'hf00;
				Blue = 8'h00;
			end
		if(currentstate == 1)
			begin*/

		if (is_bird == 1'b1 && is_pipe ==1'b0 ) 
			  begin
					case(color)
					4'b0000:
						begin
							case(bgcolor)
							4'b0000:
								begin
									Red = 8'h4d;
									Green = 8'hc1;
									Blue = 8'hcb;
								end
							4'b0001:
								begin
									Red = 8'ha1;
									Green = 8'hdc;
									Blue = 8'hd7;
								end
							4'b0010:
								begin
									Red = 8'hff;
									Green = 8'hff;
									Blue = 8'hff;
								end
							4'b0011:
								begin
									Red = 8'h5d;
									Green = 8'he3;
									Blue = 8'h71;
								end
							default:
								begin
									Red = 8'h4d;
									Green = 8'hc1;
									Blue = 8'hcb;
								end	
							endcase					
						end
					4'b0001:
						begin
							Red = 8'hff;
							Green = 8'hec;
							Blue  = 8'h00;
						end
					4'b0010:
						begin
							Red = 8'h00;
							Green = 8'h00;
							Blue  = 8'h00;
						end
					4'b0011:
						begin
							Red = 8'hff;
							Green = 8'hff;
							Blue  = 8'hff;
						end
					4'b0100:
						begin
							Red = 8'hf6;
							Green = 8'h77;
							Blue  = 8'h00;
						end
					default:
						begin
							case(bgcolor)
							4'b0000:
								begin
									Red = 8'h4d;
									Green = 8'hc1;
									Blue = 8'hcb;
								end
							4'b0001:
								begin
									Red = 8'ha1;
									Green = 8'hdc;
									Blue = 8'hd7;
								end
							4'b0010:
								begin
									Red = 8'hff;
									Green = 8'hff;
									Blue = 8'hff;
								end
							4'b0011:
								begin
									Red = 8'h5d;
									Green = 8'he3;
									Blue = 8'h71;
								end
							default:
								begin
									Red = 8'h4d;
									Green = 8'hc1;
									Blue = 8'hcb;
								end
							endcase
						end
					endcase
			  end
			  else if(is_pipe && is_bird)
			  begin
					case(color)
					4'b0000:
						begin
							case(pipecolor)
									4'b0000:
										begin
											Red = 8'h00;
											Green = 8'ha3;
											Blue = 8'h06;					
										end
									4'b0001:
										begin
											Red = 8'hd6;
											Green = 8'hff;
											Blue  = 8'h75;
										end
									4'b0010:
										begin
											Red = 8'h1a;
											Green = 8'h82;
											Blue  = 8'h00;
										end
									4'b0011:
										begin
											Red = 8'h42;
											Green = 8'hbf;
											Blue  = 8'h28;
										end
									4'b0100:
										begin
											Red = 8'h00;
											Green = 8'h51;
											Blue  = 8'h03;
										end
									4'b0101:
										begin
											Red = 8'h0e;
											Green = 8'h49;
											Blue  = 8'h00;
										end
									4'b0110:
										begin
											Red = 8'hb3;
											Green = 8'hf0;
											Blue  = 8'h5e;
										end
									default:
										begin
											Red = 8'hff;
											Green = 8'h00;
											Blue = 8'h00;					
										end
							endcase					
						end
					4'b0001:
						begin
							Red = 8'hff;
							Green = 8'hec;
							Blue  = 8'h00;
						end
					4'b0010:
						begin
							Red = 8'h00;
							Green = 8'h00;
							Blue  = 8'h00;
						end
					4'b0011:
						begin
							Red = 8'hff;
							Green = 8'hff;
							Blue  = 8'hff;
						end
					4'b0100:
						begin
							Red = 8'hf6;
							Green = 8'h77;
							Blue  = 8'h00;
						end
					default:
						begin
							Red = 8'h00;
							Green = 8'hff;
							Blue = 8'h00;					
						end
					endcase
			  end
			  else if(is_pipe)
			  begin
					case(pipecolor)
					4'b0000:
						begin
							Red = 8'h00;
							Green = 8'ha3;
							Blue = 8'h06;					
						end
					4'b0001:
						begin
							Red = 8'hd6;
							Green = 8'hff;
							Blue  = 8'h75;
						end
					4'b0010:
						begin
							Red = 8'h1a;
							Green = 8'h82;
							Blue  = 8'h00;
						end
					4'b0011:
						begin
							Red = 8'h42;
							Green = 8'hbf;
							Blue  = 8'h28;
						end
					4'b0100:
						begin
							Red = 8'h00;
							Green = 8'h51;
							Blue  = 8'h03;
						end
					4'b0101:
						begin
							Red = 8'h0e;
							Green = 8'h49;
							Blue  = 8'h00;
						end
					4'b0110:
						begin
							Red = 8'hb3;
							Green = 8'hf0;
							Blue  = 8'h5e;
						end
					default:
						begin
							Red = 8'hff;
							Green = 8'h00;
							Blue = 8'h00;					
						end
					endcase
			  end
			  else
			  begin
					case(bgcolor)
							4'b0000:
								begin
									Red = 8'h4d;
									Green = 8'hc1;
									Blue = 8'hcb;
								end
							4'b0001:
								begin
									Red = 8'ha1;
									Green = 8'hdc;
									Blue = 8'hd7;
								end
							4'b0010:
								begin
									Red = 8'hff;
									Green = 8'hff;
									Blue = 8'hff;
								end
							4'b0011:
								begin
									Red = 8'h5d;
									Green = 8'he3;
									Blue = 8'h71;
								end
							default:
								begin
									Red = 8'h4d;
									Green = 8'hc1;
									Blue = 8'hcb;
								end
							endcase						
			  end
			//end
			/*end
			else
					  begin
							Red = 8'h4d;
							Green = 8'hc1;
							Blue = 8'hcb;						
					  end*/
    end 
    
endmodule
