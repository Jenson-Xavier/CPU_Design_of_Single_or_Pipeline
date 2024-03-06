module alu_in1_mux (
    busA,Result,mem_result,ALUSrcA,
    in1
);

input[31:0] busA,Result,mem_result;
input[1:0] ALUSrcA;
output reg[31:0] in1;

initial begin
    in1=0;
end

always @(*) begin
    if(ALUSrcA==2'b00)begin
        in1=busA;
    end
    else if(ALUSrcA==2'b01)begin
        in1=Result;
    end
    else if(ALUSrcA==2'b10)begin
        in1=mem_result;
    end
end
endmodule

module alu_in2_mux (
    busB,Result,mem_result,imm32,ALUSrcB,
    in2
);

input[31:0] busB,Result,mem_result,imm32;
input[1:0] ALUSrcB;
output reg[31:0] in2;

initial begin
    in2=0;
end

always @(*) begin
    if(ALUSrcB==2'b00)begin
        in2=busB;
    end
    else if(ALUSrcB==2'b01)begin
        in2=Result;
    end
    else if(ALUSrcB==2'b10)begin
        in2=mem_result;
    end
    else if(ALUSrcB==2'b11)begin
        in2=imm32;
    end
end

endmodule