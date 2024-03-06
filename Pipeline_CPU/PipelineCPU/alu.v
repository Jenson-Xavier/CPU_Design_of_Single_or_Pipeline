module alu (
    ALUctr,in1,in2,shf,out_pc,Zero,Sign,Result,RegtoJump
);

input[3:0] ALUctr;
input[31:0] in1,in2;
input[4:0] shf;
input[31:0] out_pc;
output reg Zero,Sign;
output reg[31:0] Result,RegtoJump;

initial begin
    Zero=0;
    Sign=0;
    Result=0;
    RegtoJump=0;
end

always @(*) begin
    case(ALUctr)
        4'b0000:begin
            // 无符号加
            Result=in1+in2;
            Zero=0;
            Sign=0;
        end
        4'b0001:begin
            // 无符号减
            Result=in1-in2;
            if(Result==0)begin
                Zero=1;
            end
            else begin
                Zero=0;
                if($signed(Result)<0)begin
                    Sign=0;
                end
                else begin
                    Sign=1;
                end
            end
        end
        4'b0010:begin
            // 小于置位
            if(in1<in2)begin
                Result=1;
            end
            else begin
                Result=0;
            end
        end
        4'b0011:begin
            // 按位与
            Result=in1 & in2;
        end
        4'b0100:begin
            // 按位或非
            Result=~(in1 | in2);
        end
        4'b0101:begin
            // 按位或
            Result=in1 | in2;
        end
        4'b0110:begin
            // 按位异或
            Result=in1 ^ in2;
        end
        4'b0111:begin
            // 逻辑左移
            Result=in2 << shf;
        end
        4'b1000:begin
            // 逻辑右移
            Result=in2 >> shf;
        end
        4'b1001:begin
            // jalr
            RegtoJump=in1;
            Result=out_pc+4;
        end
        4'b1010:begin
            // jr
            RegtoJump=in1;
            Result=0;
        end
        4'b1011:begin
            // 变量逻辑左移
            Result=in2 << in1;
        end
        4'b1100:begin
            // 算术右移
            Result=$signed(in2) >>> shf;
        end
        4'b1101:begin
            // 变量算术右移
            Result=$signed(in2) >>> in1;
        end
        4'b1110:begin
            // 变量的逻辑右移
            Result=in2 >> in1;
        end
        4'b1111:begin
            // lui特殊运算
            Result={in2,16'd0};
        end
    endcase
end

endmodule