// 数据存储器模块

module dm_4k (
    addr,din,we,clk,dout
);

input[11:2] addr;
input[31:0] din;
input we,clk;
output reg[31:0] dout;

reg[31:0] dm[0:1023];
integer i;

initial begin
    for(i=0;i<1024;i=i+1)begin
        dm[i]<=0;
    end
end

always @(posedge clk) begin
    if(we==1)begin
        dm[addr]<=din;
    end
end

always @(*) begin
    dout<=dm[addr];
end
    
endmodule