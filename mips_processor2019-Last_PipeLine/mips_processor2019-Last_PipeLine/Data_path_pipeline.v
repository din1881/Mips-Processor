/*Data Path Module is the module that encapsulates Instances I/O Wires/Registers to perform the function of 
  a pipelined processor
*/
module DATA_path_pipeline();
/*Instruction register wire */
wire [31:0] IR_next;
/* Program counter wires*/
wire [12:0] current_pc, next_pc;
/* assign wire pc + 4 in 13-bit to avoid data over flow and warnings */
wire [12:0] current_pc_plus_4 = current_pc + 4; 

/* Branch Table Singal */
wire [12:0] label_out;
wire branch_control;

/* Jump Singal */
wire [12:0] jump_address;

/* Instruction Memory wires*/
wire [31:0] Inst_Mem_out;

/************************************ ID Stage Wires**************************************/
wire [31:0] IR_IF_ID_Reg;
wire [12:0] Adder_result_IF_ID_Reg;
wire [31:0] sign_extend_res;
wire [12:0] label_beq_pcplus4;
wire [12:0] pc_plus_4_branch;
wire comparator_result;
wire [1:0] fowrward_beq;
wire [31:0] fowrward_beq_data1,fowrward_beq_data2;

/* ID-EX Reg Wires */ 
wire REGDST_out,memread_out, memtoreg_out, memwrite_out, ALUSRC1_out, regwrite_out ; 
wire [1:0]ALUOP_out;
wire [4:0]Rs_out , Rt_out , Rd_out ;
wire [31:0]read_data1_out, read_data2_out ; 
/* Register file wires*/
//wire [4:0] write_reg;
//wire [31:0] write_data;
wire [31:0] read_data1, read_data2;

/*************************************Execution Stage Wires*******************************/ 
wire [31:0] SIGN_extended_out ; 
/* Forwadring unit wires */
wire [1:0]forward_a ,forward_b ; 

/* Mux's wires in Execution stage */ 
wire [4:0] out_MUX_REGDST ; 
wire [1:0] out_EX_Flush_Mem , out_EX_Flush_WB; 
wire [31:0] out_MUX_forward_a , out_MUX_forward_b ,  out_MUX_ALUSrc ;

/* EXMEM Register wires */
wire RegWrite_EXMEM_out , MemtoReg_EXMEM_out , MemRead_EXMEM_out ,MemWrite_EXMEM_out ;
wire [31:0] address_EXMEM_out  , WriteData_out ;
wire [4:0] Rd_EXMEM_out; 

/* ALU Control wires */ 
wire [3:0] Aluctl ; 

/* ALU wires */ 
wire [31:0] out_ALU ; 
/*********************************************************************************/

/* EXMEM Register wires */
//wire [4:0] Rd_MEMWB_out; 
//wire RegWrite_MEMWB_out ; 

/**********************************Outputs of control Unit ************************/
wire CLK;
wire RegDst;
wire MemRead;
wire MemtoReg;
wire MemWrite;
wire ALUSrc;
wire RegWrite;
wire [1:0] ALUop;
wire Branch;
wire IF_flush;
wire ID_flush;
wire EX_flush;
wire PCsrc;
wire Jump_ID;
wire Jump;
wire Jump_r;

//inputs to id/ex register
wire [7:0] mux_out;

//data_hazard unit wires
wire hold;


//MEM_WB Wires
wire [31:0] MeM_Read_data;
wire [31:0] MUX_MemToReg_out;
// MEM_WB Forwarding unit selection wire 
wire [31:0] DM_ExeReg_Sel;

// MEM_WB Register outputs
wire [31:0] MEM_WB_REG_Read_Data_out;
wire [31:0] MEM_WB_REG_Alu_Result_out;
wire [4:0]  MEM_WB_REG_Rd_out;
wire MEM_WB_REG_RegWrite_out, MEM_WB_REG_MemToReg_out;

/*****************************************************************Modules Instances******************************************************/

/*****************************************ID & IF Stages**********************************/
 CLOCK_generation clock(CLK);
PC pc(next_pc,CLK,current_pc);

and beq(PCsrc,Branch,comparator_result);

BRANCH_table b_t(branch_control,Branch,next_pc,IR_next[31:26],PCsrc,current_pc_plus_4 + {IR_next[10:0],2'b00} + 4,label_out,CLK);

INSTRUCTION_memory_pipeline instruction_memory(current_pc,next_pc,Inst_Mem_out,IR_next);

jump_handle Jump_hundler(Inst_Mem_out[6:0],current_pc,jump_address);

IF_ID if_id(CLK, current_pc_plus_4,hold,IF_flush, Inst_Mem_out, IR_IF_ID_Reg, Adder_result_IF_ID_Reg);

REGISTER_file R_file(CLK, MEM_WB_REG_RegWrite_out, IR_IF_ID_Reg[25:21], IR_IF_ID_Reg[20:16], MEM_WB_REG_Rd_out, MUX_MemToReg_out, read_data1, read_data2);

comparator comp(fowrward_beq_data1, fowrward_beq_data2, comparator_result);

JUMP_control_unit jump_unit(Inst_Mem_out[31:26],Jump_ID);

jump_handle jump_handler(Inst_Mem_out[6:0],current_pc,jump_address);

CONTROL_unit control_u(IR_IF_ID_Reg[31:26],IR_IF_ID_Reg[5:0],RegDst, MemRead, MemtoReg, ALUop, MemWrite, ALUSrc, RegWrite, Branch, Jump,Jump_r,jal,ID_flush, EX_flush, IF_flush);

SIGN_extension ext(IR_IF_ID_Reg[15:0],sign_extend_res);

adder a(pc_plus_4_branch, {sign_extend_res[10:0],2'b00} , Adder_result_IF_ID_Reg);

HazardDetectionUnit hz(MemRead_EXMEM_out, Rt_out, IR_IF_ID_Reg[25:21], IR_IF_ID_Reg[20:16], CLK, hold);

IDEX_reg id_exe_reg(CLK,mux_out[0],mux_out[5], mux_out[6], mux_out[2:1],mux_out[4], mux_out[3],mux_out[7],read_data1, read_data2 ,sign_extend_res ,IR_IF_ID_Reg[25:21] , IR_IF_ID_Reg[20:16] , IR_IF_ID_Reg[15:11],
           	REGDST_out,memread_out, memtoreg_out, memwrite_out, ALUSRC1_out, regwrite_out,ALUOP_out,Rs_out , Rt_out , Rd_out ,read_data1_out, read_data2_out,SIGN_extended_out);

MUX2to1_8 control_mux((ID_flush | hold),8'b0,{RegWrite, MemtoReg, MemRead, MemWrite, ALUSrc, ALUop, RegDst}, mux_out);

MUX3to1_13 mux_beq_pc({PCsrc,branch_control},current_pc_plus_4,label_out,pc_plus_4_branch,label_beq_pcplus4);

MUX2to1_13 mux_jump(Jump_ID,label_beq_pcplus4,jump_address,next_pc);

MUX2to1_32 mux_beq1(fowrward_beq[0],read_data1,out_ALU,fowrward_beq_data1);
MUX2to1_32 mux_beq2(fowrward_beq[0],read_data2,out_ALU,fowrward_beq_data2);

/**************************************Execution Stage*********************************************/
MUX2to1_5  MUX_REGDST (REGDST_out,Rt_out,Rd_out,out_MUX_REGDST); // out_MUX_REGDST will be input to EXMEM Reg 
MUX2to1_2  MUX_EX_Flush_Mem (EX_flush , 2'b0 ,{memwrite_out,memread_out},  out_EX_Flush_Mem) ; //out_EX_Flush_Mem  will be input to EXMEM Reg 
MUX2to1_2  MUX_EX_Flush_WB (EX_flush , 2'b0 , {memtoreg_out,regwrite_out},  out_EX_Flush_WB) ; //out_EX_Flush_WB  will be input to EXMEM Reg 

MUX3to1_32 MUX_forward_a (forward_a, read_data1_out, MUX_MemToReg_out ,address_EXMEM_out ,out_MUX_forward_a);  
MUX3to1_32 MUX_forward_b (forward_b, read_data2_out, MUX_MemToReg_out ,address_EXMEM_out ,out_MUX_forward_b); //  out_MUX_forward_b will be input to EXMEM Reg

MUX2to1_32 MUX_ALUSrc (ALUSRC1_out , out_MUX_forward_b ,SIGN_extended_out , out_MUX_ALUSrc); 

ALU_control ALU_ctrl(SIGN_extended_out[5:0], ALUOP_out, Aluctl); 

ALU alu_module(SIGN_extended_out[10:6],out_MUX_forward_a,out_MUX_ALUSrc, Aluctl, out_ALU);  // out_ALU will be input to EXMEM Reg 

EXMEM_REG EX_Mem_reg(CLK ,out_EX_Flush_WB[0] , out_EX_Flush_WB[1] , out_EX_Flush_Mem[0] ,out_EX_Flush_Mem[1] , out_ALU , out_MUX_forward_b , out_MUX_REGDST ,
                  RegWrite_EXMEM_out , MemtoReg_EXMEM_out , MemRead_EXMEM_out ,MemWrite_EXMEM_out , address_EXMEM_out  , WriteData_out , Rd_EXMEM_out );


FORWARDING_unit FWD_unit (Rs_out,Rt_out,Inst_Mem_out[25:21],Inst_Mem_out[20:16],RegWrite_EXMEM_out,Rd_EXMEM_out, MEM_WB_REG_RegWrite_out, MEM_WB_REG_Rd_out, forward_a , forward_b,fowrward_beq,Branch); 


/**************************************MEM/WB Stage*********************************************/

DATA_memory dataMem(MeM_Read_data, address_EXMEM_out[12:0], MemWrite_EXMEM_out, MemRead_EXMEM_out, DM_ExeReg_Sel, CLK);

Mem_stage_forwarding_unit memF_U(DM_ExeReg_Sel, MemWrite_EXMEM_out, Rd_EXMEM_out, MEM_WB_REG_Rd_out, MEM_WB_REG_Read_Data_out, WriteData_out);

MEM_Wb_Reg mem_wb_reg( MEM_WB_REG_RegWrite_out, MEM_WB_REG_MemToReg_out, MEM_WB_REG_Alu_Result_out, MEM_WB_REG_Rd_out , MEM_WB_REG_Read_Data_out, CLK, 
			RegWrite_EXMEM_out,MemtoReg_EXMEM_out,address_EXMEM_out ,MeM_Read_data,Rd_EXMEM_out);

MUX2to1_32 MUX_MemToReg(MEM_WB_REG_MemToReg_out,MEM_WB_REG_Alu_Result_out,MEM_WB_REG_Read_Data_out,MUX_MemToReg_out);


endmodule
