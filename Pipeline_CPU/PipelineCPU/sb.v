module sb (
    dm_addr,busB,dm_read,dm_write,
    IsByteB
);

input IsByteB;
input[31:0] dm_addr;
input[31:0] busB,dm_read;
output reg[31:0] dm_write;

integer j;

initial begin
    dm_write=0;
    j=0;    
end

always @(*) begin
    if(IsByteB)begin
        j=dm_addr%4;
        if(j==0)begin
            dm_write<={dm_read[31:8],busB[7:0]};
        end
        else if(j==1)begin
            dm_write<={dm_read[31:16],busB[7:0],dm_read[7:0]};
        end
        else if(j==2)begin
            dm_write<={dm_read[31:24],busB[7:0],dm_read[15:0]};
        end
        else begin
            dm_write<={busB[7:0],dm_read[23:0]};
        end
    end
    else begin
        dm_write<=busB;
    end
end

endmodule