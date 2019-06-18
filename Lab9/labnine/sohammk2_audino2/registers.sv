module REGS(input logic CLK, RESET, AVL_WRITE, AVL_READ, AVL_CS,
				input logic [3:0] AVL_BYTE_EN, AVL_ADDR,
				input logic [31:0] DATA_IN,
				output logic [31:0] DATA_OUT);
	
	logic [15:0] [31:0] REG;
	logic [32:0] newdata;
	
	always_ff @ (posedge CLK)
	
		begin
				
				if(RESET)
				
						begin
						
							REG[0] <= 32'h0; 							
							REG[1] <= 32'h0;
							REG[2] <= 32'h0;
							REG[3] <= 32'h0;
							REG[4] <= 32'h0;
							REG[5] <= 32'h0;
							REG[6] <= 32'h0;
							REG[7] <= 32'h0;
							REG[8] <= 32'h0;
							REG[9] <= 32'h0;
							REG[10] <= 32'h0;
							REG[11] <= 32'h0;
							REG[12] <= 32'h0;
							REG[13] <= 32'h0;
							REG[14] <= 32'h0;
							REG[15] <= 32'h0;
							
						end
						
				else if(AVL_WRITE & AVL_CS)
				
						case(AVL_ADDR)
						
							4'b0000: REG[0] <= newdata;
							4'b0001: REG[1] <= newdata;
							4'b0010: REG[2] <= newdata;
							4'b0011: REG[3] <= newdata;
							4'b0100: REG[4] <= newdata;
							4'b0101: REG[5] <= newdata;
							4'b0110: REG[6] <= newdata;
							4'b0111: REG[7] <= newdata;
							4'b1000: REG[8] <= newdata;
							4'b1001: REG[9] <= newdata;
							4'b1010: REG[10] <= newdata;
							4'b1011: REG[11] <= newdata;
							4'b1100: REG[12] <= newdata;
							4'b1101: REG[13] <= newdata;
							4'b1110: REG[14] <= newdata;
							4'b1111: REG[15] <= newdata;
							default: ;
							
						endcase
		
		end
		

		always_comb
				
					begin
					
							case(AVL_BYTE_EN)
								
								4'b0001: newdata[7:0] <= DATA_IN[7:0];
								4'b0010: newdata[15:8] <= DATA_IN[15:8];
								4'b0011: newdata[15:0] <= DATA_IN[15:0];
								4'b0100: newdata[23:16] <= DATA_IN[23:16];
								4'b1000: newdata[31:24] <= DATA_IN[31:24];
								4'b1100: newdata[31:16] <= DATA_IN[31:16];
								4'b1111: newdata[31:0] <= DATA_IN[31:0];
								default: ;
								
							endcase
							
					if(AVL_READ & AVL_CS)
				
						case(AVL_ADDR)
						
							4'b0000:  DATA_OUT <= REG[0];
							4'b0001:  DATA_OUT <= REG[1];
							4'b0010:  DATA_OUT <= REG[2];
							4'b0011:  DATA_OUT <= REG[3];
							4'b0100:  DATA_OUT <= REG[4];
							4'b0101:  DATA_OUT <= REG[5];
							4'b0110:  DATA_OUT <= REG[6];
							4'b0111:  DATA_OUT <= REG[7];
							4'b1000:  DATA_OUT <= REG[8];
							4'b1001:  DATA_OUT <= REG[9];
							4'b1010:  DATA_OUT <= REG[10];
							4'b1011:  DATA_OUT <= REG[11];
							4'b1100:  DATA_OUT <= REG[12];
							4'b1101:  DATA_OUT <= REG[13];
							4'b1110:  DATA_OUT <= REG[14];
							4'b1111:  DATA_OUT <= REG[15];
							default: ;
							
						endcase
				end
		
endmodule		
module reg_8 (input  logic Clk, Reset, Load,
				  //Shift_In, Shift_En,
              input  logic [7:0]  D,
              //output logic Shift_Out,
              output logic [7:0]  Data_Out);

    always_ff @ (posedge Clk)
    begin
	 	 if (Reset) //notice, this is a sycnrhonous reset, which is recommended on the FPGA
			  Data_Out <= 8'h0;
		 else if (Load)
			  Data_Out <= D;
		 /*else if (Shift_En)
		 begin
			  //concatenate shifted in data to the previous left-most 3 bits
			  //note this works because we are in always_ff procedure block
			  Data_Out <= { Shift_In, Data_Out[7:1] }; 
	    end*/
    end
	
    //assign Shift_Out = Data_Out[0];

endmodule

module reg_4 (input  logic Clk, Reset, Load,
				  //Shift_In, Shift_En,
              input  logic [3:0]  D,
              //output logic Shift_Out,
              output logic [3:0]  Data_Out);

    always_ff @ (posedge Clk)
    begin
	 	 if (Reset) //notice, this is a sycnrhonous reset, which is recommended on the FPGA
			  Data_Out <= 4'h0;
		 else if (Load)
			  Data_Out <= D;
		 /*else if (Shift_En)
		 begin
			  //concatenate shifted in data to the previous left-most 3 bits
			  //note this works because we are in always_ff procedure block
			  Data_Out <= { Shift_In, Data_Out[3:1] }; 
	    end*/
    end
	
    //assign Shift_Out = Data_Out[0];

endmodule

module reg_16 (input logic Clk, Reset, Load,
				  //Shift_In, Shift_En,
              input  logic [15:0]  D,
              //output logic Shift_Out,
              output logic [15:0]  Data_Out);

    always_ff @ (posedge Clk)
    begin
	 	 if (Reset) //notice, this is a sycnrhonous reset, which is recommended on the FPGA
			  Data_Out <= 16'h0;
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

module reg_128 (input logic Clk, Reset, Load, first,
				  //Shift_In, Shift_En,
              input  logic [127:0]  D, d2,
              //output logic Shift_Out,
              output logic [127:0]  Data_Out);

    always_ff @ (posedge Clk)
    begin
		 if(first)
			Data_Out <= d2;
	 	 else if (Reset) //notice, this is a sycnrhonous reset, which is recommended on the FPGA
			  Data_Out <= 128'h0;
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

module eightreg_16 (input logic Clk, Reset, Load,
							input logic [15:0] D,
							input logic [2:0] SR1IN, SR2, DRIN,
							
							output logic [15:0] SR2O, SR1O);
		
		logic [7:0][15:0] regs;
		
		always_ff @ (posedge Clk)
		
			begin
					if(Reset)
						
						begin
						
							regs[0] <= 16'h0;
							regs[1] <= 16'h0;
							regs[2] <= 16'h0;
							regs[3] <= 16'h0;
							regs[4] <= 16'h0;
							regs[5] <= 16'h0;
							regs[6] <= 16'h0;
							regs[7] <= 16'h0;
							
					
						end
						
					else if (Load)
						
						case(DRIN)
							
								3'b000: regs[0] <= D;
								3'b001: regs[1] <= D;
								3'b010: regs[2] <= D;
								3'b011: regs[3] <= D;
								3'b100: regs[4] <= D;
								3'b101: regs[5] <= D;
								3'b110: regs[6] <= D;
								3'b111: regs[7] <= D;
								
								default ;
								
						endcase
						
			end
			
			always_comb
			
			begin
			
						case(SR1IN)
							
								3'b000: SR1O <= regs[0];
								3'b001: SR1O <= regs[1];
								3'b010: SR1O <= regs[2];
								3'b011: SR1O <= regs[3];
								3'b100: SR1O <= regs[4];
								3'b101: SR1O <= regs[5];
								3'b110: SR1O <= regs[6];
								3'b111: SR1O <= regs[7];
								
								default ;
								
						endcase
							
						case(SR2)
							
								3'b000: SR2O <= regs[0];
								3'b001: SR2O <= regs[1];
								3'b010: SR2O <= regs[2];
								3'b011: SR2O <= regs[3];
								3'b100: SR2O <= regs[4];
								3'b101: SR2O <= regs[5];
								3'b110: SR2O <= regs[6];
								3'b111: SR2O <= regs[7];
								
								default ;
								
						endcase
					
			end
		
endmodule	
							

module flip_flop (input  logic Clk, Reset, Load,
				  //Shift_In, Shift_En,
              input  logic  D,
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
							
	