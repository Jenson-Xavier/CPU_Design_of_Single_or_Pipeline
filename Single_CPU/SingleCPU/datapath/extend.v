// 扩展器模块

module extend (
    imm16,imm32,Extop
);
    
input[15:0] imm16;
input Extop;
output[31:0] imm32;

reg[31:0] temp;

always @(*) begin
    if(Extop==0)
        temp={16'b0,imm16[15:0]};               // 零扩展
    else
        temp={{16{imm16[15]}},imm16[15:0]};     // 符号扩展
end

assign imm32=temp;

endmodule