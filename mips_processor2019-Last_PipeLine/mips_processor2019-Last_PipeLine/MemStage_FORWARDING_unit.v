/* Forwarding_unit module at Execution_memory stage that selects between output of Mem/WB register (read_data) & 
   output of Exec/Mem register (MUX1_exec_stage), Checking if rt field of Mem/WB register == rt field of Exec/Mem register & 
   if MemWrite Control unit signal == 1   
*/

module Mem_stage_forwarding_unit(DM_ExeReg_Sel, MemWrite, Reg_rt1, Reg_rt2, read_data, MUX1_exec_stage);

input wire  MemWrite;
input wire [4:0] Reg_rt1, Reg_rt2;
input wire [31:0] read_data, MUX1_exec_stage;

output reg [31:0] DM_ExeReg_Sel;

always @ (*)
begin
if(Reg_rt1 == Reg_rt2 && MemWrite == 1'b1)
DM_ExeReg_Sel <= read_data;
else if (Reg_rt1 != Reg_rt2 || MemWrite != 1'b1)
DM_ExeReg_Sel <= MUX1_exec_stage;
else
DM_ExeReg_Sel <= 32'hxxxxxxxx;
end

endmodule 