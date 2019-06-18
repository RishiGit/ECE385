module testbench_8();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.
logic clk = 0;
logic reset, clear, execute;
logic extendbit;
logic [7:0] switches;
logic [7:0] Aval,
		 Bval;
logic [6:0] AhexL,
		 AhexU,
		 BhexL,
		 BhexU; 

// To store expected results
logic [7:0] ans_1a;
				
// A counter to count the instances where simulation results
// do no match with expected results
integer ErrorCnt = 0;
		
// Instantiating the DUT
// Make sure the module and signal names match with those in your design
Processor processor0(.*);	

// Toggle the clock
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 clk = ~clk;
end

initial begin: CLOCK_INITIALIZATION
    clk = 0;
end 

// Testing begins here
// The initial block is not synthesizable
// Everything happens sequentially inside an initial block
// as in a software program
initial begin: TEST_VECTORS

//Positive Times Positive (59 x 7)
		reset = 0;			//toggle reset button
#2		reset = 1;
#2 	switches = 8'h3B;	 //put 59 in first
#2 	clear = 0;
#2		clear = 1;
#2 	switches = 8'h7 ;  //leave 7 in the switches

#2 	execute = 0; //toggle execute
#2		execute = 1;
		
#60	ans_1a = (8'h3B * 8'h7); //check answer
		if(Bval != ans_1a)
			ErrorCnt++;
	
#2		reset = 0;
#2		reset = 1;

//Positive Times Negative (7 x -59)  
		reset = 0;			//toggle reset button
#2		reset = 1;
#2 switches = 8'hFFC5;
#2 clear = 0;
#2 clear = 1;
#2 switches = 8'h7;

#2	execute = 0;
#2 execute = 1;

#60	ans_1a = (8'hFFC5 * 8'h7);
		if(Bval != ans_1a)
			ErrorCnt++;
	
#2		reset = 0;
#2		reset = 1;

//Negative Times Positive (-59 x 7)  
		reset = 0;			//toggle reset button
#2		reset = 1;
#2 switches = 8'h7;
#2 clear = 0;
#2 clear = 1;
#2 switches = 8'hFFC5;

#2	execute = 0;
#2 execute = 1;

#60	ans_1a = (8'hFFC5 * 8'h7);
		if(Bval != ans_1a)
			ErrorCnt++;
	
#2		reset = 0;
#2		reset = 1;

//Negative Times Negative (-59 x -7) 
		reset = 0;			//toggle reset button
#2		reset = 1; 
#2 switches = 8'hFFF9;
#2 clear = 0;
#2 clear = 1;
#2 switches = 8'hFFC5;

#2	execute = 0;
#2 execute = 1;

#60	ans_1a = (8'hFFC5 * 8'hFFF9);
		if(Bval != ans_1a)
			ErrorCnt++;
	
#2		reset = 0;
#2		reset = 1;

//Multiple Multiplications
		reset = 0;			//toggle reset button
#2		reset = 1;   
#2 switches = 8'hFFFF;
#2 clear = 0;
#2 clear = 1;

 
#40	execute = 0;	//first multiply
#4		execute = 1; 
#40		execute = 0;	//second multiply
#4		execute = 1; 
#40		execute = 0;	//third multiply
#4		execute = 1; 
#40		execute = 0;	//fourth multiply
#4		execute = 1; 
#40		execute = 0;	//fifth multiply
		
#60	ans_1a = (8'h1 * 8'h1);
		if(Bval != ans_1a)
			ErrorCnt++;
	
#2		reset = 0;
#2		reset = 1;


if (ErrorCnt == 0)
	$display("Success!");  // Command line output in ModelSim
else
	$display("%d error(s) detected. Try again!", ErrorCnt);
end
endmodule
