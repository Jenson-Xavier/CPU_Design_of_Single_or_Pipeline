module addr2dm (
    in_addr,addr
);

input[31:0] in_addr;
output[11:2] addr;

assign addr=in_addr[11:2];
    
endmodule