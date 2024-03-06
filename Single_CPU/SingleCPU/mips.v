`timescale 1ns/1ns

`include "datapath/pc.v"
`include "datapath/pc2addr.v"
`include "datapath/im.v"
`include "datapath/decode.v"
`include "datapath/addr2dm.v"
`include "datapath/alu.v"
`include "datapath/dm.v"
`include "datapath/extend.v"
`include "datapath/mux.v"
`include "datapath/npc.v"
`include "datapath/registers.v"
`include "control/ctrl.v"

module mips (
    clk,reset
);

input clk,reset;

wire[31:0] in_pc,out_pc;

pc my_pc(in_pc,clk,reset,out_pc);

wire[11:2] im_addr;

pc2addr my_pc2addr(out_pc,im_addr);

wire[31:0] ins;

im_4k my_im_4k(im_addr,ins);

wire[5:0] op;
wire[4:0] rs,rt,rd;
wire[4:0] shf;
wire[5:0] func;
wire[15:0] imm16;
wire[25:0] target;
wire[31:0] imm32;

decode my_decode(ins,op,rs,rt,rd,shf,func,imm16,target);

wire RegDst,ALUsrc,MemtoReg,RegWr,MemWr,Extop,ExtopM,IsLink,IsByteW,IsByteB;
wire[3:0] ALUctr;
wire[1:0] Jumpctr;
wire[2:0] Branchctr;

extend my_extend(imm16,imm32,Extop);

wire[31:0] busA,busB,busW;
wire[31:0] Result,RegtoJump;

registers my_registers(clk,rs,rt,rd,RegDst,RegWr,IsLink,out_pc,IsByteW,IsByteB,ExtopM,busA,busB,busW,Result);

wire[31:0] in2;

mux_alusrc my_mux_alusrc(busB,imm32,ALUsrc,in2);

wire Zero,Sign;

alu my_alu(ALUctr,busA,in2,shf,out_pc,Zero,Sign,Result,RegtoJump);

wire[11:2] dm_addr;
wire[31:0] dm_dout;

addr2dm my_addr2dm(Result,dm_addr);

dm_4k my_dm_4k(dm_addr,busB,MemWr,clk,dm_dout);

mux_memtoreg my_mux_memtoreg(Result,dm_dout,MemtoReg,busW);

npc my_npc(out_pc,imm32,target,RegtoJump,Jumpctr,Branchctr,Zero,Sign,in_pc);

control my_control(op,func,rt,RegDst,ALUsrc,MemtoReg,RegWr,MemWr,Extop,ExtopM,IsLink,IsByteW,IsByteB,ALUctr,Jumpctr,Branchctr);

endmodule