module pipe(input 			  Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawY, DrawX,       // Current pixel coordinates
               output logic  is_pipe,
					output logic [9:0] pypos, pxpos,
					input logic [1:0] currentstate,
					input logic [7:0] score,
					input [1:0]speed);
					
	 parameter [9:0] pipe_X_Center = 10'd800;  // Center position on the X axis
    parameter [9:0] pipe_Y_Center = 10'd240;  // Center position on the Y axis
    parameter [9:0] pipe_X_Step = 10'd0;      // Step size on the X axis
    
	 logic [9:0] pipe_X_Pos, pipe_X_Motion;
    logic [9:0] pipe_X_Pos_in, pipe_X_Motion_in;
	 logic [9:0] pipe_Y_Pos, pipe_Y_Motion;
    logic [9:0] pipe_Y_Pos_in, pipe_Y_Motion_in;
	 logic [9:0] ymin_in, ymax_in;
	 logic underpipe_in;
	 assign pypos = pipe_Y_Pos;
	 assign pxpos = pipe_X_Pos;
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
            pipe_X_Pos <= 10'd800;
            pipe_Y_Pos <= pipe_Y_Center;
            pipe_X_Motion <= 10'd0;
        end
		  if(currentstate == 0)
		  begin
				pipe_X_Pos <= 10'd800;
            pipe_Y_Pos <= pipe_Y_Center;
            pipe_X_Motion <= 10'd0;
		  end
		  else if(currentstate == 2)
		  begin
				pipe_X_Pos <= pipe_X_Pos_in;
            pipe_Y_Pos <= pipe_Y_Pos_in;
            pipe_X_Motion <= 10'd0;
		  end
        else
        begin
            pipe_X_Pos <= pipe_X_Pos_in;
            pipe_Y_Pos <= pipe_Y_Pos_in;
            pipe_X_Motion <= pipe_X_Motion_in;
				pipe_Y_Motion <= pipe_Y_Motion_in;
        end
    end
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
    always_comb
    begin
        pipe_X_Pos_in = pipe_X_Pos;
        pipe_X_Motion_in = pipe_X_Motion;
		  pipe_Y_Pos_in = pipe_Y_Pos;
        pipe_Y_Motion_in = pipe_Y_Motion;
        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin
            // Be careful when using comparators with "logic" datatype because compiler treats 
            //   both sides of the operator as UNSIGNED numbers.
            // e.g. bird_Y_Pos - bird_Size <= bird_Y_Min 
            // If bird_Y_Pos is 0, then bird_Y_Pos - bird_Size will not be -4, but rather a large positive number.
				if(pipe_Y_Pos >=10'd380)
				begin
					pipe_Y_Pos_in = 10'd120;
				end
            else if( pipe_X_Pos <= 10'd0+speed )  // pipe is at the bottom edge, BOUNCE!
						begin
                //killed = 1'b1;  // 2's complement.
						pipe_X_Motion_in = 10'd800;
						pipe_Y_Pos_in = pipe_Y_Pos + 10'd45;
						end
            else
				begin
					pipe_X_Motion_in = ~(10'd2+speed+speed)+1'b1;
					pipe_Y_Motion_in = 10'd0;
					pipe_Y_Pos_in = pipe_Y_Pos;
				end
            pipe_X_Pos_in = pipe_X_Pos + pipe_X_Motion;
        end
    end
    
    // Compute whether the pixel corresponds to bird or background
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
    int DistX, DistY, Size;
	 int RX, RY;
    assign DistX = DrawX - pipe_X_Pos;
	 always_comb begin
			if(DrawX >= pipe_X_Pos)
				RX = DistX;
			else
				RX = ~DistX + 1'b1;
		end
	 //assign RX = ~DistX + 1'b1;
    assign DistY = DrawY - pipe_Y_Pos;
	 always_comb begin
	 if(DrawY >= pipe_Y_Pos)
				RY = DistY;
			else
				RY = ~DistY + 1'b1;
		end
	 //assign RY = ~DistY + 1'b1;
    always_comb begin
        if (RX <= 10'd40 && RY >=10'd40)
            is_pipe = 1'b1;
        else
            is_pipe = 1'b0;
        /* The bird's (pixelated) circle is generated using the standard circle formula.  Note that while 
           the single line is quite powerful descriptively, it causes the synthesis tool to use up three
           of the 12 available multipliers on the chip! */
    end
    
endmodule