module counter(input logic [7:0] in, 
					input logic Clk,
					input logic Reset, 
					output logic [7:0] out,
					input logic [9:0] pipex,
					input logic killed);
					
		
		logic [7:0] temp;
		
		always_ff @ (posedge Clk)
		begin
			if(killed)
				out<= 8'b00000000;
			else if(killed==1'b0 && pipex<=10'd0)
				out<=temp;
			if(Reset)
				out<= 8'b00000000;
		end
		
		always_comb
		begin
			temp = out+8'b00000001;
		end		
endmodule
