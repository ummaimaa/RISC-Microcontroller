module flag_control_unit (
    input [15:0] result,       // Result from ALU
    input carry_out,           // Carry flag from ALU
    input [3:0] opcode,        // Operation code
    input [15:0] src2,         // Second operand (for division)
    output reg zero_flag,      // Zero flag
    output reg carry_flag,     // Carry flag
    output reg div_done_flag   // Division done flag
);
    always @(*) begin
        zero_flag = (result == 16'b0); // Set if the result is zero
        carry_flag = carry_out;       // Reflect carry from ALU
        div_done_flag = (opcode == 4'b0011) && (src2 != 0); // Division done if opcode is divide and src2 is non-zero
    end
endmodule
