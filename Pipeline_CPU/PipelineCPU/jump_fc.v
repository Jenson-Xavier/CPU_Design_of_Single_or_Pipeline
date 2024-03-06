// jump和branch统一放到mem段处理了

module jump_fc (
    Jumpctr,
    Jump_fc
);

input[1:0] Jumpctr;
output reg Jump_fc;

initial begin
    Jump_fc=0;
end

always @(*) begin
    if(Jumpctr==2'b00)begin
        // 不跳转预测正确
        Jump_fc=0;
    end
    else begin
        Jump_fc=1;
    end
end

endmodule