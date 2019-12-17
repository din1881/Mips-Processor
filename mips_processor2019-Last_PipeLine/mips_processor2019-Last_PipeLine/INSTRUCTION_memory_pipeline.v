/********************************INSTRUCTION_memory Module**************************************/

/* Inst_memory module is a 32K Byte memory, takes the program counter (PC) as an input to determine which 
   instruction is going to be fetched and then outputs the instruction machine code on a 32-bit register

   Inst_memory is synchronized by a 1-bit CLOCK signal
*/

module INSTRUCTION_memory_pipeline (Current_pc,Next_pc,Current_instruction,Next_instruction);
input [12:0] Current_pc,Next_pc ; 
//input clk;
/*input [12:0] address; // to select the address of instruction to burn
input [31:0] instruction_program; // instruction to burn in the memory
input instruction_write; // setit to high to write in the instruction memory
*/
output [31:0] Current_instruction,Next_instruction ; // word in instruction is 32 bit 
/*
 * We have 32KB instruction memory 
 * and 4 byte for each instruction 
 * So We will have (2^13) instruction == 8192  [8191:0]
*/
reg [31:0] instruction_array [0:8191]; 

/*
 * When the PC changes 
 * Then We will Fetch the Next Instruction from The INSTRUCTION_Memory
*/
assign Current_instruction = instruction_array [Current_pc/4];
assign Next_instruction = instruction_array [Next_pc/4];

initial
begin
$readmemb("F:/Test_cases/test.txt",instruction_array); // first arguement file txt path of machine code
end

endmodule
