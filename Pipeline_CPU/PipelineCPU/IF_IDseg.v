module IF_IDseg (
    clk,pc_in,ins,
    pc_out,op,rs,rt,rd,shf,func,imm16,target,
    Load_Use
);

input clk;
input[31:0] pc_in,ins;
input Load_Use;
output reg[31:0] pc_out;
output reg[5:0] op;
output reg[4:0] rs,rt,rd;
output reg[4:0] shf;
output reg[5:0] func;
output reg[15:0] imm16;
output reg[25:0] target;

always @(negedge clk) begin
    if(Load_Use!=1)begin
        pc_out<=pc_in;
        op<=ins[31:26];
        rs<=ins[25:21];
        rt<=ins[20:16];
        rd<=ins[15:11];
        shf<=ins[10:6];
        func<=ins[5:0];
        imm16<=ins[15:0];
        target<=ins[25:0];
    end
end

endmodule