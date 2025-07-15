module control_unit (
    input clk,               // Clock signal
    input reset,             // Reset signal
    input [3:0] opcode,      // Opcode
    output reg write_enable  // Write enable signal
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            write_enable <= 0;
        end else begin
            // Enable writing for certain operations
            write_enable <= (opcode != 4'b0011); // Disable write for division, modify as needed
        end
    end
endmodule
