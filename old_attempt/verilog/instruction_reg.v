module instructionReg (
    input [0:25] dataIn,
    input load,
    output [0:25] dataOut
);
    reg [0:25] register;
    assign dataOut = register;

    always @(posedge load)
        register <=dataIn;
endmodule

// Testbench
// module instructionReg_tb;
//     reg [0:25] dataIn;
//     reg load;
//     wire [0:25] dataOut;

//     instructionReg instructionReg1 (
//         .dataIn(dataIn),
//         .load(load),
//         .dataOut(dataOut)
//     );

//     initial begin
//         $monitor("dataIn = %b load = %b dataOut = %b", dataIn, load, dataOut);

//         dataIn = 4;
//         load = 0;
//         #5
//         load = 1;
//     end
// endmodule