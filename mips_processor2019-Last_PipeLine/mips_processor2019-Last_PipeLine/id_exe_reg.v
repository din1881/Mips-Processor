module IDEX_reg (CLK,REGDST_in,memread_in, memtoreg_in, ALUOP_in, memwrite_in, ALUSRC1_in,regwrite_in,read_data1_in, read_data2_in ,SIGN_extended_in ,Rs_in , Rt_in , Rd_in,
                  REGDST_out,memread_out, memtoreg_out, memwrite_out, ALUSRC1_out, regwrite_out,ALUOP_out,Rs_out , Rt_out , Rd_out ,read_data1_out, read_data2_out ,SIGN_extended_out); 

//Inputs For ID Stage
input wire CLK ; 
input wire REGDST_in,memread_in, memtoreg_in, memwrite_in, ALUSRC1_in,regwrite_in;
input wire [1:0] ALUOP_in;
input wire [4:0] Rs_in , Rt_in , Rd_in;
input wire [31:0]read_data1_in, read_data2_in ,SIGN_extended_in;


// Output of ID stage 
output reg REGDST_out,memread_out, memtoreg_out, memwrite_out, ALUSRC1_out,regwrite_out;
output reg [1:0] ALUOP_out;
output reg [4:0] Rs_out , Rt_out , Rd_out;
output reg [31:0]read_data1_out, read_data2_out ,SIGN_extended_out;


always @(posedge CLK)
begin 
REGDST_out        <= REGDST_in; 
memread_out       <= memread_in;
memtoreg_out      <= memtoreg_in; 
memwrite_out      <= memwrite_in; 
ALUSRC1_out       <= ALUSRC1_in;
regwrite_out      <= regwrite_in;
ALUOP_out         <= ALUOP_in; 
Rs_out            <= Rs_in ; 
Rt_out            <= Rt_in; 
Rd_out            <= Rd_in; 
read_data1_out    <= read_data1_in;
read_data2_out    <= read_data2_in;
SIGN_extended_out <= SIGN_extended_in ;

end
endmodule 
