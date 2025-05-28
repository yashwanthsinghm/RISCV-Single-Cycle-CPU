module RISCV_SingleCycleCPU(
    input clock,
    input reset
);
    // Wires for instruction fields
    wire [31:0] instruction;
    wire [31:0] pc;
    wire zero_flag;
    wire [31:0] alu_result;
    wire [31:0] read_data;
    wire [31:0] write_data;

    // Control signals from ALUControl
    wire pc_src, jump, alu_src, reg_write;
    wire [1:0] mem_write;
    wire [1:0] result_src;
    wire [1:0] imm_src;
    wire [2:0] alu_control;

    // Instantiate Instruction Memory
    Instruction_Memory inst_mem (
        .address(pc),
        .instruction(instruction)
    );

    // Instantiate ALU Control unit (extracting fields from instruction)
    ALUControl alu_ctrl (
        .op(instruction[6:0]),
        .funct3(instruction[14:12]),
        .funct7(instruction[30]),
        .zero(zero_flag),
        .PCSrc(pc_src),
        .jump(jump),
        .ALUSrc(alu_src),
        .RegWrite(reg_write),
        .MemWrite(mem_write),
        .branch(),
        .ImmSrc(imm_src),
        .ALUControl(alu_control)
    );

    // Instantiate Data Path
    DataPath datapath (
        .clock(clock),
        .reset(reset),
        .pc_src(pc_src),
        .jump(jump),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .mem_write(mem_write),
        .result_src(result_src),
        .alu_control(alu_control),
        .imm_src(imm_src),
        .instruction(instruction),
        .zero_flag(zero_flag),
        .program_counter(pc),
        .write_data(write_data),
        .read_data(read_data),
        .alu_result(alu_result)
    );

    // Instantiate Data Memory
    DataMemory data_memory (
        .clock(clock),
        .write_enable(mem_write[0]),  // assuming mem_write[0] is write enable
        .address(alu_result),
        .write_data(write_data),
        .read_data(read_data)
    );

endmodule
