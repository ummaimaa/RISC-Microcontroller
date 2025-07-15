`timescale 1ns / 1ps

module risc_microcontroller_tb;

    // Inputs
    reg clk;
    reg reset;
    reg [15:0] instruction;

    // Outputs
    wire [15:0] result;
    wire zero_flag;
    wire carry_flag;
    wire div_done_flag;

    // Instantiate the RISC Microcontroller
    risc_microcontroller uut (
        .clk(clk),
        .reset(reset),
        .instruction(instruction),
        .result(result),
        .zero_flag(zero_flag),
        .carry_flag(carry_flag),
        .div_done_flag(div_done_flag)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Testbench procedure
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        instruction = 16'b0;

        // Apply reset
        #10 reset = 0;

        // Test Immediate Addressing Mode: Load Immediate (opcode 1000)
        // Instruction format: [opcode (4)] [reg_dest (2)] [unused (2)] [immediate (8)]
        instruction = 16'b1000_00_00_00000010; // Load immediate 2 into R0
        #10;
        $display("Load Immediate: instruction=%b, result=%d, zero_flag=%b", instruction, result, zero_flag);

        // Test Addition (opcode 0000)
        // Instruction format: [opcode (4)] [reg_dest (2)] [reg_src1 (2)] [reg_src2 (2)]
        instruction = 16'b0000_01_00_00_000000; // R1 = R0 + R0
        #10;
        $display("Addition: instruction=%b, result=%d, zero_flag=%b, carry_flag=%b", instruction, result, zero_flag, carry_flag);

        // Test Subtraction (opcode 0001)
        instruction = 16'b0001_01_00_00_000000; // R1 = R0 - R0
        #10;
        $display("Subtraction: instruction=%b, result=%d, zero_flag=%b, carry_flag=%b", instruction, result, zero_flag, carry_flag);

        // Test Multiplication (opcode 0010)
        instruction = 16'b0010_10_00_01_000000; // R2 = R0 * R1
        #10;
        $display("Multiplication: instruction=%b, result=%d, zero_flag=%b", instruction, result, zero_flag);

        // Test Division (opcode 0011)
        instruction = 16'b0011_11_10_01_000000; // R3 = R2 / R1
        #10;
        $display("Division: instruction=%b, result=%d, zero_flag=%b, div_done_flag=%b", instruction, result, zero_flag, div_done_flag);

        // Test Division by Zero
        instruction = 16'b0011_11_10_00_000000; // R3 = R2 / 0
        #10;
        $display("Division by Zero: instruction=%b, result=%d, zero_flag=%b, div_done_flag=%b", instruction, result, zero_flag, div_done_flag);

        // Test Logical AND (opcode 0100)
        instruction = 16'b0100_11_00_01_000000; // R3 = R0 & R1
        #10;
        $display("Logical AND: instruction=%b, result=%b", instruction, result);

        // Test Logical OR (opcode 0101)
        instruction = 16'b0101_11_00_01_000000; // R3 = R0 | R1
        #10;
        $display("Logical OR: instruction=%b, result=%b", instruction, result);

        // Test Logical XOR (opcode 0110)
        instruction = 16'b0110_11_00_01_000000; // R3 = R0 ^ R1
        #10;
        $display("Logical XOR: instruction=%b, result=%b", instruction, result);

        // Test Ones Complement (opcode 0111)
        instruction = 16'b0111_11_00_00_000000; // R3 = ~R0
        #10;
        $display("Ones Complement: instruction=%b, result=%b", instruction, result);

        // Test Branching: Conditional Branch if Zero Flag (custom implementation needed)
        // Example: Check zero flag and perform branching operation

        // End of simulation
        #50 $finish;
    end
endmodule
