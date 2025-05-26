module Extend(
    input [31:0] instruction,      // Full 32-bit instruction
    input [1:0] ImmSrc,            // Immediate source type selector
    output reg [31:0] ImmExt       // Sign-extended immediate value
);

    always @(*) begin
        case (ImmSrc)
            2'b00: begin
                // I-type: imm[11:0] = instruction[31:20]
                ImmExt = {{20{instruction[31]}}, instruction[31:20]};
            end
            2'b01: begin
                // S-type: imm[11:5]=inst[31:25], imm[4:0]=inst[11:7]
                ImmExt = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            end
            2'b10: begin
                // B-type: imm[12|10:5|4:1|11|0] = instruction[31|30:25|11:8|7|0]
                ImmExt = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
            end
            2'b11: begin
                // J-type: imm[20|10:1|11|19:12|0] = instruction[31|30:21|20|19:12|0]
                ImmExt = {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};
            end
            default: ImmExt = 32'b0;
        endcase
    end

endmodule
