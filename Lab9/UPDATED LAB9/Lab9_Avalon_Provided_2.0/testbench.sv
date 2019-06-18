module testbench ();

	
    timeunit 10ns;  // how long one unit of time is

    timeprecision 1ns;

    // inputs
    logic RESET;
	 logic AES_START, AES_DONE;
	 logic [127:0] AES_KEY, AES_MSG_ENC, AES_MSG_DEC;
	 logic CLK = 0;
	 
	 AES a(.*);
	 
	 
	 always begin:
		CLOCK_GENERATION
			#1 CLK = ~CLK;
		end
		
		initial begin:
			CLOCK_INITIALIZATION
				CLK = 0;
			end
		initial begin:
			TEST_VECTORS
			AES_START = 0;
			AES_KEY = 128'h3b280014beaac269d613a16bfdc2be03;
			AES_MSG_ENC = 128'h439d619920ce415661019634f59fcf63;
			RESET = 1;
			#2
			RESET = 0;
			
			#5
			AES_START = 1;
			#6
			AES_START = 0;
		end
endmodule
		