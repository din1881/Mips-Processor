module MUX3to1_32(select,A,C,B,out);
/* A: represent Rs given from IDEX_reg
 * B: represent Rd given from MEMWB_reg
 * C: represent Rd given from EXMEM_reg
*/
output [31:0] out;
input [1:0] select;
input [31:0] A,B,C;
wire [31:0] out1,out2;
MUX2to1_32 MUX_CA(select[1:1],C,A,out1);
MUX2to1_32 MUX_AB(select[1:1],A,B,out2);
MUX2to1_32 MUX_ABC(select[0:0],out2,out1,out);

endmodule 