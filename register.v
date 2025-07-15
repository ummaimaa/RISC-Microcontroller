module register_file (
    input clk,                  // Clock signal
    input reset,                // Reset signal
    input [1:0] reg_dest,       // Destination register index
    input [1:0] reg_src1,       // Source register 1 index
    input [1:0] reg_src2,       // Source register 2 index
    input [15:0] write_data,    // Data to write to destination register
    input write_enable,         // Write enable signal
    output [15:0] data_src1,    // Data output from source register 1
    output [15:0] data_src2     // Data output from source register 2
);
    reg [15:0] registers [3:0]; // 4 general-purpose registers (R0-R3)

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            registers[0] <= 16'd0;
            registers[1] <= 16'd0;
            registers[2] <= 16'd0;
            registers[3] <= 16'd0;
        end else if (write_enable) begin
            registers[reg_dest] <= write_data;
        end
    end

    assign data_src1 = registers[reg_src1];
    assign data_src2 = registers[reg_src2];
endmodule
