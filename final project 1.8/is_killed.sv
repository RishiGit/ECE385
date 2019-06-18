module is_killed( input logic Clk, Reset,
						input logic [9:0] birdy, pipex, pipey,
						output logic killed);
	
	
	//logic killed_in;
	
	
	always_ff @ (posedge Clk)
	begin
		if(Reset)
		begin
			killed <= 1'b0;
		end
		else if(pipex>=10'd265 && pipex<=10'd375)
		begin
			if(((birdy+10'd12)>=(pipey+10'd40))||((birdy-10'd12)<=(pipey-10'd40)))
			begin
				killed <= 1'b1;
			end
			else
			begin
				killed<=1'b0;	
			end
		end
		else if (birdy>=10'd470 && birdy<=10'd480)
		begin
			killed <=1'b1;
		end
		else
		begin
			killed <= 1'b0;
		end
	end
	
	/*always_comb
		begin
			killed_in=killed;
			if(pipex>=10'd280 || pipex<=10'd360)
			begin
				if((birdy>=(pipey+10'd40))||(birdy<=(pipey-10'd40)))
				begin
					killed_in = 1'b1;
				end
			end
			else if (birdy>=10'd480)
			begin
				killed_in=1'b1;
			end
			else
			begin
				killed_in = 1'b0;
			end
		end*/
endmodule
