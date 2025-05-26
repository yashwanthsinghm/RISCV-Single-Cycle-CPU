module Adder_for_PCTarget(
    input [31:0] pc_out,
    input [31:0] ImmExt,     // Extended immediate (e.g., for branch offset)
    output [31:0] PCTarget
);
    assign PCTarget = pc_out + ImmExt;
endmodule
