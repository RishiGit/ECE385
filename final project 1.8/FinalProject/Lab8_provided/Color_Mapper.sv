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
module  color_mapper ( input              is_bird, Clk,            // Whether current pixel belongs to ball 
                                                              //   or background (computed in ball.sv)
                       input        [9:0] birdy, DrawX, DrawY,       // Current pixel coordinates
                       output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );
    
    logic [7:0] Red, Green, Blue;
    logic [2:0] color;
	 logic [1:0] bgcolor;
	 logic [10:0] x;
	 assign x =DrawX-10'd320+10'd20;
	 logic [10:0] y;
	 assign y =DrawY-birdy+10'd20;
    ram colors(.read_address(x+(y*10'd40)),.Clk(Clk),.data_Out(color));
	 background background(.read_address(DrawX+(DrawY*10'd640)),.Clk(Clk),.data_Out(bgcolor));
    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
    
    // Assign color based on is_ball signal
    always_comb
	 begin
   if (is_bird == 1'b1) 
        begin
				case(color)
				3'b000:
					begin
						Red = 8'h3f; 
						Green = 8'h00;
						Blue = 8'h7f - {1'b0, DrawX[9:3]};					
					end
				3'b001:
					begin
						Red = 8'hff;
						Green = 8'hec;
						Blue  = 8'h00;
					end
				3'b010:
					begin
						Red = 8'h00;
						Green = 8'h00;
						Blue  = 8'h00;
					end
				3'b011:
					begin
						Red = 8'hff;
						Green = 8'hff;
						Blue  = 8'hff;
					end
				3'b100:
					begin
						Red = 8'hf6;
						Green = 8'h77;
						Blue  = 8'h00;
					end
				default: 
					begin
						Red = 8'h3f; 
						Green = 8'h00;
						Blue = 8'h7f - {1'b0, DrawX[9:3]};
					end
				endcase
        end
        else 
        begin
            // Background with nice color gradient
				case(bgcolor)
				2'b00:
					begin
						Red = 8'h4d;
						Green = 8'hc1;
						Blue = 8'hcb;
					end
				2'b01:
					begin
						Red = 8'hff;
						Green = 8'hff;
						Blue = 8'hff;
					end
				2'b10:
					begin
						Red = 8'ha1;
						Green = 8'hdc;
						Blue = 8'hd7;
					end
				2'b11:
					begin
						Red = 8'h5d;
						Green = 8'he3;
						Blue = 8'h71;
					end
				default: 
					begin
						Red = 8'h3f; 
						Green = 8'h00;
						Blue = 8'h7f - {1'b0, DrawX[9:3]};
					end
				endcase
					
        end
    end 
    
endmodule
