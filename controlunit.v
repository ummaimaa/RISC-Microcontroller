module ControlUnit(
    input [2:0] flags,             // Flags (Zero, Carry, Div Done)
    input [15:0] instruction,      // 16-bit instruction
    input clk, reset,
    output reg branch_enable,      // Branch enable signal
    output reg [15:0] branch_addr  // Branch address
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            branch_enable <= 0;
            branch_addr <= 16'b0;
        end else if (instruction[15:12] == 4'b1000) begin // Conditional branch
            case (instruction[11:9])
                3'b000: branch_enable <= flags[0]; // Zero flag
                3'b001: branch_enable <= flags[1]; // Carry flag
                3'b010: branch_enable <= flags[2]; // Div Done flag
                default: branch_enable <= 0;
            endcase
            branch_addr <= instruction[8:0];
        end else if (instruction[15:12] == 4'b1001) begin // Unconditional branch
            branch_enable <= 1;
            branch_addr <= instruction[11:0];
        end else begin
            branch_enable <= 0;
        end
    end
endmodule
