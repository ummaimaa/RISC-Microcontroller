module risc_microcontroller (
    input clk,                 // Clock signal
    input reset,               // Reset signal
    input [15:0] instruction,  // 16-bit instruction input
    output [15:0] result,      // Output of the execution unit
    output zero_flag,          // Zero flag
    output carry_flag,         // Carry flag
    output div_done_flag       // Division done flag
);

    // Internal signals
    wire [3:0] opcode;            // Opcode extracted from the instruction
    wire [1:0] reg_dest;          // Destination register index
    wire [1:0] reg_src1;          // Source register 1 index
    wire [1:0] reg_src2;          // Source register 2 index
    wire [15:0] immediate;        // Immediate value extracted from the instruction
    wire [15:0] reg_data1;        // Data from source register 1
    wire [15:0] reg_data2;        // Data from source register 2
    wire write_enable;            // Write enable signal for the register file

    // Instantiate the Instruction Decoder
    instruction_decoder decoder (
        .instruction(instruction),  // 16-bit instruction
        .opcode(opcode),            // Extracted opcode
        .reg_dest(reg_dest),        // Destination register index
        .reg_src1(reg_src1),        // Source register 1 index
        .reg_src2(reg_src2),        // Source register 2 index
        .immediate(immediate)       // Immediate value
    );

    // Instantiate the Register File
    register_file registers (
        .clk(clk),                  // Clock signal
        .reset(reset),              // Reset signal
        .reg_dest(reg_dest),        // Destination register index
        .reg_src1(reg_src1),        // Source register 1 index
        .reg_src2(reg_src2),        // Source register 2 index
        .write_data(result),        // Data to write back to destination register
        .write_enable(write_enable),// Write enable signal
        .data_src1(reg_data1),      // Data output from source register 1
        .data_src2(reg_data2)       // Data output from source register 2
    );

    // Instantiate the Execution Unit
    execution_unit exec_unit (
        .opcode(opcode),            // Opcode
        .src1(reg_data1),           // Data from source register 1
        .src2(reg_data2),           // Data from source register 2
        .immediate(immediate),      // Immediate value
        .result(result),            // Result output
        .zero_flag(zero_flag),      // Zero flag output
        .carry_flag(carry_flag),    // Carry flag output
        .div_done_flag(div_done_flag) // Division done flag output
    );

    // Instantiate the Control Unit
    control_unit control (
        .clk(clk),                  // Clock signal
        .reset(reset),              // Reset signal
        .opcode(opcode),            // Opcode
        .write_enable(write_enable) // Write enable signal
    );

endmodule
