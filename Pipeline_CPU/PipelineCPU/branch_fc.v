module branch_fc (
    Branchctr,Zero,Sign,
    Branch_fc
);

input[2:0] Branchctr;
input Zero,Sign;
output reg Branch_fc;

initial begin
    Branch_fc=0;    
end

always @(*) begin
    Branch_fc=0;
    if(Branchctr==3'b001)begin
        // 相等跳转
        if(Zero==1)begin
            Branch_fc=1;
        end
    end
    else if(Branchctr==3'b010)begin
        // 不等跳转
        if(Zero!=1)begin
            Branch_fc=1;
        end
    end
    else if(Branchctr==3'b011)begin
        // 大于等于0跳转
        if(Zero==1 || Sign==1)begin
            Branch_fc=1;
        end
    end
    else if(Branchctr==3'b100)begin
        // 小于0跳转
        if(Zero!=1 && Sign==0)begin
            Branch_fc=1;
        end
    end
    else if(Branchctr==3'b101)begin
        // 大于0跳转
        if(Zero!=1 && Sign==1)begin
            Branch_fc=1;
        end
    end
    else if(Branchctr==3'b110)begin
        // 小于等于0跳转
        if(Zero==1 || Sign==0)begin
            Branch_fc=1;
        end
    end
end

endmodule