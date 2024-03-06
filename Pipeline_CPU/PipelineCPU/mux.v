module mux_memtoreg (
    ALU_out,datamem_out,MemtoReg,memtoreg_out
);

input[31:0] ALU_out;
input[31:0] datamem_out;
input MemtoReg;
output reg[31:0] memtoreg_out;

always @(*) begin
    if(MemtoReg==1)
        memtoreg_out<=datamem_out;
    else
        memtoreg_out<=ALU_out;
end
endmodule

// 确定ALU源操作数二选一模块
module mux_alusrc (
    regs_busB,ext_imm32,ALUsrc,ALU_Bin
);

input[31:0] regs_busB;
input[31:0] ext_imm32;
input ALUsrc;
output reg[31:0] ALU_Bin;

always @(*) begin
    if(ALUsrc==1)
        ALU_Bin<=ext_imm32;
    else
        ALU_Bin<=regs_busB;
end
endmodule