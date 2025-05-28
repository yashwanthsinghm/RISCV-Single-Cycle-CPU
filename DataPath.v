module DataPath(
    input clock,
    input reset,
    input pc_src,
    input jump,
    input alu_src,
    input reg_write,
    input [1:0] mem_write,
    input [1:0] result_src,
    input [2:0] alu_control,
    input [1:0] imm_src,
    input [31:0] instruction,
    output zero_flag,
    output [31:0] program_counter,
    output [31:0] write_data,
    output [31:0] read_data,
    output [31:0] alu_result
);

    // Internal wires
    wire [31:0] pc_next;
    wire [31:0] pc_plus_4;
    wire [31:0] imm_extended;
    wire [31:0] pc_target;
    wire [31:0] alu_src_a;
    wire [31:0] alu_src_b;
    wire [31:0] mux_result;

    // Program Counter Logic
    program_counter pc_inst (
        .clk(clock),
        .reset(reset),
        .pc_in(pc_next),
        .pc_out(program_counter)
    );

    Adder_for_PCPlus4 pc_plus_4_adder (
        .pc_out(program_counter),
        .PCPlus4(pc_plus_4)
    );

    Adder_for_PCTarget pc_target_adder (
        .pc_out(program_counter),
        .ImmExt(imm_extended),
        .PCTarget(pc_target)
    );

    MUX_for_PCSrc pc_src_mux (
        .PCPlus4(pc_plus_4),
        .PCTarget(pc_target),
        .PCSrc(pc_src),
        .PCNext(pc_next)
    );

    // Register File
    RegFile register_file (
        .WE3(reg_write),
        .clk(clock),
        .read_reg1(instruction[19:15]),   // rs1
        .read_reg2(instruction[24:20]),   // rs2
        .write_reg(instruction[11:7]),    // rd
        .WD3(mux_result),          // data to write
        .RD1(alu_src_a),
        .RD2(write_data)
    );

    // Immediate Extension
    Extend immediate_extender (
        .instruction(instruction[31:7]),
        .ImmSrc(imm_src),
        .ImmExt(imm_extended)
    );

    // ALU Source MUX (select between register or immediate)
    MUX_for_ALUSrc alu_src_mux (
        .RD2(write_data),
        .ImmExt(imm_extended),
        .ALUSrc(alu_src),
        .SrcB(alu_src_b)
    );

    // ALU
    ALU alu_inst (
        .SrcA(alu_src_a),
        .SrcB(alu_src_b),
        .ALUControl(alu_control),
        .zero(zero_flag),
        .ALUResult(alu_result)
    );

    // Data Memory
    DataMemory data_memory (
        .clock(clock),
        .write_enable(mem_write),
        .address(alu_result),
        .write_data(write_data),
        .read_data(read_data)
    );

    // Result Source MUX (select data from ALU, Memory or PC+4)
    ResultSourceMux result_src_mux (
        .alu_result(alu_result),
        .memory_data(read_data),
        .pc_plus_4(pc_plus_4),
        .result_select(result_src),
        .final_result(mux_result)
    );

endmodule

