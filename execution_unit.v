module execution_unit (
    input [3:0] opcode,        // Operation code
    input [15:0] src1,         // First operand
    input [15:0] src2,         // Second operand
    input [15:0] immediate,    // Immediate value
    output [15:0] result,      // Result of operation
    output zero_flag,          // Zero flag
    output carry_flag,         // Carry flag
    output div_done_flag       // Division done flag
);
    wire carry_out;            // Intermediate carry flag

    // Instantiate ALU
    alu alu_instance (
        .opcode(opcode),
        .src1(src1),
        .src2(src2),
        .immediate(immediate),
        .result(result),
        .carry_out(carry_out)
    );

    // Instantiate Flag Control Unit
    flag_control_unit flag_unit (
        .result(result),
        .carry_out(carry_out),
        .opcode(opcode),
        .src2(src2),
        .zero_flag(zero_flag),
        .carry_flag(carry_flag),
        .div_done_flag(div_done_flag)
    );
endmodule
