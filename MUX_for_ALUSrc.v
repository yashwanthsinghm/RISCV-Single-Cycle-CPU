module MUX_for_ALUSrc(
    input [31:0] RD2,         // Data from register file
    input [31:0] ImmExt,      // Sign-extended immediate
    input ALUSrc,             // Control signal: 0 = RD2, 1 = ImmExt
    output [31:0] SrcB        // Selected input for ALU's B operand
);
    assign SrcB = ALUSrc ? ImmExt : RD2;
endmodule
