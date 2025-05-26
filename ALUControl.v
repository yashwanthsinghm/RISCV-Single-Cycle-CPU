module ALUControl(
    input [6:0] op,
    input [2:0] funct3,
    input [6:0] funct7,      // Corrected width here
    input zero,
    output wire PCSrc,
    output wire jump,
    output wire ALUSrc,
    output wire RegWrite,
    output wire MemWrite,
    output wire branch,
    output wire [1:0] ImmSrc,
    output wire [2:0] ALUControl
);
    wire [1:0] ALUop;

    // Instantiate MainDecoder with named ports for clarity
    MainDecoder md (
        .op(op),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .Branch(branch),
        .ALUSrc(ALUSrc),
        .ALUop(ALUop),
        .ImmSrc(ImmSrc)
    );

    // Instantiate ALUDecoder
    ALUDecoder ad (
        .funct7(funct7),
        .funct3(funct3),
        .ALUop(ALUop),
        .ALUControl(ALUControl)
    );

    // jump signal currently not driven, so set it to zero (or implement your own logic)
    assign jump = 0;

    // PCSrc signal combines branch and jump
    assign PCSrc = (branch & zero) | jump;

endmodule
