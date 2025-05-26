

# RISC-V Single-Cycle CPU

## Overview
This project implements a single-cycle RISC-V CPU in Verilog. The design covers the core components of a basic RISC-V processor including instruction memory, data memory, register file, ALU, control units, and the datapath. It supports a subset of RISC-V instructions such as load/store, arithmetic, and branch operations.

The CPU executes one instruction per clock cycle, making it a good educational model for understanding processor architecture and datapath control.

## Features
- RISC-V RV32I subset instruction support:

- Arithmetic instructions (ADD, SUB, AND, OR, SLT)

- Load and store instructions

- Branch instructions (BEQ)

- Immediate instructions (ADDI)

### Single cycle architecture: all operations complete in one clock cycle.

### Modular design:

- Instruction Memory (ROM with preloaded instructions)

- Register File (32 registers x 32-bit)

- Arithmetic Logic Unit (ALU) with multiple operations

- Main Control and ALU Control units for instruction decoding

- Data Memory (RAM for load/store)

- Program Counter with branching and jump logic

- Sign-Extension unit for immediate fields

- Multiplexers for selecting inputs and outputs based on control signals

## File Structure
### Module/File	Description
1. ``Instruction_Memory.v``	: ROM storing program instructions
2. ``DataMemory.v``        : RAM used for load/store operations
3. ``RegFile.v``	          : Register file with 32 registers
4. ``ALU.v``	:Arithmetic Logic Unit performing operations
5. ``MainDecoder.v``	: Main control unit generating control signals
6. ``ALUDecoder.v``	: Decodes ALU operations based on instruction
7. ``ALUControl.v``	: Top-level control that connects Main and ALU decoders
8. ``Extend.v``	: Immediate value sign-extension
9. ``DataPath.v``	: Connects all datapath components
10. ``RISCV_SingleCycleCPU.v``	:Top-level CPU module instantiating submodules
11. ``tb_RISCV_SingleCycleCPU.v``	:Testbench for simulating the CPU

## Design Details

### Instruction Memory
- 64-word ROM storing 32-bit instructions.
- Initialized with a sample program (can be customized).

### Register File
- 32 registers, 32 bits wide.
- Two read ports and one write port.
- Register x0 is hardwired to zero.

### ALU
- Supports addition, subtraction, AND, OR, SLT (set less than).
- Outputs zero flag for branch decisions.

### Control Units
- MainDecoder: Decodes instruction opcode into control signals.

### ALUDecoder
- Uses funct3, funct7, and opcode to generate ALU operation.

### ALUControl
- Integrates MainDecoder and ALUDecoder outputs.

### Data Memory
- 64-word RAM for load and store.
- Write enable controlled by the MemWrite signal.

### Datapath
- Combines PC logic, register file, ALU, and data memory.
- Includes multiplexers for ALU source, PC source, and result source.
- Implements immediate sign extension based on instruction format.

### Program Counter
- Updates PC on every clock cycle.
- Supports branching and jumping.

## How to Run
### Load Instructions
- Edit Instruction_Memory.v to load your desired RISC-V instructions in the ROM initialization block.

### Simulation
- Use the provided testbench tb_RISCV_SingleCycleCPU.v to simulate the CPU. It includes a clock and reset sequence.

### Run Testbench
- Compile all Verilog files and run the testbench in your simulator (ModelSim, Vivado, etc).
- Observe the program counter, instructions, register file values, and ALU outputs.

### Modify and Extend
- Add support for more instructions by updating the MainDecoder and ALUDecoder.
- Implement hazard detection and pipeline if desired.
- Expand data memory and instruction memory sizes.


### Signals and Naming Convention

- ``clock``	System clock
- ``reset``	Asynchronous reset
- ``program_counter``	Current instruction address (PC)
- ``instruction``	Instruction fetched from instruction memory
- ``reg_write``	Enables register file write
- ``mem_write``	Enables data memory write
- ``alu_src``	Selects ALU second operand source
- ``alu_control``	ALU operation control signals
- ``imm_src``	Immediate value format selector
- ``pc_src``	PC source select for branch/jump
- ``zero_flag``	ALU zero flag for branch condition
- ``read_data``	Data read from data memory
- ``write_data``	Data to write to data memory or register
- ``alu_result``	ALU computed result

## Dependencies
- Verilog simulator (ModelSim, Icarus Verilog, Vivado Simulator, etc.)
- Basic knowledge of RISC-V instruction encoding and processor design.



### Author: [Yashwanth Singh M](github.com/yashwanthsinghm)
### Reference : [Ektha Reddy](https://github.com/EkthaReddy/RISC-V-Single-Cycle-Processor)



### License
This project is released under the MIT License.
