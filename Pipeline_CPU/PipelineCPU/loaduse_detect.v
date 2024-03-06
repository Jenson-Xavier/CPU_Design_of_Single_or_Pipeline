module loaduse_detect (
    ID_Ex_MemRead,ID_Ex_rt,IF_ID_rs,IF_ID_rt,Branch_fc,
    Load_Use
);

input ID_Ex_MemRead;
input Branch_fc;
input[4:0] ID_Ex_rt,IF_ID_rs,IF_ID_rt;
output reg Load_Use;

initial begin
    Load_Use=0;
end

always @(*) begin
    if(ID_Ex_MemRead && (ID_Ex_rt==IF_ID_rs || ID_Ex_rt==IF_ID_rt) && Branch_fc==0)begin
        Load_Use<=1;
    end
    else begin
        Load_Use<=0;
    end 
end
    
endmodule