// 写数据存储器的多路选择器

module dm_in_mux (
    busB,Result,mem_result,DMSrc,
    dm_write
);

input[31:0] busB,Result,mem_result;
input[1:0] DMSrc;
output reg[31:0] dm_write;

initial begin
    dm_write=0;
end

always @(*) begin
    if(DMSrc==2'b00)begin
        dm_write=busB;
    end
    else if(DMSrc==2'b01)begin
        dm_write=Result;
    end
    else if(DMSrc==2'b10)begin
        dm_write=mem_result;
    end
end

endmodule