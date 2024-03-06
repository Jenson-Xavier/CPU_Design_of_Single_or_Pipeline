module pc (
    in_pc,clk,reset,out_pc,
    Load_Use
);

input[31:0] in_pc;
input clk,reset;
input Load_Use;
output reg[31:0] out_pc;

initial begin
    out_pc=32'h00003000;  // 0x00003000
end

always @(posedge clk) begin
    if(Load_Use!=1)begin
        out_pc=in_pc;
    end
    if(reset)
        out_pc=32'h00003000;   // 0x00003000
end
    
endmodule