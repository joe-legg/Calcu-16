module calcu16 (
    input clk
);
    wire [0:25] instruction, memDataOut;
    wire aluCarry, aluEnable, regLoad, instrLoad, pcClk;
    wire [0:2] aluSel, regSel1, regSel2, regSelData;
    wire [0:15] aluOut, regDataOut1, regDataOut2, aluA, aluB, regDataIn, address;

    controlUnit ctrlUnit (
        .clk(clk),
        .aluCarry(aluCarry),
        .instruction(instruction),
        .aluOut(aluOut),
        .regDataOut1(regDataOut1),
        .regDataOut2(regDataOut2),
        .aluEnable(aluEnable),
        .regLoad(regLoad),
        .instrLoad(instrLoad),
        .pcClk(pcClk),
        .aluSel(aluSel),
        .regSel1(regSel1),
        .regSel2(regSel2),
        .regSelData(regSelData),
        .aluA(aluA),
        .aluB(aluB),
        .regDataIn(regDataIn)
    );
    
    regFile registerFile (
        .sel1(regSel1),
        .sel2(regSel2),
        .dataSel(regSelData),
        .dataIn(regDataIn),
        .load(regLoad),
        .dataOut1(regDataOut1),
        .dataOut2(regDataOut2)
    );

    memory RAM (
        .load(),
        .dataIn(),
        .address(address),
        .dataOut(memDataOut)
    );
    
    alu ALU (
        .a(aluA),
        .b(aluB),
        .select(aluSel),
        .enable(aluEnable),
        .out(aluOut),
        .carry(aluCarry)
    );

    programCounter PC (
        .data(),
        .load(),
        .clk(pcClk),
        .count(address)
    );
    
    instructionReg IR (
        .dataIn(memDataOut),
        .load(instrLoad),
        .dataOut(instruction)
    );
endmodule