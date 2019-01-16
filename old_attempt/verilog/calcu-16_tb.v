`define simulation_time #160

module calcu16_tb;
    reg clk;

    calcu16 processor (
        .clk(clk)
    );

    initial begin
        clk <= 1;
        `simulation_time;
        $finish;
    end

    always
        #5 clk = ~clk;

endmodule