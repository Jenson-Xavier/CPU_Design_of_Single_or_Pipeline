`timescale 1ns/1ns
`include "mips.v"

module testmips;

reg clk,reset;

mips example(clk,reset);

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
    reset=0;
end

always begin
    clk=0;#5;
    clk=1;#5;
    if($time>=1000)$finish;
end
    
endmodule