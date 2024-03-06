// PC模块

module pc (
    in_pc,clk,reset,out_pc
);

input[31:0] in_pc;
input clk,reset;
output reg[31:0] out_pc;

initial begin
    out_pc=32'h00003000;  // 0x00003000
end

always @(posedge clk) begin
    out_pc=in_pc;
    if(reset)
        out_pc=32'h00003000;   // 0x00003000
end
    
endmodule