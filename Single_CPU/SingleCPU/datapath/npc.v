// 计算下地址模块

module npc (
    out_pc,imm32,target,RegtoJump,Jumpctr,Branchctr,Zero,Sign,in_pc
);

input[31:0] out_pc;
input[31:0] imm32;
input[25:0] target;
input[31:0] RegtoJump;
input[1:0] Jumpctr;
input[2:0] Branchctr;
input Zero,Sign;
output reg[31:0] in_pc;

always @(*) begin
    in_pc<=out_pc+4;
    if(Jumpctr!=0)begin
        // 是跳转
        if(Jumpctr==2'b01)begin
            // in_pc<={out_pc[31:28],target<<2};
            in_pc<=32'h00003000+(target<<2);
        end
        else if(Jumpctr==2'b10)begin
            // in_pc<=RegtoJump;
            in_pc<=32'h00003000+RegtoJump;
        end
    end
    else if(Branchctr!=0)begin
        if(Branchctr==3'b001)begin
            // 相等跳转
            if(Zero==1)begin
                in_pc<=out_pc+(imm32<<2);
            end
        end
        else if(Branchctr==3'b010)begin
            // 不等跳转
            if(Zero!=1)begin
                in_pc<=out_pc+(imm32<<2);
            end
        end
        else if(Branchctr==3'b011)begin
            // 大于等于0跳转
            if(Zero==1 || Sign==1)begin
                in_pc<=out_pc+(imm32<<2);
            end
        end
        else if(Branchctr==3'b100)begin
            // 小于0跳转
            if(Zero!=1 && Sign==0)begin
                in_pc<=out_pc+(imm32<<2);
            end
        end
        else if(Branchctr==3'b101)begin
            // 大于0跳转
            if(Zero!=1 && Sign==1)begin
                in_pc<=out_pc+(imm32<<2);
            end
        end
        else if(Branchctr==3'b110)begin
            // 小于等于0跳转
            if(Zero==1 || Sign==0)begin
                in_pc<=out_pc+(imm32<<2);
            end
        end
    end
end

endmodule