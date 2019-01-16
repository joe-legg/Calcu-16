module alu (
    input [0:15] a,
    input [0:15] b,
    input [0:2] select,
    input enable,
    output [0:15] out,
    output carry
);
    reg [0:15] result;
    wire [0:16] tmp;

    assign tmp = {a, 1'b0} + {b, 1'b0};
    assign carry = tmp[16];
    assign out = result;

    always @(enable) begin
        case (select)
            3'b000:
                result <= a + b;
            3'b001:
                result <= a - b;
            3'b010:
                result <= a ^ b;
            3'b011:
                result <= a & b;
        endcase
    end
endmodule

// Testbench
// module alu_tb;
//     reg [0:15] A, B;
//     reg [0:2] select;
//     reg en;
//     wire [0:15] result;
//     wire carry;

//     alu alu1(
//         .a(A),
//         .b(B),
//         .select(select),
//         .enable(en),
//         .out(result),
//         .carry(carry) 
//     );

//     initial begin

//         $monitor("enable=%b a=%b b=%b \nselect=%b result=%b carry=%b\n\n",
//                 en, A, B, select, result, carry);
    
//         A = 2;
//         B = 2;
//         en = 1;
//         select = 0;
//         #5
//         en = 0;
//         en = 1;
//         select = 1;
//         #5
//         en = 0;
//         en = 1;
//         select = 2;
//         #5
//         en = 0;
//         en = 1;
//         select = 3;
//     end
// endmodule