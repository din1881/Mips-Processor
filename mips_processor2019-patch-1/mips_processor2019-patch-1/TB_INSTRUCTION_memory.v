/* /********************************TB_INSTRUCTION_memory Module*******************************/
module TB_INSTRUCTION_memory();

reg [31:0] PC;
wire [31:0] instruction;

/* Creating instance of instruction memory (A1)*/ 
INSTRUCTION_memory A1(PC,instruction);

initial 
begin

/* Showing on the screen the output of PC Address */
$monitor(" OUTPUT_instruction of address[%d] = %d",PC,instruction);


/* Accessing some random addresses */
#5
PC = 0;
#5
PC = 4 ;
#5
PC = 8;

end
endmodule