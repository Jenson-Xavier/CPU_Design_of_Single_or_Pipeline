module forward_detect (
    Ex_Mem_RegWr,
    Ex_Mem_rt,Ex_Mem_rd,Ex_Mem_RegDst,
    Mem_Wr_RegWr,
    Mem_Wr_rt,Mem_Wr_rd,Mem_Wr_RegDst,
    ID_Ex_rs,ID_Ex_rt,
    ALUSrc,
    ALUSrcA,ALUSrcB,DMSrc
);

input Ex_Mem_RegWr,Mem_Wr_RegWr;
input Ex_Mem_RegDst,Mem_Wr_RegDst;
input ALUSrc;
input[4:0] Ex_Mem_rt,Ex_Mem_rd,Mem_Wr_rt,Mem_Wr_rd;
input[4:0] ID_Ex_rs,ID_Ex_rt;
output reg[1:0] ALUSrcA,ALUSrcB,DMSrc;

reg[4:0] Ex_Mem_regRd,Mem_Wr_regRd;

initial begin
    ALUSrcA=0;
    ALUSrcB=0;
    DMSrc=0;
end

always @(*) begin
    if(Ex_Mem_RegDst)begin
        Ex_Mem_regRd=Ex_Mem_rd;
    end
    else begin
        Ex_Mem_regRd=Ex_Mem_rt;
    end
    if(Mem_Wr_RegDst)begin
        Mem_Wr_regRd=Mem_Wr_rd;
    end
    else begin
        Mem_Wr_regRd=Mem_Wr_rt;
    end

    if(Ex_Mem_RegWr && Ex_Mem_regRd!=0 && Ex_Mem_regRd==ID_Ex_rs)begin
        // C1A为真
        ALUSrcA=2'b01;
    end
    else if(Mem_Wr_RegWr && Mem_Wr_regRd!=0 && (Ex_Mem_RegWr==0 || Ex_Mem_regRd!=ID_Ex_rs) && Mem_Wr_regRd==ID_Ex_rs)begin
        // C2A为真
        ALUSrcA=2'b10;
    end
    else begin
        ALUSrcA=2'b00;
    end

    if(ALUSrc==1)begin
        ALUSrcB=2'b11;
        if(Ex_Mem_RegWr && Ex_Mem_regRd!=0 && Ex_Mem_regRd==ID_Ex_rt)begin
            DMSrc=2'b01;
        end
        else if(Mem_Wr_RegWr && Mem_Wr_regRd!=0 && Ex_Mem_regRd!=ID_Ex_rt && Mem_Wr_regRd==ID_Ex_rt)begin
            DMSrc=2'b10;
        end
        else begin
            DMSrc=2'b00;
        end
    end
    else begin
        if(Ex_Mem_RegWr && Ex_Mem_regRd!=0 && Ex_Mem_regRd==ID_Ex_rt)begin
            // C1B为真
            ALUSrcB=2'b01;
            DMSrc=2'b01;
        end
        else if(Mem_Wr_RegWr && Mem_Wr_regRd!=0 && Ex_Mem_regRd!=ID_Ex_rt && Mem_Wr_regRd==ID_Ex_rt)begin
            // C2B为真
            ALUSrcB=2'b10;
            DMSrc=2'b10;
        end
        else begin
            ALUSrcB=2'b00;
            DMSrc=2'b00;
        end
    end
end

endmodule