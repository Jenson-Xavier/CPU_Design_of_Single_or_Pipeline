`timescale 1ns/1ns

`include "addr2dm.v"
`include "alu.v"
`include "dm.v"
`include "EX_MEMseg.v"
`include "extend.v"
`include "ID_EXseg.v"
`include "IF_IDseg.v"
`include "im.v"
`include "MEM_WRseg.v"
`include "mux.v"
`include "npc.v"
`include "pc.v"
`include "pc2addr.v"
`include "registers.v"
`include "sb.v"

`include "forward_detect.v"
`include "aluin_mux.v"
`include "dmin_mux.v"
`include "loaduse_detect.v"
`include "branch_fc.v"
`include "jump_fc.v"

module mips (
    clk,reset
);

input clk,reset;

wire[31:0] in_pc,out_pc,out_pc1,out_pc2,out_pc3,out_pc4;
wire[11:2] im_addr;
wire[31:0] ins;
wire[5:0] op,op1;
wire[4:0] rs,rt,rd,rt1,rd1,rs1,rt2,rd2,rt3,rd3;
wire[4:0] shf,shf1;
wire[5:0] func;
wire[15:0] imm16,imm161;
wire[25:0] target,target1,target2;
wire[31:0] imm32,imm321;
wire RegDst,ALUsrc,MemtoReg,RegWr,MemWr,Extop,ExtopM,IsLink,IsByteW,IsByteB,MemRead;
wire RegDst1,MemtoReg1,RegWr1,MemWr1,Extop1,ExtopM1,IsLink1,IsByteW1,IsByteB1;
wire RegDst2,MemtoReg2,RegWr2,ExtopM2,IsLink2,IsByteW2;
wire[3:0] ALUctr;
wire[1:0] Jumpctr,Jumpctr1;
wire[2:0] Branchctr,Branchctr1;
wire[31:0] busA,busB,busW,busA1,busB1,busB2,busB_t;
wire[31:0] Result,RegtoJump,Result1,RegtoJump1,Result2;
wire[31:0] in1,in2;
wire Zero,Sign,Zero1,Sign1;
wire[11:2] dm_addr;
wire[31:0] dm_dout,dm_wr,dm_dout1,dm_wrpre;
wire[1:0] ALUSrcA,ALUSrcB,DMSrc;
wire Load_Use,Branch_fc,Jump_fc;

pc my_pc(in_pc,clk,reset,out_pc,Load_Use);
pc2addr my_pc2addr(out_pc,im_addr);
im_4k my_im_4k(im_addr,ins);

IF_IDseg my_IF_IDseg(clk,out_pc,ins,out_pc1,op,rs,rt,rd,shf,func,imm16,target,
    Load_Use);
registers my_registers(clk,rs,rt,rt3,rd3,RegDst2,RegWr2,IsLink2,out_pc4,IsByteW2,ExtopM2,busA,busB,busW);
    
ID_EXseg my_ID_EXseg(clk,out_pc1,op,func,rt,rd,rs,shf,target,imm16,busA,busB,
    rt1,rd1,rs1,out_pc2,shf1,target1,imm161,busA1,busB1,
    RegDst,ALUsrc,MemtoReg,RegWr,MemWr,Extop,ExtopM,IsLink,IsByteW,IsByteB,
    ALUctr,Jumpctr,Branchctr,MemRead,
    Load_Use,Branch_fc,Jump_fc
    );
extend my_extend(imm161,imm32,Extop);
alu_in1_mux my_alu_in1_mux(busA1,Result1,busW,ALUSrcA,
    in1);
alu_in2_mux my_alu_in2_mux(busB1,Result1,busW,imm32,ALUSrcB,
    in2);
alu my_alu(ALUctr,in1,in2,shf1,out_pc2,Zero,Sign,Result,RegtoJump);
dm_in_mux my_dm_in_mux(busB1,Result1,busW,DMSrc,busB_t);
loaduse_detect my_loaduse_detect(MemRead,rt1,rs,rt,Branch_fc,Load_Use);

EX_MEMseg my_EX_MEMseg(clk,out_pc2,rt1,rd1,target1,imm32,busB_t,
    Zero,Sign,Result,RegtoJump,
    RegDst,MemtoReg,RegWr,MemWr,ExtopM,IsLink,IsByteW,IsByteB,
    Jumpctr,Branchctr,
    out_pc3,rt2,rd2,target2,imm321,busB2,
    Zero1,Sign1,Result1,RegtoJump1,
    RegDst1,MemtoReg1,RegWr1,MemWr1,ExtopM1,IsLink1,IsByteW1,IsByteB1,
    Jumpctr1,Branchctr1,
    Branch_fc,Jump_fc);
npc my_npc(out_pc,out_pc3,imm321,target2,RegtoJump1,Jumpctr1,Branchctr1,Zero1,Sign1,in_pc);
addr2dm my_addr2dm(Result1,dm_addr);
dm_4k my_dm_4k(dm_addr,dm_wr,MemWr1,clk,dm_dout);
sb my_sb(Result1,busB2,dm_dout,dm_wr,IsByteB1);

// 转发及控制冒险检测单元
forward_detect my_forward_detect(RegWr1,
    rt2,rd2,RegDst1,
    RegWr2,
    rt3,rd3,RegDst2,
    rs1,rt1,
    ALUsrc,
    ALUSrcA,ALUSrcB,DMSrc);
branch_fc my_branch_fc(Branchctr1,Zero1,Sign1,Branch_fc);
jump_fc my_jump_fc(Jumpctr1,Jump_fc);

MEM_WRseg my_MEM_WRseg(clk,out_pc3,Result1,rt2,rd2,
    RegDst1,MemtoReg1,RegWr1,ExtopM1,IsLink1,IsByteW1,
    dm_dout,
    out_pc4,Result2,rt3,rd3,
    RegDst2,MemtoReg2,RegWr2,ExtopM2,IsLink2,IsByteW2,
    dm_dout1);
mux_memtoreg my_mux_memtoreg(Result2,dm_dout1,MemtoReg2,busW);

endmodule 