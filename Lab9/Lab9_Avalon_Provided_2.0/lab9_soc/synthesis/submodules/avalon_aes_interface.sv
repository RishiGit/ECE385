/************************************************************************
Avalon-MM Interface for AES Decryption IP Core

Dong Kai Wang, Fall 2017

For use with ECE 385 Experiment 9
University of Illinois ECE Department

Register Map:

 0-3 : 4x 32bit AES Key
 4-7 : 4x 32bit AES Encrypted Message
 8-11: 4x 32bit AES Decrypted Message
   12: Not Used
	13: Not Used
   14: 32bit Start Register
   15: 32bit Done Register

************************************************************************/

module avalon_aes_interface (
	// Avalon Clock Input
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read
	input  logic AVL_WRITE,					// Avalon-MM Write
	input  logic AVL_CS,						// Avalon-MM Chip Select
	input  logic [3:0] AVL_BYTE_EN,		// Avalon-MM Byte Enable
	input  logic [3:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,	// Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,	// Avalon-MM Read Data
	
	// Exported Conduit
	output logic [31:0] EXPORT_DATA		// Exported Conduit Signal to LEDs
	
	logic [31:0] regs [15:0];
	logic [31:0] newdata;
	assign EXPORT_DATA = {regs[0][31:16], regs[3][15:0]};
	
	always_ff @ (posedge CLK)
		
		begin
			
				if(AVL_BYTE_EN[0] == 1)
					newdata[7:0] <= AVL_WRITEDATA[7:0];
				
				if(AVL_BYTE_EN[1] == 1)
					newdata[15:8] <= AVL_WRITEDATA[15:8];
					
				if(AVL_BYTE_EN[2] == 1)
					newdata[23:16] <= AVL_WRITEDATA[23:16];
					
				if(AVL_BYTe_EN[3] == 1)
					newdata[31:24] <= AVL_WRITEDATA[31:24];
					
			if(RESET)
			
				begin
				
					regs[0] = 32'h0;
					regs[1] = 32'h0;
					regs[2] = 32'h0;
					regs[3] = 32'h0;
					regs[4] = 32'h0;
					regs[5] = 32'h0;
					regs[6] = 32'h0;
					regs[7] = 32'h0;
					regs[8] = 32'h0;
					regs[9] = 32'h0;
					regs[10] = 32'h0;
					regs[11] = 32'h0;
					regs[12] = 32'h0;
					regs[13] = 32'h0;
					regs[14] = 32'h0;
					regs[15] = 32'h0;
	
			end
		
		else if(AVL_CS & AVL_WRITE)
		
			regs[AVL_ADDR] <= newdata;
		
		end
	
);


endmodule

module REGS(input logic CLK, RESET
				input logic [3:0] AVL_BYTE_EN
				input logic [31:0] DATA_IN
				output logic [31:0] DATA_OUT
	
	logic [15:0] [31:0] REG
	logic [32:0] newdata
	
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
								
								4b'0001: newdata[7:0] <= DATA_IN[7:0];
								4b'0010: newdata[15:8] <= DATA_IN[15:8];
								4b'0011: newdata[15:0] <= DATA_IN[15:0];
								4b'0100: newdata[23:16] <= DATA_IN[23:16];
								4b'1000: newdata[31:24] <= DATA_IN[31:24];
								4b'1100: newdata[31:16] <= DATA_IN[31:16];
								4b'1111: newdata[31:0] <= DATA_IN[31:0};
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
			
							
						
								
	



);
