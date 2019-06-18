//-------------------------------------------------------------------------
//    bird.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  12-08-2017                               --
//    Spring 2018 Distribution                                           --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  bird ( input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
									  killed,
               input [9:0]   DrawY, DrawX,    // Current pixel coordinates
               output logic  is_bird,
					input [7:0] keycode, press,
					output logic [9:0] birdouty,// Whether current pixel belongs to bird or background
					input logic [1:0] currentstate,
					output logic [10:0] birdy10pos
              );
    
   parameter [9:0] bird_X_Center = 10'd320;  // Center position on the X axis
    parameter [9:0] bird_Y_Center = 10'd240;  // Center position on the Y axis
    parameter [9:0] bird_Y_Min = 10'd0;       // Topmost point on the Y axis
    parameter [9:0] bird_Y_Max = 10'd479;     // Bottommost point on the Y axis
    parameter [9:0] bird_X_Step = 10'd0;      // Step size on the X axis
    parameter [9:0] bird_Y_Step = 10'd1;      // Step size on the Y axis
    parameter [9:0] bird_Size = 10'd4;        // bird size
    
    logic [10:0] bird_Y_Pos, bird_Y_Motion;
    logic [9:0] bird_Y_Pos_in, bird_Y_Motion_in;
	 assign birdouty = bird_Y_Pos[9:0];
	 assign birdy10pos = bird_Y_Pos;
	 logic [9:0] bird_X_Pos, bird_X_Motion;
    logic [9:0] bird_X_Pos_in, bird_X_Motion_in;
    //////// Do not modify the always_ff blocks. ////////
    // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end
    // Update registers
    always_ff @ (posedge Clk)
    begin
		  if (Reset)
        begin
            bird_X_Pos <= bird_X_Center;
            bird_Y_Pos <= bird_Y_Pos_in;
            bird_X_Motion <= 10'd0;
            bird_Y_Motion <= 10'd0;
        end
		  /*if (currentstate == 0 || currentstate == 2)
		  begin
				bird_X_Pos <= bird_X_Center;
            bird_Y_Pos <= bird_Y_Center;
            bird_X_Motion <= 10'd0;
            bird_Y_Motion <= 10'd0;
		  end*/
		  if (currentstate == 0)
		  begin
				bird_X_Pos <= bird_X_Center;
            bird_Y_Pos <= bird_Y_Center;
            bird_X_Motion <= 10'd0;
            bird_Y_Motion <= 10'd0;
		  end
		  else if (currentstate == 2)
		  begin
				bird_X_Pos <= bird_X_Center;
            bird_Y_Pos <= bird_Y_Pos_in;
            bird_X_Motion <= 10'd0;
            bird_Y_Motion <= bird_Y_Motion_in;
		  end
        else
        begin
            bird_X_Pos <= 10'd320;
            bird_Y_Pos <= bird_Y_Pos_in;
            bird_X_Motion <= 10'd0;
            bird_Y_Motion <= bird_Y_Motion_in;
        end
    end
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
        //bird_X_Pos_in = bird_X_Pos;
        bird_Y_Pos_in = bird_Y_Pos;
        //bird_X_Motion_in = bird_X_Motion;
        bird_Y_Motion_in = bird_Y_Motion;
        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin
            // Be careful when using comparators with "logic" datatype because compiler treats 
            //   both sides of the operator as UNSIGNED numbers.
            // e.g. bird_Y_Pos - bird_Size <= bird_Y_Min 
            // If bird_Y_Pos is 0, then bird_Y_Pos - bird_Size will not be -4, but rather a large positive number.
				/*if(bird_Y_Pos<=ymax)
						begin
                  killedd_in = 1'b1;  // 2's complement.
						bird_Y_Motion_in = 10'd0;
						end
				if(bird_Y_Pos>=ymin)
						begin
                  killedd_in = 1'b1;  // 2's complement.
						bird_Y_Motion_in = 10'd0;
						end*/
				if( bird_Y_Pos >= 10'd480 && bird_Y_Pos <10'd490)  // bird is at the bottom edge, BOUNCE!
						begin  // 2's complement.
						bird_Y_Motion_in = 10'd0;
						end
            // TODO: Add other boundary detections and handle keypress here.
				else if(keycode == 8'h29 && press==1'b1 && killed == 1'b0 && bird_Y_Pos<10'd504)
					begin	
						bird_Y_Motion_in = ~(bird_Y_Step+10'd3)+1'b1;
					end
				else if(bird_Y_Pos>=10'd491)
					begin
						bird_Y_Motion_in = 10'd1;
					end
				else if ( bird_Y_Pos + 10'd16 < bird_Y_Max && bird_Y_Pos >10'd10 && killed == 1'b0)
					begin
						bird_Y_Motion_in = 10'd1+1'b1;
					end
				else if ( bird_Y_Pos + 10'd16 < bird_Y_Max && bird_Y_Pos >10'd10 && killed == 1'b1)
					begin
						bird_Y_Motion_in = 10'd3+1'b1;
					end
            // Update the bird's position with its motion
            bird_Y_Pos_in = bird_Y_Pos + bird_Y_Motion;
        end
        
        /**************************************************************************************
            ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
            Hidden Question #2/2:
               Notice that bird_Y_Pos is updated using bird_Y_Motion. 
              Will the new value of bird_Y_Motion be used when bird_Y_Pos is updated, or the old? 
              What is the difference between writing
                "bird_Y_Pos_in = bird_Y_Pos + bird_Y_Motion;" and 
                "bird_Y_Pos_in = bird_Y_Pos + bird_Y_Motion_in;"?
              How will this impact behavior of the bird during a bounce, and how might that interact with a response to a keypress?
              Give an answer in your Post-Lab.
        **************************************************************************************/
    end
    
    // Compute whether the pixel corresponds to bird or background
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
    int DistX, DistY, Size;
	 int RX, RY;
    assign DistX = DrawX - bird_X_Pos;
	 always_comb begin
			if(DrawX >= bird_X_Pos)
				RX = DistX;
			else
				RX = ~DistX + 1'b1;
		end
	 //assign RX = ~DistX + 1'b1;
    assign DistY = DrawY - bird_Y_Pos;
	 always_comb begin
	 if(DrawY >= bird_Y_Pos)
				RY = DistY;
			else
				RY = ~DistY + 1'b1;
		end
	 //assign RY = ~DistY + 1'b1;
	 
    assign Size = 10'd20;
    always_comb begin
        if (RX <= 10'd20 && RY <=10'd20)
            is_bird = 1'b1;
        else
            is_bird = 1'b0;
        /* The bird's (pixelated) circle is generated using the standard circle formula.  Note that while 
           the single line is quite powerful descriptively, it causes the synthesis tool to use up three
           of the 12 available multipliers on the chip! */
    end
    
endmodule