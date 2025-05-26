module ALUDecoder(
    input [6:0] funct7,      // Corrected to 7 bits
    input [2:0] funct3,
    input [1:0] ALUop,
    output reg [2:0] ALUControl
);

    always @(*) begin
        case (ALUop)
            2'b00: ALUControl = 3'b000; // For load/store — ADD
            2'b01: ALUControl = 3'b001; // For branch — SUB
            2'b10: begin
                case ({funct7[5], funct3}) // Only use funct7[5] to differentiate ADD/SUB
                    4'b0_000: ALUControl = 3'b000; // ADD
                    4'b1_000: ALUControl = 3'b001; // SUB
                    4'b0_111: ALUControl = 3'b010; // AND
                    4'b0_110: ALUControl = 3'b011; // OR
                    4'b0_010: ALUControl = 3'b100; // SLT
                    default:  ALUControl = 3'b000; // Default to ADD
                endcase
            end
            default: ALUControl = 3'b000;
        endcase
    end

endmodule
