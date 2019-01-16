module programCounter (
    input [0:15] data,
    input load, clk, reset,
    output [0:15] count
);
    reg [0:15] counterReg;
    assign count = counterReg;

    initial
        counterReg <= 0;

    always @(posedge clk or posedge reset) begin
        if(reset)
            counterReg <= 16'd0;
        else
            if (load)
                counterReg <= data;
            else
                counterReg <= counterReg + 16'd1;
    end
endmodule

// Testbench
// module programCounter_tb;
//     reg load, clk, reset;
//     reg [0:15] data;
//     wire [0:15] counter;

//     programCounter programCounter_1(
//         .data(data),
//         .load(load),
//         .clk(clk),
//         .reset(reset),
//         .counter(counter)
//     );

//     initial begin
//         $monitor("counter = %b\n", counter);
//         data = 0;
//         load = 0;
//         reset = 1;
//         #5
//         reset = 0;
//         clk = 0;
//         forever #5 clk = !clk;
//     end
// endmodule