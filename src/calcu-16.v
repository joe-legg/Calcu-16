module calcu16 (
    input clk
);
    // Registers
    reg [0:15] regArray [0:7]; // General Purpose
    reg [0:15] pc = 0; // Program counter
    reg [0:25] ir; // Instruction register

    // Memory
    reg [0:25] memory [0:65535];

    reg [0:3] opcode;
    reg [0:2] regSel1;
    reg [0:2] regSel2;
    reg [0:2] regSel3;
    reg [0:15] immediate;

    reg [0:16] tmp;

    integer i;

    initial begin
        // Set the registers values to 0
        for (i = 0; i < 8; i = i + 1)
            regArray[i] <= 0;
        
        $readmemb("program.bin", memory); // Load program
        
        // Uncomment for debugging
        // $dumpvars(7, regArray[0], regArray[1], regArray[2], regArray[3], regArray[4], regArray[5],
        //        regArray[6], regArray[7]);

        // $monitor("r0 = %b\nr1 = %b\nr2 = %b\nr3 = %b\nr4 = %b\nr5 = %b\nr6 = %b\nr7 = %b\n\n",
        //       regArray[0], regArray[1], regArray[2], regArray[3], regArray[4], regArray[5],
        //       regArray[6], regArray[7]);
    end

    always @(posedge clk) begin
        ir = memory[pc];

        opcode = ir[0:3];
        regSel1 = ir[4:6];
        regSel2 = ir[7:9];
        regSel3 = ir[10:12];
        immediate = ir[10:25];

        pc = pc + 1;
        
        case (opcode)
            4'b0001: // ADD
                regArray[regSel1] = regArray[regSel2] + regArray[regSel3];
            4'b0010: // ADDI
                regArray[regSel1] = regArray[regSel2] + immediate;
            4'b0011: // JMP
                pc = immediate;
            4'b0100: // JEQ
                pc = (regArray[regSel1] == regArray[regSel2]) ? immediate : pc;
            4'b0101: // STORE
                memory[immediate + regArray[regSel2]] = regArray[regSel1];
            4'b0110: // LOAD
                regArray[regSel1] = memory[immediate + regArray[regSel2]];
            4'b0111: // XOR
                regArray[regSel1] = regArray[regSel2] ^ regArray[regSel3];
            4'b1000: // AND
                regArray[regSel1] = regArray[regSel2] & regArray[regSel3];
        endcase
    end

endmodule
