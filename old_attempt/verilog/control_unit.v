module controlUnit (
    input clk,
    input aluCarry,
    input [0:25] instruction,
    input [0:15] aluOut, regDataOut1, regDataOut2,
    output reg aluEnable, regLoad, instrLoad, pcClk,
    output reg [0:2] aluSel, regSel1, regSel2, regSelData,
    output reg [0:15] aluA, aluB, regDataIn
);
    reg [0:1] cycle;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1, controlUnit, calcu16);
        cycle <= 0;
    end

    always @(posedge clk) begin
        case (cycle)
            2'b00: begin // Cycle 0
                // Load the instruction register with the instr stored in ram
                instrLoad <= 1;
                end
            2'b01: begin // Cycle 1
                instrLoad <= 0;
                pcClk <= 1; // Increment the program counter
                case (instruction[0:3])
                    4'b0001: begin // ADD
                        regSel1 <= instruction[7:9];
                        regSel2 <= instruction[10:12];
                        aluA <= regDataOut1;
                        aluB <= regDataOut2;
                        aluSel <= 0;
                        aluEnable <= 1;
                        regSelData <= instruction[4:6];
                        regDataIn <= aluOut;
                    end
                    4'b0010: begin // ADDI
                        regSel1 <= instruction[7:9];
                        aluB <= instruction[10:25];
                        aluA <= regDataOut1[0:15];
                        aluSel <= 0;
                        aluEnable <= 1;
                        regSelData <= instruction[4:6];
                        regDataIn <= aluOut;
                    end
                endcase

                end
            2'b10: begin // Cycle 2
                pcClk <= 0; // Reset pc clk
                case (instruction[0:3])
                    4'b0001: begin // ADD
                        regLoad <= 1;
                    end
                    4'b0010: begin // ADDI
                        regLoad <= 1;
                    end
                endcase
            end
            2'b11: begin // Cycle 3
                case (instruction[0:3])
                    4'b0001: begin // ADD
                        regLoad <= 0;
                        aluEnable <= 0;
                    end
                    4'b0010: begin // ADDI
                        regLoad <= 0;
                        aluEnable <= 0;
                    end
                endcase
            end
        endcase
        cycle <= cycle + 1;

    end
endmodule