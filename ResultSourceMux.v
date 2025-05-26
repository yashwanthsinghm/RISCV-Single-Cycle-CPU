module ResultSourceMux(
    input [31:0] alu_result,      // Result from ALU
    input [31:0] memory_data,     // Data read from memory (RD)
    input [31:0] pc_plus_4,       // PC + 4 value
    input [1:0] result_select,    // Control signal to select source
    output reg [31:0] final_result // Selected output result
);
    always @(*) begin
        case (result_select)
            2'b00: final_result = alu_result;    // Select ALU result
            2'b01: final_result = memory_data;   // Select memory read data
            2'b10: final_result = pc_plus_4;     // Select PC + 4
            default: final_result = 32'b0;       // Default to zero
        endcase
    end
endmodule
