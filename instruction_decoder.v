module instruction_decoder (
    input [15:0] instruction,     // 16-bit instruction input
    output [3:0] opcode,          // Opcode
    output [1:0] reg_dest,        // Destination register index
    output [1:0] reg_src1,        // Source register 1 index
    output [1:0] reg_src2,        // Source register 2 index
    output [15:0] immediate       // Immediate value
);
    assign opcode = instruction[15:12];
    assign reg_dest = instruction[11:10];
    assign reg_src1 = instruction[9:8];
    assign reg_src2 = instruction[7:6];
    assign immediate = {8'd0, instruction[7:0]}; // Zero-extend the immediate value
endmodule
