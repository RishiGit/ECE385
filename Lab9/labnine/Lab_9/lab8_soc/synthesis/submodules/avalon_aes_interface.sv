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
	output logic [31:0] EXPORT_DATA);		// Exported Conduit Signal to LEDs
	
	logic [31:0] regs [15:0];
	logic [31:0] newdata;
	logic DONE;
	logic [127:0] msgdec;
	AES newaes(.CLK(CLK), .RESET(RESET), .AES_START(regs[14][0]), .AES_DONE(DONE),
					.AES_KEY({regs[0],regs[1],regs[2],regs[3]}), 
					.AES_MSG_ENC({regs[4],regs[5],regs[6], regs[7]}),
					.AES_MSG_DEC(msgdec));
					 
	
	always_ff @ (posedge CLK)
		
		begin
			if(DONE == 1'b1)
			
			begin
				regs[15] <= 32'b11111111111111111111111111111111;
				regs[8] <= msgdec[127:96];
				regs[9] <= msgdec[95:64];
				regs[10] <= msgdec[63:32];
				regs[11] <= msgdec[31:0];
				
			end
			
				if(AVL_BYTE_EN[0] == 1)
					newdata[7:0] <= AVL_WRITEDATA[7:0];
				
				if(AVL_BYTE_EN[1] == 1)
					newdata[15:8] <= AVL_WRITEDATA[15:8];
					
				if(AVL_BYTE_EN[2] == 1)
					newdata[23:16] <= AVL_WRITEDATA[23:16];
					
				if(AVL_BYTE_EN[3] == 1)
					newdata[31:24] <= AVL_WRITEDATA[31:24];
					
			if(RESET == 1'b1)
			
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
		
		else if(AVL_CS == 1 && AVL_WRITE == 1)
		
			begin
			
				regs[AVL_ADDR] <= newdata;
			
			end
			
	end
	
	always_comb
		
		begin
	
			if(AVL_CS == 1 && AVL_READ == 1)
				
				AVL_READDATA = regs[AVL_ADDR];
				
			else
				
				AVL_READDATA = 32'b0;
		
			EXPORT_DATA = {regs[8][31:16], regs[11][15:0]};
			
		end
			
endmodule
