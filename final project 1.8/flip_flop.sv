module flip_flop (input  logic Clk, Reset, Load,
				  //Shift_In, Shift_En,
              input  logic D,
              //output logic Shift_Out,
              output logic Data_Out);

    always_ff @ (posedge Clk)
    begin
	 	 if (Reset) //notice, this is a sycnrhonous reset, which is recommended on the FPGA
			  Data_Out <= 1'b0;
		 else if (Load)
			  Data_Out <= D;
		 /*else if (Shift_En)
		 begin
			  //concatenate shifted in data to the previous left-most 3 bits
			  //note this works because we are in always_ff procedure block
			  Data_Out <= { Shift_In, Data_Out[15:1] }; 
	    end*/
    end
	
    //assign Shift_Out = Data_Out[0];

endmodule