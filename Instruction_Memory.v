module Instruction_Memory(
    input [31:0] address,        // Word-aligned address input
    output reg [31:0] instruction // Instruction output
);
    // 64-word (256-byte) instruction memory (ROM)
    reg [31:0] mem[63:0];

    // Initialize with instructions (for simulation)
    initial begin
        mem[0] = 32'h00500093;  // li x1, 5
        mem[1] = 32'h00A00113;  // li x2, 10
        mem[2] = 32'h002081B3;  // add x3, x1, x2
        mem[3] = 32'h00300023;  // sw x3, 0(x0)
    end

    // Combinational read
    always @(*) begin
        if (address[31:2] < 64)
            instruction = mem[address[31:2]];
        else
            instruction = 32'h00000013; // NOP
    end
endmodule
