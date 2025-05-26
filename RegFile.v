module RegFile(
    input clk,
    input WE3,                         // Write Enable
    input [4:0] read_reg1,             // Address of first register to read
    input [4:0] read_reg2,             // Address of second register to read
    input [4:0] write_reg,             // Address of register to write
    input [31:0] WD3,                  // Data to write
    output reg [31:0] RD1,             // Data read from read_reg1
    output reg [31:0] RD2              // Data read from read_reg2
);

    reg [31:0] register_file[31:0];    // 32 general-purpose registers

    // Write operation (synchronous with clock)
    always @(posedge clk) begin
        if (WE3 && write_reg != 0)
            register_file[write_reg] <= WD3;
    end

    // Read operation (combinational logic)
    always @(*) begin
        RD1 = (read_reg1 != 0) ? register_file[read_reg1] : 32'b0;
        RD2 = (read_reg2 != 0) ? register_file[read_reg2] : 32'b0;
    end

endmodule
