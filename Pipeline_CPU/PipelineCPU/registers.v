module registers (
    clk,rs,rt,w_rt,w_rd,
    RegDst,RegWr,IsLink,out_pc,IsByteW,ExtopM,
    busA,busB,busW
);

input clk,RegDst,RegWr,IsLink,IsByteW,ExtopM;
input[4:0] rs,rt,w_rt,w_rd;
input[31:0] out_pc;
input[31:0] busW;
output reg[31:0] busA,busB;

reg[31:0] regs[0:31];
integer i,j;

initial begin
    i=0;
    j=0;
    for(i=0;i<32;i=i+1)begin
        regs[i]<=0;
    end
end

always @(posedge clk) begin
    if(RegWr)begin
        if(IsLink)begin
            regs[31]=out_pc+4;
        end
        if(RegDst)begin
            if(IsByteW)begin
                if(ExtopM)begin
                    regs[w_rd]={{24{busW[7]}},busW[7:0]};
                end
                else begin
                    regs[w_rd]={24'b0,busW[7:0]};
                end
            end
            else begin
                regs[w_rd]=busW;
            end
        end
        else begin
            if(IsByteW)begin
                if(ExtopM)begin
                    regs[w_rt]={{24{busW[7]}},busW[7:0]};
                end
                else begin
                    regs[w_rt]={24'b0,busW[7:0]};
                end
            end
            else begin
                regs[w_rt]=busW;
            end
        end
    end
end

always @(*) begin
    busA<=regs[rs];
    busB<=regs[rt];
end
    
endmodule