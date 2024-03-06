// 将计算得到的地址转为访问数据存储器的地址

module addr2dm (
    in_addr,addr
);

input[31:0] in_addr;
output[11:2] addr;

assign addr=in_addr[11:2];
    
endmodule