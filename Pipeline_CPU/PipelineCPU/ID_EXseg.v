`include "ctrl.v"

module ID_EXseg (
    clk,pc_in,op_in,func_in,rt_in,rd_in,rs_in,shf_in,target_in,imm16_in,busA_in,busB_in,
    rt_out,rd_out,rs_out,pc_out,shf_out,target_out,imm16_out,busA_out,busB_out,
    RegDst,ALUsrc,MemtoReg,RegWr,MemWr,Extop,ExtopM,IsLink,IsByteW,IsByteB,
    ALUctr,Jumpctr,Branchctr,MemRead,
    Load_Use,Branch_fc,Jump_fc
);

input clk;
input[31:0] pc_in;
input[5:0] op_in,func_in;
input[4:0] rt_in,rd_in,rs_in,shf_in;
input[25:0] target_in;
input[15:0] imm16_in;
input[31:0] busA_in,busB_in;
input Load_Use,Branch_fc,Jump_fc;
output reg[31:0] pc_out;
output reg[4:0] rt_out,rd_out,rs_out,shf_out;
output reg[25:0] target_out;
output reg[15:0] imm16_out;
output reg[31:0] busA_out,busB_out;
output reg RegDst,ALUsrc,MemtoReg,RegWr,MemWr,Extop,ExtopM,IsLink,IsByteW,IsByteB;
output reg MemRead;
output reg[3:0] ALUctr;
output reg[1:0] Jumpctr;
output reg[2:0] Branchctr;

wire RegDst_t,ALUsrc_t,MemtoReg_t,RegWr_t,MemWr_t,Extop_t,ExtopM_t,IsLink_t,IsByteW_t,IsByteB_t;
wire MemRead_t;
wire[3:0] ALUctr_t;
wire[1:0] Jumpctr_t;
wire[2:0] Branchctr_t;

control my_control(op_in,func_in,rt_in,RegDst_t,ALUsrc_t,MemtoReg_t,RegWr_t,MemWr_t,
    Extop_t,ExtopM_t,IsLink_t,IsByteW_t,IsByteB_t,ALUctr_t,Jumpctr_t,Branchctr_t,MemRead_t);

always @(negedge clk) begin
    pc_out<=pc_in;
    rt_out<=rt_in;
    rd_out<=rd_in;
    rs_out<=rs_in;
    shf_out<=shf_in;
    target_out<=target_in;
    imm16_out<=imm16_in;
    busA_out<=busA_in;
    busB_out<=busB_in;
    RegDst<=RegDst_t;
    ALUsrc<=ALUsrc_t;
    MemtoReg<=MemtoReg_t;
    RegWr<=RegWr_t;
    MemWr<=MemWr_t;
    Extop<=Extop_t;
    ExtopM<=ExtopM_t;
    IsLink<=IsLink_t;
    IsByteW<=IsByteW_t;
    IsByteB<=IsByteB_t;
    ALUctr<=ALUctr_t;
    Jumpctr<=Jumpctr_t;
    Branchctr<=Branchctr_t;
    MemRead<=MemRead_t;
    if(Load_Use || Branch_fc || Jump_fc)begin
        pc_out<=0;
        rt_out<=0;
        rd_out<=0;
        rs_out<=0;
        shf_out<=0;
        target_out<=0;
        imm16_out<=0;
        busA_out<=0;
        busB_out<=0;
        RegDst<=0;
        ALUsrc<=0;
        MemtoReg<=0;
        RegWr<=0;
        MemWr<=0;
        Extop<=0;
        ExtopM<=0;
        IsLink<=0;
        IsByteW<=0;
        IsByteB<=0;
        ALUctr<=0;
        Jumpctr<=0;
        Branchctr<=0;
        MemRead<=0;
    end
end

endmodule