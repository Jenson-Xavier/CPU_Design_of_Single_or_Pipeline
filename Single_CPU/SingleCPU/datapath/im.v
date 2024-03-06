// 指令存储器模块

module im_4k (
    addr,dout
);

input[11:2] addr;
output[31:0] dout;

reg[31:0] im[0:1023];

initial begin
    $readmemh("code.txt",im);
    // $display("%h",im[0]);
end

assign dout=im[addr];

endmodule