module microcontroller(
    input clk,              // Clock input
    input rst,              // Reset input
    input [3:0] A,          // ALU input A
    input [3:0] B,          // ALU input B
    input [1:0] opcode,     // ALU operation code
    input [3:0] ram_addr,   // Memory address
    input [3:0] ram_din,    // Memory data input
    input ram_we,           // RAM write enable
    output [3:0] alu_result, // ALU result output
    output [3:0] ram_dout,  // Memory data output
    output [3:0] count      // Counter output
);

    // Instantiate ALU
    alu alu_inst (
        .A(A),
        .B(B),
        .opcode(opcode),
        .result(alu_result)
    );

    // Instantiate RAM (Memory)
    ram memory_inst (
        .clk(clk),
        .addr(ram_addr),
        .din(ram_din),
        .we(ram_we),
        .dout(ram_dout)
    );

    // Instantiate Counter
    counter counter_inst (
        .clk(clk),
        .rst(rst),
        .count(count)
    );

endmodule

// ALU Module
module alu(
    input [3:0] A, B,
    input [1:0] opcode,
    output reg [3:0] result
);
    always @(*) begin
        case (opcode)
            2'b00: result = A + B;     // Addition
            2'b01: result = A - B;     // Subtraction
            2'b10: result = A & B;     // Bitwise AND
            2'b11: result = A | B;     // Bitwise OR
            default: result = 4'b0000; // Default case
        endcase
    end
endmodule

// RAM Module
module ram(
    input clk,
    input [3:0] addr,
    input [3:0] din,
    input we,
    output reg [3:0] dout
);
    reg [3:0] memory [0:15]; // 16 x 4-bit memory
    always @(posedge clk) begin
        if (we) memory[addr] <= din;  // Write to memory
        dout <= memory[addr];        // Read from memory
    end
endmodule

// Counter Module
module counter(
    input clk,
    input rst,
    output reg [3:0] count
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= 4'b0000; // Reset counter
        else
            count <= count + 1; // Increment counter
    end
endmodule
