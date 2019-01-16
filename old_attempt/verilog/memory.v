module memory (
    input load,
    input [0:25] dataIn,
    input [0:15] address,
    output reg [0:25] dataOut
);
    reg [0:25] memoryArray [0:65535];

    initial // Load program
        $readmemb("program.bin", memoryArray, 0, 0);

    always @(*) begin
        if (load)
            memoryArray[address] <= dataIn;

        dataOut <= memoryArray[address];
    end
endmodule