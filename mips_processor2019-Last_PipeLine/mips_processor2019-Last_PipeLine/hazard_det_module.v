/*This module handles when there is a an instruction after the load ins that will use destination register of lw;
in which this module sends a stall signal to three places :
	1. A mux that choses either to bypass control unit signals or to make them all equal zero
	2. IF/ID register that will hold the data inside it for one clock cycle
	3. To PC, to hold its current value to not move to the next instruction */

module HazardDetectionUnit(memread_exe,rt_exe,rs,rt,clk,hold_sig);

input memread_exe,clk;
input [4:0] rs,rt,rt_exe;
output reg hold_sig;
initial
begin
hold_sig <= 1;
end
always @ (posedge clk)
	begin
	
	if ((memread_exe &(rt_exe==rs)) | (memread_exe & (rt_exe==rt)) )
		hold_sig <= 1'b0;
	
	else
		hold_sig <= 1'b1;
	

	end


endmodule