module MUX_for_PCSrc(
    input [31:0] PCPlus4,   // Next sequential PC
    input [31:0] PCTarget,  // Branch/jump target PC
    input PCSrc,            // Select signal: 0 = PC+4, 1 = PCTarget
    output [31:0] PCNext    // Final PC value to be loaded
);
    assign PCNext = PCSrc ? PCTarget : PCPlus4;
endmodule
