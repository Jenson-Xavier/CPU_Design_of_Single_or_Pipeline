module MEM_WRseg (
    clk,pc_in,Result_in,rt_in,rd_in,
    RegDst_in,MemtoReg_in,RegWr_in,ExtopM_in,IsLink_in,IsByteW_in,
    dm_read_in,
    pc_out,Result_out,rt_out,rd_out,
    RegDst_out,MemtoReg_out,RegWr_out,ExtopM_out,IsLink_out,IsByteW_out,
    dm_read_out
);

input clk;
input RegDst_in,MemtoReg_in,RegWr_in,ExtopM_in,IsLink_in,IsByteW_in;
input[4:0] rt_in,rd_in;
input[31:0] pc_in,Result_in;
input[31:0] dm_read_in;
output reg RegDst_out,MemtoReg_out,RegWr_out,ExtopM_out,IsLink_out,IsByteW_out;
output reg[4:0] rt_out,rd_out;
output reg[31:0] pc_out,Result_out;
output reg[31:0] dm_read_out;

always @(negedge clk) begin
    pc_out<=pc_in;
    rt_out<=rt_in;
    rd_out<=rd_in;
    Result_out<=Result_in;
    RegDst_out<=RegDst_in;
    MemtoReg_out<=MemtoReg_in;
    RegWr_out<=RegWr_in;
    ExtopM_out<=ExtopM_in;
    IsLink_out<=IsLink_in;
    IsByteW_out<=IsByteW_in;
    dm_read_out<= dm_read_in;
end

endmodule