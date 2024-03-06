module pc2addr (
    out_pc,addr
);

input[31:0] out_pc;
output[11:2] addr;

wire[31:0] temp_pc;

assign temp_pc=out_pc-32'h00003000;
assign addr=temp_pc[11:2];

endmodule