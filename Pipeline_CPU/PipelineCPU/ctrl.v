module control (
    op,func,rt,
    RegDst,ALUsrc,MemtoReg,RegWr,MemWr,Extop,ExtopM,IsLink,IsByteW,IsByteB,
    ALUctr,Jumpctr,Branchctr,
    MemRead
);

input[5:0] op,func;
input[4:0] rt;
output reg RegDst,ALUsrc,MemtoReg,RegWr,MemWr,Extop,ExtopM,IsLink,IsByteW,IsByteB;
output reg MemRead;
output reg[3:0] ALUctr;
output reg[1:0] Jumpctr;
output reg[2:0] Branchctr;

// 使用朴素的判别方式
always @(*) begin
    if(op==6'b000000)begin
        // R型
        // init
        Branchctr=3'b000;
        Jumpctr=2'b00;
        ALUctr=4'b0000;
        RegDst=1;
        ALUsrc=0;
        MemtoReg=0;
        RegWr=1;
        MemWr=0;
        Extop=0;
        ExtopM=0;
        IsLink=0;
        IsByteW=0;
        IsByteB=0;
        MemRead=0;
        if(func==6'b100001)begin
            // addu
            ALUctr=4'b0000; // 无符号加
        end
        else if(func==6'b100011)begin
            // subu
            ALUctr=4'b0001; // 无符号减
        end
        else if(func==6'b101010)begin
            // slt
            ALUctr=4'b0010; // 小于置位
        end
        else if(func==6'b100100)begin
            // and
            ALUctr=4'b0011; // 按位与
        end
        else if(func==6'b100111)begin
            // nor
            ALUctr=4'b0100; // 按位或非
        end
        else if(func==6'b100101)begin
            // or
            ALUctr=4'b0101; // 按位或
        end
        else if(func==6'b100110)begin
            // xor
            ALUctr=4'b0110; // 按位异或
        end
        else if(func==6'b000000)begin
            // sll
            ALUctr=4'b0111; // 逻辑左移
        end
        else if(func==6'b000010)begin
            // srl
            ALUctr=4'b1000; // 逻辑右移
        end
        else if(func==6'b101011)begin
            // sltu
            ALUctr=4'b0010; // 小于置位
        end
        else if(func==6'b001001)begin
            // jalr
            ALUctr=4'b1001; // jalr特殊1
            Jumpctr=2'b10;
        end
        else if(func==6'b001000)begin
            // jr
            ALUctr=4'b1010; // jr特殊2
            Jumpctr=2'b10;
        end
        else if(func==6'b000100)begin
            // sllv
            ALUctr=4'b1011; // 变量的左移
        end
        else if(func==6'b000011)begin
            // sra
            ALUctr=4'b1100; // 算术右移
        end
        else if(func==6'b000111)begin
            // srav
            ALUctr=4'b1101; // 变量的算术右移
        end
        else if(func==6'b000110)begin
            // srlv
            ALUctr=4'b1110; // 变量的逻辑右移
        end
    end
    else begin
        // 非R型
        Branchctr=3'b000;
        Jumpctr=2'b00;
        ALUctr=4'b0000;
        RegDst=0;
        ALUsrc=1;
        MemtoReg=0;
        RegWr=1;
        MemWr=0;
        Extop=0;
        ExtopM=0;
        IsLink=0;
        IsByteW=0;
        IsByteB=0;
        MemRead=0;
        if(op==6'b001001)begin
            // addiu
            ALUctr=4'b0000;
            Extop=1;
        end
        else if(op==6'b000100)begin
            // beq
            ALUctr=4'b0001;
            Branchctr=3'b001;
            Extop=1;
            ALUsrc=0;
            RegWr=0;
        end
        else if(op==6'b000101)begin
            // bne
            ALUctr=4'b0001;
            Branchctr=3'b010;
            Extop=1;
            ALUsrc=0;
            RegWr=0;
        end
        else if(op==6'b100011)begin
            // lw
            ALUctr=4'b0000;
            Extop=1;
            MemtoReg=1;
            MemRead=1;
        end
        else if(op==6'b101011)begin
            // sw
            ALUctr=4'b0000;
            Extop=1;
            RegWr=0;
            MemWr=1;
        end
        else if(op==6'b001111)begin
            // lui
            ALUctr=4'b1111;
        end
        else if(op==6'b001010)begin
            // slti
            ALUctr=4'b0010;
            Extop=1;
        end
        else if(op==6'b001011)begin
            // sltiu
            ALUctr=4'b0010;
            Extop=1;
        end
        else if(op==6'b000001)begin
            if(rt==5'b00001)begin
                // bgez
                ALUctr=4'b0001;
                Branchctr=3'b011;
                Extop=1;
                ALUsrc=0;
                RegWr=0;
            end
            else if(rt==5'b00000)begin
                // bltz
                ALUctr=4'b0001;
                Branchctr=3'b100;
                Extop=1;
                ALUsrc=0;
                RegWr=0;          
            end
        end
        else if(op==6'b000111)begin
            // bgtz
            ALUctr=4'b0001;
            Branchctr=3'b101;
            Extop=1;
            ALUsrc=0;
            RegWr=0;
        end
        else if(op==6'b000110)begin
            // blez
            ALUctr=4'b0001;
            Branchctr=3'b110;
            Extop=1;
            ALUsrc=0;
            RegWr=0;
        end
        else if(op==6'b100000)begin
            // lb
            ALUctr=4'b0000;
            Extop=1;
            ExtopM=1;
            MemtoReg=1;
            IsByteW=1;
            MemRead=1;
        end
        else if(op==6'b100100)begin
            // lbu
            ALUctr=4'b0000;
            Extop=1;
            MemtoReg=1;
            IsByteW=1;
            MemRead=1;
        end
        else if(op==6'b101000)begin
            // sb
            ALUctr=4'b0000;
            Extop=1;
            RegWr=0;
            MemWr=1;
            IsByteB=1;
            MemtoReg=1;
        end
        else if(op==6'b001100)begin
            // andi
            ALUctr=4'b0011;
        end
        else if(op==6'b001101)begin
            // ori
            ALUctr=4'b0101;
        end
        else if(op==6'b001110)begin
            // xori
            ALUctr=4'b0110;
        end
        else if(op==6'b000010)begin
            // j
            Jumpctr=2'b01;
            RegWr=0;
        end
        else if(op==6'b000011)begin
            // jal
            Jumpctr=2'b01;
            RegWr=0;
            IsLink=1;
        end
    end
end
    
endmodule