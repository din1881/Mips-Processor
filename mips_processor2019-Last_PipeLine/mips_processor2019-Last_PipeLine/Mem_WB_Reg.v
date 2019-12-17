module MEM_Wb_Reg(RegWrite_out,MemtoReg_out,Alu_result_out, MUX_destination_out ,Read_data_out, CLK, RegW_in, MemtoReg_in , Alu_result ,Read_data,MUX_destination);

// Inputs to Mem_Wb Register
input wire RegW_in,MemtoReg_in,CLK;
input wire[31:0] Alu_result, Read_data;
input wire [4:0] MUX_destination;

// Outputs to Mem_Wb Register
output reg RegWrite_out,MemtoReg_out;
output reg[31:0] Alu_result_out, Read_data_out;
output reg [4:0] MUX_destination_out;

always @(posedge CLK)

begin
RegWrite_out <= RegW_in;
MemtoReg_out <= MemtoReg_in;
Alu_result_out <= Alu_result;
Read_data_out <= Read_data;
MUX_destination_out <= MUX_destination;
end

endmodule


