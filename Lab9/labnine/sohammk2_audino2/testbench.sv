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
			AES_KEY = 128'h000102030405060708090a0b0c0d0e0f;
			AES_MSG_ENC = 128'hdaec3055df058e1c39e814ea76f6747e;
			RESET = 1;
			#2
			RESET = 0;
			
			#5
			AES_START = 1;
			#6
			AES_START = 0;
		end
endmodule
		