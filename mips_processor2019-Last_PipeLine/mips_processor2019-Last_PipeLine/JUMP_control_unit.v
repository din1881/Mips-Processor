module JUMP_control_unit(opcode,jump_ctr);
input [5:0] opcode;
output reg jump_ctr;

initial
begin
jump_ctr <= 0;
end

always @ (*)
begin
if(opcode == 2)
	jump_ctr <= 1;
else
	jump_ctr <= 0;
end 
endmodule
