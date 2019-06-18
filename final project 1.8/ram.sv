/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  ram
(
		input [10:0] read_address,
		input Clk,
		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:1599];

initial
begin
	 $readmemh("spritebytes/flappy.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule


module  background
(
		input [18:0] read_address,
		input Clk,
		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] membg [0:307199];

initial
begin
	 $readmemh("spritebytes/background.txt", membg);
end


always_ff @ (posedge Clk) begin
	data_Out<= membg[read_address];
end

endmodule

module  piperam
(
		input [15:0] read_address,
		input Clk,
		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mempipe [0:38399];

initial
begin
	 $readmemh("spritebytes/pipe-1.txt", mempipe);
end


always_ff @ (posedge Clk) begin
	data_Out<= mempipe[read_address];
end

endmodule

module  startram
(
		input [11:0] read_address,
		input Clk,
		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mempipe [0:4059];

initial
begin
	 $readmemh("spritebytes/pipe-1.txt", mempipe);
end


always_ff @ (posedge Clk) begin
	data_Out<= mempipe[read_address];
end

endmodule
