module im_4k (
    addr,dout
);

input[11:2] addr;
output[31:0] dout;

reg[31:0] im[0:1023];

initial begin
    $readmemh("code.txt",im);
    // $readmemh("code1.txt",im);
    // $readmemh("code2.txt",im);
    // $readmemh("code3.txt",im);
    // $readmemh("code4.txt",im);
    // $readmemh("code5.txt",im);
    // $readmemh("code6.txt",im);
end

assign dout=im[addr];

endmodule