module Adder_for_PCPlus4(
    input [31:0] pc_out,
    output [31:0] PCPlus4
);
    assign PCPlus4 = pc_out + 4;
endmodule
