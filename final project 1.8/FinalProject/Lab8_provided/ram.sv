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
		input [10:0] read_address,
		input Clk,
		output logic [1:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [1:0] mem [0:307199];

initial
begin
	 $readmemb("spritebytes/background.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule