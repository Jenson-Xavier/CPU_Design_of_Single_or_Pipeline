// 寄存器组模块

module registers (
    clk,rs,rt,rd,
    RegDst,RegWr,IsLink,out_pc,IsByteW,IsByteB,ExtopM,
    busA,busB,busW,dm_addr
);

input clk,RegDst,RegWr,IsLink,IsByteW,IsByteB,ExtopM;
input[4:0] rs,rt,rd;
input[31:0] out_pc;
input[31:0] busW;
input[31:0] dm_addr;
output reg[31:0] busA,busB;

reg[31:0] regs[0:31];
integer i,j;

initial begin
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
                    regs[rd]={{24{busW[7]}},busW[7:0]};
                end
                else begin
                    regs[rd]={24'b0,busW[7:0]};
                end
            end
            else begin
                regs[rd]=busW;
            end
        end
        else begin
            if(IsByteW)begin
                regs[rt]={24'b0,busW[7:0]};
            end
            else begin
                regs[rt]=busW;
            end
        end
    end
end

always @(*) begin
    busA<=regs[rs];
    if(IsByteB)begin
        // 注意是小端
        j=dm_addr%4;
        if(j==0)begin
            busB<={busW[31:8],regs[rt][7:0]};
        end
        else if(j==1)begin
            busB<={busW[31:16],regs[rt][7:0],busW[7:0]};
        end
        else if(j==2)begin
            busB<={busW[31:24],regs[rt][7:0],busW[15:0]};
        end
        else begin
            busB<={regs[rt][7:0],busW[23:0]};
        end
    end
    else begin
        busB<=regs[rt];
    end
end
    
endmodule