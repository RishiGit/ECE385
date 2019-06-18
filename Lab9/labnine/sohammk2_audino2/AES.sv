/************************************************************************
AES Decryption Core Logic

Dong Kai Wang, Fall 2017

For use with ECE 385 Experiment 9
University of Illinois ECE Department
************************************************************************/

module AES (
	input	 logic CLK,
	input  logic RESET,
	input  logic AES_START,
	output logic AES_DONE,
	input  logic [127:0] AES_KEY,
	input  logic [127:0] AES_MSG_ENC,
	output logic [127:0] AES_MSG_DEC
);

	//all logic
		logic i_c1, r_c1, i_c2, r_c2, i_k, r_k, i_round, r_round;
		logic [127:0] state;
		logic LD_S; 
		logic [1407:0] keyS;
		logic [4:0] key_counter;
		logic [127:0] ISRO;
		logic [127:0] ISBO;		
		logic [127:0] ARKO;
		logic [3:0] round;
		logic [3:0] c2;
		logic [31:0] MC_32, IMC32O;
		logic [127:0] IMCO;
		logic [127:0] INSTR_MUXO; 
		logic [3:0] c1;
		logic firstARK;
	//Instantiate Control module
		
	//temp registers to hold intermediate vals;
		reg_128 state_reg(.Clk(CLK),.Reset(RESET),.Load(LD_S),.first(firstARK),.d2(AES_MSG_ENC),.D(INSTR_MUXO),.Data_Out(state));
		
	//Key expansion with counter to make sure the whole key is done.
		keycounter c_k(.Clk(CLK),.inc(i_k),.Reset(r_k),.out(key_counter));
		//will this step put entire expanded key in keyS?
		KeyExpansion expansion(.clk(CLK), .Cipherkey(AES_KEY), .KeySchedule(keyS));
		
	//First add round key.
		//state = state ^ keyS[1407:1280];
		
	//Inverse Shift Rows
		InvShiftRows ISR(.data_in(state), .data_out(ISRO));
	
	//SubMsg
		InvSubMsg ISB(.clk(CLK),.in(state),.out(ISBO));
	
	//Round Key
		rcounter round_c(.Clk(CLK),.inc(i_round),.Reset(r_round),.out(round));
		AddRoundKey ARK(.msg(state),.keyS(keyS),.round(round),.out(ARKO));

	//MixCols
		counter c_2(.Clk(CLK),.inc(i_c2),.Reset(r_c2),.out(c2));
		four_one32 MC_MUX(.A(state[127:96]),.B(state[95:64]),.C(state[63:32]),.D(state[31:0]),.S(c2),.Out(MC_32));
		InvMixColumns IMC(.in(MC_32), .out(IMC32O));
		one_four32 decoder(.clk(CLK),.A(IMCO),.S(c2),.in(IMC32O));
		//reg_128 imc_reg(.Clk(CLK),.Reset(RESET),.Load(1),.first(0),.D(INSTR_MUXO),.Data_Out(state));



	//muxes and modules correct instruction:
		//instruction mux
		counter c_1(.Clk(CLK),.inc(i_c1),.Reset(r_c1),.out(c1));
		four_one INSTR_MUX(.A(ISRO),.B(ISBO),.C(ARKO),.D(IMCO),.S(c1),.Out(INSTR_MUXO));
		
		AES_CONTROL controller(.CLK(CLK), .Reset(RESET), .start(AES_START),
							.c1(c1),.c2(c2), .key_c(key_counter),
							//input logic [3:0] c3,
							.i_c1(i_c1), .r_c1(r_c1),
							.i_c2(i_c2), .r_c2(r_c2),
							.i_k(i_k), .r_k(r_k),
							.i_round(i_round),.r_round(r_round),
							.LD_S(LD_S), .done_s(AES_DONE),
							.round(round),.firstARK(firstARK));
		assign AES_MSG_DEC=state;
		
endmodule
