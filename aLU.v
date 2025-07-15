module execution_unit (
    input [3:0] opcode,        // Opcode
    input [15:0] src1,         // Source 1 data
    input [15:0] src2,         // Source 2 data
    input [15:0] immediate,    // Immediate value
    output reg [15:0] result,  // Result of the operation
    output reg zero_flag,      // Zero flag
    output reg carry_flag,     // Carry flag
    output reg div_done_flag   // Division done flag
);
    always @(*) begin
        // Default outputs
        result = 16'd0;
        zero_flag = 0;
        carry_flag = 0;
        div_done_flag = 0;

        case (opcode)
            4'b0000: {carry_flag, result} = src1 + src2; // Addition
            4'b0001: result = src1 - src2;               // Subtraction
            4'b0010: result = src1 * src2;               // Multiplication
            4'b0011: begin                               // Division
                if (src2 != 0) begin
                    result = src1 / src2;
                    div_done_flag = 1;
                end
            end
            4'b0100: result = src1 & src2;               // AND
            4'b0101: result = src1 | src2;               // OR
            4'b0110: result = src1 ^ src2;               // XOR
            4'b0111: result = ~src1;                     // NOT
            4'b1000: result = immediate;                 // Immediate load
        endcase

        // Set zero flag
        zero_flag = (result == 16'd0);
    end
endmodule
