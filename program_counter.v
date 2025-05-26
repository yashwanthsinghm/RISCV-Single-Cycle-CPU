module program_counter(
    input clk,
    input reset,
    input [31:0] pc_in,       // Next PC value
    output reg [31:0] pc_out  // Current PC
);
    always @(posedge clk) begin
        if (reset)
            pc_out <= 32'b0;   // Reset to 0 or desired start address
        else
            pc_out <= pc_in;   // Load new PC from mux output
    end
endmodule
