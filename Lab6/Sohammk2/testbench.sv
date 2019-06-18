//taken from.

module testbench();

    timeunit 10ns;  // how long one unit of time is

    timeprecision 1ns;

    // inputs
    logic [15:0] S;
    logic Clk, Reset, Run, Continue;  

    // outputs
	logic [11:0] LED;
    logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
    logic CE, UB, LB, OE, WE;
    logic [19:0] ADDR;
    wire [15:0] Data;
	 logic [15:0] R0,R1,R2,R3,R4,R5,R6,R7;
	 lab6_toplevel lc3(.*);
	 assign R0 = lc3.my_slc.d0.REGFILE.regs[0];
	 assign R1 = lc3.my_slc.d0.REGFILE.regs[1];
	 assign R2 = lc3.my_slc.d0.REGFILE.regs[2];
	 assign R3 = lc3.my_slc.d0.REGFILE.regs[3];
	 assign R4 = lc3.my_slc.d0.REGFILE.regs[4];
	 assign R5 = lc3.my_slc.d0.REGFILE.regs[5];
	 assign R6 = lc3.my_slc.d0.REGFILE.regs[6];
	 assign R7 = lc3.my_slc.d0.REGFILE.regs[7];


    // Toggle the clock
    // #1 means wait for a delay of 1 timeunit
    always begin : CLOCK_GENERATION
        #1 Clk = ~Clk;
    end

    initial begin: CLOCK_INITIALIZATION
        Clk = 0;
    end 

    // Testing begins here. 
    // Everything happens sequentially in an initial block. 
    // Therefore this block is not synthesizable!
    initial begin: TEST_VECTORS
        Reset = 1;		// Toggle Rest
		  Run = 1;
		  lc3.my_slc.state_controller.State=lc3.my_slc.state_controller.PauseIR1;
		  lc3.my_slc.d0.PCREG.Data_Out = 16'h0000;
		  lc3.my_slc.d0.IRREG.Data_Out=16'b0001001001100100;
		  lc3.my_slc.d0.REGFILE.regs[1]=16'h0001;

    end

endmodule
