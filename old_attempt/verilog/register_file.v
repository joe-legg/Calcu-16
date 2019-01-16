module regFile (
    input [0:2] sel1,       // Select for dataOut1
    input [0:2] sel2,       // Select for dataOut2
    input [0:2] dataSel,    // Select for register to write to
    input [0:15] dataIn,    // Data in
    input load,             // Enable output
    output [0:15] dataOut1, // Data output for sel1
    output [0:15] dataOut2  // Data output for sel2
);
    reg [0:15] regArray [0:7];
    integer i;

    initial begin
        $dumpvars(0, regFile);
        for (i = 0; i < 8; i = i + 1)
            regArray[i] <= 0;

        $monitor("r0 = %b\nr1 = %b\nr2 = %b\nr3 = %b\nr4 = %b\nr5 = %b\nr6 = %b\nr7 = %b\n\n",
                regArray[0], regArray[1], regArray[2], regArray[3], regArray[4], regArray[5],
                regArray[6], regArray[7]);
    end

    assign dataOut1 = regArray[sel1];
    assign dataOut2 = regArray[sel2];

    always @(posedge load)
        regArray[dataSel] <= dataIn;

endmodule

// Tesbench
// module registerFile_tb;
//     reg [0:2] sel1, sel2, dataSel;
//     reg [0:15] dataIn;
//     reg load;

//     wire [0:15] dataOut1, dataOut2;

//     regFile regFile1 (
//         .sel1(sel1),
//         .sel2(sel2),
//         .dataSel(dataSel),
//         .dataIn(dataIn),
//         .load(load),
//         .dataOut1(dataOut1),
//         .dataOut2(dataOut2)
//     );

//     initial begin
//         $monitor("sel1 = %b sel2 = %b dataSel = %b\ndataIn = %b load = %b\n\ndataOut1 = %b dataOut2 = %b\n",
//                 sel1, sel2, dataSel, dataIn, load, dataOut1, dataOut2);
//         sel1 = 1;
//         dataSel = 1;
//         dataIn = 3;
//         load = 1;
//     end
// endmodule