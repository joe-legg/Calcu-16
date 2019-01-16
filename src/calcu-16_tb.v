`timescale 1ns / 1ps 

module calcu16_tb;
    reg clk;

    calcu16 processor(.clk(clk));

    initial begin
        $dumpfile("dump.vcd");
        clk <= 1;
        
        // Uncomment for debugging
        $dumpvars(0, processor);

        // #40 // Simulation time
        // $finish;
    end

    always
        #1 clk = ~clk;
endmodule
