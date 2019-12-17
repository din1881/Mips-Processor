module FORWARDING_unit (Rs_IDEX, Rt_IDEX,Rs_ID , Rt_ID, regwrite_EXMEM , Rd_EXMEM , regwite_MEMWB ,Rd_MEMWB ,forward_a , forward_b,forward_beq,branch);

input wire [4:0]Rs_IDEX, Rt_IDEX , Rd_EXMEM , Rd_MEMWB,Rs_ID,Rt_ID;
input wire [0:0]regwrite_EXMEM , regwite_MEMWB ,branch ; 

output reg [1:0] forward_a , forward_b ; 
output reg [1:0] forward_beq;
initial begin 
forward_a <=0;
forward_b <=0;
end

always @ (*)
begin 

/* 1st condition: when we make a forward from (output_reg(Rd) of Execution stage)  will be used in (the (Rs) of next-instruction's Decode stage) 
 * Ex : add $s1 , $s2 , $s3 ; 
 *      sub $s5 , $s1 , $s4 ; note that $s1 in the Rs field
*/
begin 
if((regwrite_EXMEM) && (Rs_IDEX==Rd_EXMEM) && (Rd_EXMEM!=0))
forward_a <= 2'b10; 

/* 1st condition: when we make a forward from (output_reg(Rd) of Memory stage)  will be used in (the (Rs) of next-instruction's decode stage) 
 * Ex : lw $s1 ,32($t3) ; 
 *      add $t1 , $t2 , $t4 ; 
 *      sub $s5 , $s1 , $s4 ; note that $s1 in the Rs field
 * but NOTE : there is a special case we will ignore forwarding of MEM stage 
 * this case will happen if the 2nd instruction in our example (add) will (use $s1 as Rd)
 * so, we want the (3rd instruction(sub))to use the output of (2nd instruction (add))
*/
else if((regwite_MEMWB) && (Rd_MEMWB!=0) && (!((regwrite_EXMEM) && (Rs_IDEX==Rd_EXMEM) && (Rd_EXMEM!=0))) && ((Rs_IDEX==Rd_MEMWB)) )
forward_a <= 2'b01; 

else // if the two conditions fals so choose the Rs from the IDEX_reg
 forward_a  <= 2'b00; 

end 

begin 
/* 1st condition: when we make a forward from (output_reg(Rd) of Execution stage)  will be used in (the (Rt) of next-instruction's Decode stage) 
 * Ex : add $s1 , $s2 , $s3 ; 
 *      sub $s5 , $s4 , $s1 ; note that $s1 in the Rt field
*/
if((regwrite_EXMEM) && (Rt_IDEX==Rd_EXMEM) && (Rd_EXMEM!=0))
forward_b <= 2'b10; 


/* 1st condition: when we make a forward from (output_reg(Rd) of Memory stage)  will be used in (the (Rs) of next-instruction's decode stage) 
 * Ex : lw $s1 ,32($t3) ; 
 *      add $t1 , $t2 , $t4 ; 
 *      sub $s5 , $s4 , $s1 ; // note that $s1 in the Rt field
 * but NOTE : there is a special case we will ignore forwarding of MEM stage 
 * this case will happen if the 2nd instruction in our example (add) will (use $s1 as Rd)
 * so, we want the (3rd instruction(sub))to use the output of (2nd instruction (add))
*/
else if((regwite_MEMWB) && (Rd_MEMWB!=0) && (!((regwrite_EXMEM) && (Rt_IDEX==Rd_EXMEM) && (Rd_EXMEM!=0))) && ((Rt_IDEX==Rd_MEMWB)) )
forward_b <= 2'b01;

else // if the two conditions fals so choose the Rt from the IDEX_reg
 forward_b  <= 2'b00; 
end 

begin
if((branch) && (Rs_ID==Rd_EXMEM))
forward_beq <= 2'b01; 

else if((branch) && (Rt_ID==Rd_EXMEM))
forward_beq <= 2'b10; 

else // if the two conditions fals so choose the Rs from the IDEX_reg
forward_beq  <= 2'b00; 

end 

end 
endmodule 

