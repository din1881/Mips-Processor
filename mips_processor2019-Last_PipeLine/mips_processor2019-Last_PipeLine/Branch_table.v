module BRANCH_table(branch_control,beq,next_pc,branch_opcode_next,PCsrc,label_in_address_current,label_out_address,clk);
input clk,PCsrc,beq;
input [5:0] branch_opcode_next; // opcode of branch instruction
input [12:0] next_pc;
input [12:0] label_in_address_current; // the input target address 
output reg branch_control;
output reg [12:0] label_out_address;

reg [12:0] label_array [0:31];
reg [12:0] branch_array [0:31];
reg [1:0] state_prediction_array [0:31];

reg [1:0] next_state;

parameter S_NT=2'b00,W_NT=2'b01,W_T=2'b10,S_T=2'b11,T=1'b1,NT=1'b0;

initial
begin
branch_control <= 0;
end

integer i = 0,j;
reg [4:0] index = 0;// i for knowing number of branch instruction and j counter in the for loop and index for knowing the index branch if it is found
reg [4:0] temp = 0; 
reg [1:0] flag = 0;
reg [12:0] temp_pc;

always @ (posedge clk)
begin
if(flag == 1) // check if it branch instruction
begin

if(temp == 0) //set the data of branch instruction
begin
branch_array[i+1] <= temp_pc;
label_array[i+1] <= label_in_address_current;
branch_control <= 0;
state_prediction_array[i + 1] <= W_NT;
temp <= i+1;
i <= i+1;
flag <= 2;
end

else if(temp != 0)
begin
case(state_prediction_array[temp])
S_NT:
begin
branch_control <= 0;
end
W_NT:
begin
branch_control <= 0;
end
W_T: 
begin
branch_control <= 1;
label_out_address <= label_array[temp];
end
S_T: 
begin
branch_control <= 1;
label_out_address <= label_array[temp];
end
endcase
flag <= 2;
end

end
else if(flag != 1 && branch_control == 1)
begin
branch_control <= 0;
end
end


always @(PCsrc)
begin 

if(temp != 0 && flag == 2) // check if it branch instruction
begin
index <= 0;
flag <= 1;
temp_pc <= 0;
case(state_prediction_array[temp])

S_NT:
if(PCsrc == T)
begin
next_state = W_NT;
end
else if(PCsrc == NT)
begin
next_state = S_NT;
end


W_NT:
if(PCsrc == T)
begin
next_state = W_T;
end
else if(PCsrc == NT)
begin
next_state = S_NT;
end

W_T:
if(PCsrc == T)
begin
next_state = S_T;
end
else if(PCsrc == NT)
begin
next_state = W_NT;
end

S_T:
if(PCsrc == T)
begin
next_state = S_T;
end
else if(PCsrc == NT)
begin
next_state = W_T;
end

endcase

end

end



always @ (negedge clk )
begin

if(flag == 1) // check if it branch instruction
begin

if(temp != 0)
state_prediction_array[temp] = next_state;
temp = 0;
flag = 0;
end

end


always @(negedge clk)
begin

if(branch_opcode_next == 4) // check if it branch instruction
begin

flag <= 1;
temp_pc <= next_pc;
for(j=1;j<i+1;j=j+1)
begin

if(next_pc == branch_array[j])
begin
index <= j; // get the index if found
temp <= j;
j <= i;  // to break the loop
end

end

end

end

endmodule


