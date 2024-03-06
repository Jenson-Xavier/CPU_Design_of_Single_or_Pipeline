module EX_MEMseg (
    clk,pc_in,rt_in,rd_in,target_in,imm32_in,busB_in,
    Zero_in,Sign_in,Result_in,RegtoJump_in,
    RegDst_in,MemtoReg_in,RegWr_in,MemWr_in,ExtopM_in,IsLink_in,IsByteW_in,IsByteB_in,
    Jumpctr_in,Branchctr_in,
    pc_out,rt_out,rd_out,target_out,imm32_out,busB_out,
    Zero_out,Sign_out,Result_out,RegtoJump_out,
    RegDst_out,MemtoReg_out,RegWr_out,MemWr_out,ExtopM_out,IsLink_out,IsByteW_out,IsByteB_out,
    Jumpctr_out,Branchctr_out,
    Branch_fc,Jump_fc
);

input clk,Zero_in,Sign_in;
input RegDst_in,MemtoReg_in,RegWr_in,MemWr_in,ExtopM_in,IsLink_in,IsByteW_in,IsByteB_in;
input[4:0] rt_in,rd_in;
input[31:0] pc_in,imm32_in,busB_in,Result_in,RegtoJump_in;
input[25:0] target_in;
input[1:0] Jumpctr_in;
input[2:0] Branchctr_in;
input Branch_fc,Jump_fc;
output reg Zero_out,Sign_out;
output reg RegDst_out,MemtoReg_out,RegWr_out,MemWr_out,ExtopM_out,IsLink_out,IsByteW_out,IsByteB_out;
output reg[4:0] rt_out,rd_out;
output reg[25:0] target_out;
output reg[31:0] pc_out,imm32_out,busB_out,Result_out,RegtoJump_out;
output reg[1:0] Jumpctr_out;
output reg[2:0] Branchctr_out;

always @(negedge clk) begin
    pc_out<=pc_in;
    rt_out<=rt_in;
    rd_out<=rd_in;
    target_out<=target_in;
    imm32_out<=imm32_in;
    busB_out<=busB_in;
    Zero_out<=Zero_in;
    Sign_out<=Sign_in;
    Result_out<=Result_in;
    RegtoJump_out<=RegtoJump_in;
    RegDst_out<=RegDst_in;
    MemtoReg_out<=MemtoReg_in;
    RegWr_out<=RegWr_in;
    MemWr_out<=MemWr_in;
    ExtopM_out<=ExtopM_in;
    IsLink_out<=IsLink_in;
    IsByteW_out<=IsByteW_in;
    IsByteB_out<=IsByteB_in;
    Jumpctr_out<=Jumpctr_in;
    Branchctr_out<=Branchctr_in;
    if(Branch_fc || Jump_fc)begin
        pc_out<=0;
        rt_out<=0;
        rd_out<=0;
        target_out<=0;
        imm32_out<=0;
        busB_out<=0;
        Zero_out<=0;
        Sign_out<=0;
        Result_out<=0;
        RegtoJump_out<=0;
        RegDst_out<=0;
        MemtoReg_out<=0;
        RegWr_out<=0;
        MemWr_out<=0;
        ExtopM_out<=0;
        IsLink_out<=0;
        IsByteW_out<=0;
        IsByteB_out<=0;
        Jumpctr_out<=0;
        Branchctr_out<=0;
    end
end
endmodule