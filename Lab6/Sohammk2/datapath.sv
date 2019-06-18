module datapath(input logic Clk, Reset_ah,
					 LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED,
					 GatePC, GateMDR, GateALU, GateMARMUX,
					 input logic [1:0] PCMUX, ADDR2MUX, ALUK,
					 input logic DRMUX, SR1MUX, SR2MUX, ADDR1MUX,
					 input logic MIO_EN,
					 input logic [15:0] MDR_In,
					 output logic BEN,
					 output logic [11:0] LED,
					 output logic [15:0] MAR, MDR, IR, PC);
					 
logic [15:0] SEXT5, SEXT7, SEXT10, SEXT11, //?why sext 7 and 10 instead of 6 and 9?
						 PCMUXO,
						 ADDR2O, ADDR1O, ADDRO, //?not sure about all of these
						 SR2O, SR2MO, SR1O,
						 ALUO,
						 BUS,
						 MDRO;
logic [2:0] DRIN, SR2, SR1IN;
logic NI, ZI, PI, NO, ZO, PO;
logic BENwire;
assign BENwire = IR[11]&NO|IR[10]&ZO|IR[9]&PO;

assign SR2 = IR[2:0];

//MUXES for PC and MDR to choose from different datapoints. 
mux_PC PCMUXX(.A(PC+16'h0001),.B(BUS),.C(ADDRO),.S(PCMUX),.Out(PCMUXO));
mux_MDR MDRMUXX(.A(BUS),.B(MDR_In),.S(MIO_EN),.Out(MDRO));


//REGISTERS to hold their specific values.
reg_16 MARREG(.Clk(Clk),.Reset(Reset_ah),.Load(LD_MAR),.D(BUS),.Data_Out(MAR));
reg_16 MDRREG(.Clk(Clk),.Reset(Reset_ah),.Load(LD_MDR),.D(MDRO),.Data_Out(MDR));
reg_16 IRREG(.Clk(Clk),.Reset(Reset_ah),.Load(LD_IR),.D(BUS),.Data_Out(IR));
reg_16 PCREG(.Clk(Clk),.Reset(Reset_ah),.Load(LD_PC),.D(PCMUXO),.Data_Out(PC));



logic [15:0] S5,S7,S10,S11;
assign S5 ={{5{IR[10]}}, IR[10:0]};
assign S7 = {{7{IR[8]}}, IR[8:0]};
assign S10 ={{10{IR[5]}}, IR[5:0]};
assign S11 ={{11{IR[4]}}, IR[4:0]};
mux_ADDR1 ADDR1MUXX(.A(PC),.B(SR1O),.S(ADDR1MUX),.Out(ADDR1O));
mux_ADDR2 ADDR2MUXX(.A(16'h0000),.B(S10),.C(S7),.D(S5),.S(ADDR2MUX),.Out(ADDR2O));
assign ADDRO = ADDR1O + ADDR2O;

//mux_ADDR ADDRMUX();
mux_DR DRMUXX(.A(IR[11:9]),.S(DRMUX),.Out(DRIN));
mux_SR1 SR1MUXX(.A(IR[11:9]),.B(IR[8:6]),.S(SR1MUX),.Out(SR1IN));
mux_SR2 SR2MUXX(.A(SR2O),.B(S11),.S(SR2MUX),.Out(SR2MO));
eightreg_16 REGFILE(.Clk(Clk),.SR1IN(SR1IN),.SR2(SR2),.DRIN(DRIN),.SR2O(SR2O),.Load(LD_REG),.D(BUS),.Reset(Reset_ah),.SR1O(SR1O));
ALU ALUU(.A(SR1O),.B(SR2MO),.ALUK(ALUK),.dout(ALUO));
NZP NZPLOGIC(.Clk(Clk), .NI(NI), .ZI(ZI), .PI(PI), .LD_CC(LD_CC),
					.NO(NO), .ZO(ZO), .PO(PO));
flip_flop BENN(.Clk(Clk),.Reset(Reset_ah),.Load(LD_BEN),.Data_Out(BEN),.D(BENwire));
mux_GATES GATEMUX(.A(PC),.B(MDR),.C(ADDRO),.D(ALUO),.S({GatePC,GateMDR,GateMARMUX,GateALU}),.Out(BUS));
always_ff @ (posedge Clk)
	begin
		if(LD_LED)
			LED<=IR[11:0];
		else
			LED<=12'h000;
	end

always_comb //might be an issue with this logic
	begin
		NI = BUS[15];
		if(BUS == 16'h0000)
			begin
				ZI = 1'b1;
			end
		else
			begin
				ZI = 1'b0;
			end
		PI = ~(ZI|NI);
	end
	
endmodule
