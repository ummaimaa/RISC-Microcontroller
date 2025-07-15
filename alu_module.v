module alu (
    input [3:0] opcode,        // Operation code
    input [15:0] src1,         // First operand
    input [15:0] src2,         // Second operand
    input [15:0] immediate,    // Immediate value
    output reg [15:0] result,  // Result of operation
    output reg carry_out       // Carry flag for addition/subtraction
);
    always @(*) begin
        carry_out = 0; // Default carry flag to 0
        case (opcode)
            4'b0000: result = src1 + src2;                      // Addition
            4'b0001: {carry_out, result} = src1 - src2;         // Subtraction
            4'b0010: result = src1 * src2;                      // Multiplication
            4'b0011: result = (src2 != 0) ? (src1 / src2) : 0;  // Division (avoid divide-by-zero)
            4'b0100: result = src1 & src2;                      // AND
            4'b0101: result = src1 | src2;                      // OR
            4'b0110: result = src1 ^ src2;                      // XOR
            4'b0111: result = ~src1;                            // Ones Complement
            4'b1000: result = immediate;                       // Immediate Load
            default: result = 16'b0;                            // Default
        endcase
    end
endmodule
