module EXMEM_REG(CLK , RegWrite_EXMEM_in , MemtoReg_EXMEM_in , MemRead_EMEM_in ,MemWrite_EXMEM_in , ALU_Result_in , WriteData_in , Rd_EXMEM_in ,
                  RegWrite_EXMEM_out , MemtoReg_EXMEM_out , MemRead_EXMEM_out ,MemWrite_EXMEM_out , address_EXMEM_out  , WriteData_out , Rd_EXMEM_out );

/* Inputs to EXMEM Reg */ 
input wire CLK ; 
input wire RegWrite_EXMEM_in , MemtoReg_EXMEM_in , MemRead_EMEM_in ,MemWrite_EXMEM_in ; 
input wire [31:0] ALU_Result_in , WriteData_in ; 
input wire [4:0] Rd_EXMEM_in ; 

/* Outout of EXMEM Reg */ 
output reg RegWrite_EXMEM_out , MemtoReg_EXMEM_out , MemRead_EXMEM_out ,MemWrite_EXMEM_out  ; 
output reg [31:0] address_EXMEM_out  , WriteData_out ; 
output reg [4:0]  Rd_EXMEM_out ;


always @ (posedge CLK)
begin 
RegWrite_EXMEM_out <= RegWrite_EXMEM_in ; 
MemtoReg_EXMEM_out <= MemtoReg_EXMEM_in ; 
MemRead_EXMEM_out  <= MemRead_EMEM_in   ; 
MemWrite_EXMEM_out <= MemWrite_EXMEM_in ; 
address_EXMEM_out  <= ALU_Result_in     ; 
WriteData_out      <= WriteData_in      ;
Rd_EXMEM_out       <= Rd_EXMEM_in       ; 

end 
endmodule 
