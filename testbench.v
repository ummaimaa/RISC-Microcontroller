`timescale 1ns / 1ps

module tb_microcontroller;
    reg clk;                // Clock signal
    reg rst;                // Reset signal
    reg [3:0] A, B;         // ALU inputs
    reg [1:0] opcode;       // ALU opcode
    reg [3:0] ram_addr;     // RAM address
    reg [3:0] ram_din;      // RAM data input
    reg ram_we;             // RAM write enable
    wire [3:0] alu_result;  // ALU result
    wire [3:0] ram_dout;    // RAM data output
    wire [3:0] count;       // Counter output

    // Instantiate the microcontroller
    microcontroller uut (
        .clk(clk),
        .rst(rst),
        .A(A),
        .B(B),
        .opcode(opcode),
        .ram_addr(ram_addr),
        .ram_din(ram_din),
        .ram_we(ram_we),
        .alu_result(alu_result),
        .ram_dout(ram_dout),
        .count(count)
    );

    // Clock generation
    always #5 clk = ~clk; // Clock period: 10 ns

    // Testbench stimulus
    initial begin
        clk = 0; rst = 1; // Initialize signals
        A = 4'b0000; B = 4'b0000; opcode = 2'b00;
        ram_addr = 4'b0000; ram_din = 4'b0000; ram_we = 0;

        #10 rst = 0; // Release reset

        // Test ALU
        #10 A = 4'b0101; B = 4'b0011; opcode = 2'b00; // Addition
        #10 opcode = 2'b01;                           // Subtraction
        #10 opcode = 2'b10;                           // AND
        #10 opcode = 2'b11;                           // OR

        // Test RAM
        #10 ram_addr = 4'b0001; ram_din = 4'b1010; ram_we = 1; // Write to RAM
        #10 ram_we = 0;                                       // Read from RAM

        // Test Counter
        #10 rst = 1; #10 rst = 0; // Reset counter

        #50 $finish; // End simulation
    end
endmodule
