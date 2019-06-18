//-------------------------------------------------------------------------
//      lab8.sv                                                          --
//      Christine Chen                                                   --
//      Fall 2014                                                        --
//                                                                       --
//      Modified by Po-Han Huang                                         --
//      10/06/2017                                                       --
//                                                                       --
//      Fall 2017 Distribution                                           --
//                                                                       --
//      For use with ECE 385 Lab 8                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module lab8( input               CLOCK_50, PS2_CLK,PS2_DAT, AUDIO_CLK,
             input        [3:0]  KEY,          //bit 0 is set up as Reset
             output logic [6:0]  HEX0, HEX1, HEX2, HEX4, HEX5,
             // VGA Interface 
             output logic [7:0]  VGA_R,        //VGA Red
                                 VGA_G,        //VGA Green
                                 VGA_B,        //VGA Blue
             output logic        VGA_CLK,      //VGA Clock
                                 VGA_SYNC_N,   //VGA Sync signal
                                 VGA_BLANK_N,  //VGA Blank signal
                                 VGA_VS,       //VGA virtical sync signal
                                 VGA_HS,       //VGA horizontal sync signal
             // CY7C67200 Interface
             inout  wire  [15:0] OTG_DATA,     //CY7C67200 Data bus 16 Bits
             output logic [1:0]  OTG_ADDR,     //CY7C67200 Address 2 Bits
             output logic        OTG_CS_N,     //CY7C67200 Chip Select
                                 OTG_RD_N,     //CY7C67200 Write
                                 OTG_WR_N,     //CY7C67200 Read
                                 OTG_RST_N,    //CY7C67200 Reset
             input               OTG_INT,      //CY7C67200 Interrupt
             // SDRAM Interface for Nios II Software
             output logic [12:0] DRAM_ADDR,    //SDRAM Address 13 Bits
             inout  wire  [31:0] DRAM_DQ,      //SDRAM Data 32 Bits
             output logic [1:0]  DRAM_BA,      //SDRAM Bank Address 2 Bits
             output logic [3:0]  DRAM_DQM,     //SDRAM Data Mast 4 Bits
             output logic        DRAM_RAS_N,   //SDRAM Row Address Strobe
                                 DRAM_CAS_N,   //SDRAM Column Address Strobe
                                 DRAM_CKE,     //SDRAM Clock Enable
                                 DRAM_WE_N,    //SDRAM Write Enable
                                 DRAM_CS_N,    //SDRAM Chip Select
                                 DRAM_CLK,      //SDRAM Clock
				output logic [7:0] 	LEDG,
				output logic [15:0] LEDR,
				input logic [1:0] SW,
				input				   AUD_ADCDAT,
				 inout				   AUD_ADCLRCK,
				 inout		   		AUD_BCLK,
				 output					AUD_DACDAT,
				 inout				   AUD_DACLRCK,
				 output					AUD_XCK,
				 //I2C for audio
				 output  				I2C_SCLK,
				 inout	  				I2C_SDAT);
    
    logic Reset_h, Clk, is_bird,killed,Game_R;
    logic [7:0] keycode;
    logic [9:0] BallX,BallY,BallS,DrawX,DrawY;
    assign Clk = CLOCK_50;
    always_ff @ (posedge Clk) begin
        Reset_h <= ~(KEY[0]); // The push buttons are active low
		  Game_R <= ~(KEY[1]);
    end
    
    logic [1:0] hpi_addr;
    logic [15:0] hpi_data_in, hpi_data_out;
    logic hpi_r, hpi_w, hpi_cs, hpi_reset;
	 
	 wire I2C_END;
	 wire AUD_CTRL_CLK;
    
    // Interface between NIOS II and EZ-OTG chip
    hpi_io_intf hpi_io_inst(
                            .Clk(Clk),
                            .Reset(Reset_h),
                            // signals connected to NIOS II
                            .from_sw_address(hpi_addr),
                            .from_sw_data_in(hpi_data_in),
                            .from_sw_data_out(hpi_data_out),
                            .from_sw_r(hpi_r),
                            .from_sw_w(hpi_w),
                            .from_sw_cs(hpi_cs),
                            .from_sw_reset(hpi_reset),
                            // signals connected to EZ-OTG chip
                            .OTG_DATA(OTG_DATA),    
                            .OTG_ADDR(OTG_ADDR),    
                            .OTG_RD_N(OTG_RD_N),    
                            .OTG_WR_N(OTG_WR_N),    
                            .OTG_CS_N(OTG_CS_N),
                            .OTG_RST_N(OTG_RST_N)
    );
     
     // You need to make sure that the port names here match the ports in Qsys-generated codes.
     lab8_soc nios_system(
                             .clk_clk(Clk),         
                             .reset_reset_n(1'b1),    // Never reset NIOS
                             .sdram_wire_addr(DRAM_ADDR), 
                             .sdram_wire_ba(DRAM_BA),   
                             .sdram_wire_cas_n(DRAM_CAS_N),
                             .sdram_wire_cke(DRAM_CKE),  
                             .sdram_wire_cs_n(DRAM_CS_N), 
                             .sdram_wire_dq(DRAM_DQ),   
                             .sdram_wire_dqm(DRAM_DQM),  
                             .sdram_wire_ras_n(DRAM_RAS_N),
                             .sdram_wire_we_n(DRAM_WE_N), 
                             .sdram_clk_clk(DRAM_CLK),
                             .keycode_export(keycode),  
                             .otg_hpi_address_export(hpi_addr),
                             .otg_hpi_data_in_port(hpi_data_in),
                             .otg_hpi_data_out_port(hpi_data_out),
                             .otg_hpi_cs_export(hpi_cs),
                             .otg_hpi_r_export(hpi_r),
                             .otg_hpi_w_export(hpi_w),
                             .otg_hpi_reset_export(hpi_reset)
    );
    
    // Use PLL to generate the 25MHZ VGA_CLK.
    // You will have to generate it on your own in simulation.
    vga_clk vga_clk_instance(.inclk0(Clk), .c0(VGA_CLK));
	 logic [7:0] keyCodePS2;
	 logic press;
    keyboard PS2(.Clk(Clk), .psClk(PS2_CLK), .psData(PS2_DAT), .reset(Reset_h),
					 .keyCode(keyCodePS2),
					 .press(press));
    // TODO: Fill in the connections for the rest of the modules 
    VGA_controller vga_controller_instance(.*,.Reset(Reset_h));
	 wire [7:0]sound_code1;
	 logic Game_S;
    always_comb
	 begin
		if(keyCodePS2 == 8'h1b && press==1'b1)
					begin	
						Game_S=1;
					end
		else
			begin
				Game_S=0;
			end
	 end
	 always_comb
	 begin
		if(keyCodePS2 == 8'h29 && press==1'b1)
					begin
						sound_code1 = 8'h04 ;
					end
		else
			begin
				sound_code1 = 0;
			end
	 end
    // Which signal should be frame_clk? Vertical Sync.
	 logic [9:0] birdyposf,pxpos,pypos;
	 logic [10:0] birdy10pos;
	 logic is_pipe,is_killed,isk_o,finalkilled;
	 logic [1:0] currentstate;
	 logic [7:0] currscore;
	 controller controller_i(.Clk(Clk),.Reset(Game_R),.killed(isk_o),.currentstate(currentstate),.start(Game_S),.finalkilled(finalkilled));
    bird bird_i(.*,.Reset(Game_R),.frame_clk(VGA_VS), .birdouty(birdyposf),.keycode(keyCodePS2),.press(press),.killed(finalkilled),.birdy10pos(birdy10pos));
	 pipe pipe_i(.*,.Reset(Game_R),.frame_clk(VGA_VS),.currentstate(currentstate),.score(currscore),.speed(SW));
	 is_killed is_killed_i(.birdy(birdyposf),.pipex(pxpos),.pipey(pypos),.killed(is_killed),.Clk(VGA_VS));
	 counter score_i(.Clk(VGA_VS),.Reset(Game_R),.in(currscore),.out(currscore),.pipex(pxpos),.killed(finalkilled));
	 flip_flop flop_flop_i(.*,.Reset(Game_R),.Load(1),.D(is_killed),.Data_Out(isk_o));
    //collor mapper instance to draw background and ball.
    color_mapper color_instance(.*, .birdy(birdyposf),.pipex(pxpos),.is_pipe(is_pipe),.Reset(Game_R),.killed(isk_o),.currentstate(currentstate));
	 
	 I2C_AV_Config I2C_AV_Config_instance(	//	Host Side
								 .iCLK		( Clk),
								 .iRST_N		( Reset_h ),
								 .o_I2C_END	( I2C_END ),
								   //	I2C Side
								 .I2C_SCLK	( I2C_SCLK ),
								 .I2C_SDAT	( I2C_SDAT )	
								);

		//Audio Sound
		assign AUD_ADCLRCK=AUD_DACLRCK;
		assign AUD_XCK= AUD_CTRL_CLK;

		//  AUDIO PLL

		VGA_Audio_PLL 	u1	(	
								 .areset ( ~I2C_END ),
								 .inclk0 ( AUDIO_CLK ),
								 .c1		( AUD_CTRL_CLK )	
								);
								
		////////////Sound Select/////////////	

			wire [15:0]	sound1;
			wire [15:0]	sound2;
			wire [15:0]	sound3;
			wire [15:0]	sound4;
			wire 			sound_off1;
			wire 			sound_off2;
			wire 			sound_off3;
			wire 			sound_off4;

			wire [7:0]sound_code2 = 0 ;

			wire [7:0]sound_code3 = 0;

			wire [7:0]sound_code4 = 0;
								
			staff st1(
				
					 // Key code-in //
				
					 .scan_code1		( sound_code1 ),
					 .scan_code2		( sound_code2 ),
					 .scan_code3      ( sound_code3 ), 
					 .scan_code4		( sound_code4 ), 
				
					 //Sound Output to Audio Generater//
				
					 .sound1				( sound1 ),
					 .sound2				( sound2 ),
					 .sound3				( sound3 ),
					 .sound4				( sound4 ),
				
					 .sound_off1		( sound_off1 ),
					 .sound_off2		( sound_off2 ),
					 .sound_off3		( sound_off3 ), //OFF
					 .sound_off4		( sound_off4 )	 //OFF	
					  );
								
								
								// 2CH Audio Sound output -- Audio Generater //

			adio_codec ad1	(	
					  
							// AUDIO CODEC //
				
							.oAUD_BCK 	( AUD_BCLK ),
							.oAUD_DATA	( AUD_DACDAT ),
							.oAUD_LRCK	( AUD_DACLRCK ),																
							.iCLK_18_4	( AUD_CTRL_CLK ),
					
							// KEY //
				
							.iRST_N	  	( ~Reset_h ),							
							.iSrc_Select( 2'b00 ),

							// Sound Control //

							.key1_on		( sound_off1 ),//CH1 ON / OFF		
							.key2_on		( sound_off2 ),//CH2 ON / OFF
							.key3_on		( sound_off3 ),			    	// OFF
							.key4_on		( sound_off4 ), 					// OFF							
							.sound1		( sound1 ),					// CH1 Freq
							.sound2		( sound2 ),					// CH2 Freq
							.sound3		( sound3 ),					// OFF,CH3 Freq
							.sound4		( sound4 ),					// OFF,CH4 Freq							
							.instru		( SW[0] )  					// Instruction Select
							);
	 
	 /*always_ff @ (posedge Clk)
	 begin
		LEDG[0]<=isk_o;
	 end*/
	 assign LEDG[0] = isk_o;
	 assign LEDG[1] = finalkilled;
	 //assign LEDG[1] = currentstate[0];
	 //assign LEDG[2] = currentstate[1];
	 //assign LEDG[3] = currentstate[3];
    // Display keycode on hex display
	 assign LEDR[0] = birdy10pos[0];
	 assign LEDR[1] = birdy10pos[1];
	 assign LEDR[2] = birdy10pos[2];
	 assign LEDR[3] = birdy10pos[3];
	 assign LEDR[4] = birdy10pos[4];
	 assign LEDR[5] = birdy10pos[5];
	 assign LEDR[6] = birdy10pos[6];
	 assign LEDR[7] = birdy10pos[7];
	 assign LEDR[8] = birdy10pos[8];
	 assign LEDR[9] = birdy10pos[9];
	 assign LEDR[10] = birdy10pos[10];
	 HexDriver hex_inst_0 (keyCodePS2[3:0], HEX0);
    HexDriver hex_inst_1 (keyCodePS2[7:4], HEX1);
	 HexDriver hex_inst_2 (currentstate[1:0], HEX2);
	 HexDriver hex_inst_3 (currscore[7:4], HEX5);
	 HexDriver hex_inst_4 (currscore[3:0], HEX4);
    /**************************************************************************************
        ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
        Hidden Question #1/2:
        What are the advantages and/or disadvantages of using a USB interface over PS/2 interface to
             connect to the keyboard? List any two.  Give an answer in your Post-Lab.
    **************************************************************************************/
endmodule
