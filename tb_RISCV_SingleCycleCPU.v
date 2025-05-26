`timescale 1ns / 1ps

module tb_RISCV_SingleCycleCPU();
    reg clk;
    reg reset;

    // Instantiate the CPU
    RISCV_SingleCycleCPU cpu (
        .clock(clk),
        .reset(reset)
    );

    // Clock generation: 10 ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset sequence
    initial begin
        reset = 1;
        #15;          // hold reset for some time
        reset = 0;
    end

    // Run simulation for 200 ns and then finish
    initial begin
        #200;
        $finish;
    end

    // Optional: Monitor PC and instruction for debugging
    initial begin
        $monitor("Time=%0t clk=%b reset=%b PC=0x%h instr=0x%h",
                 $time, clk, reset, cpu.pc, cpu.instruction);
    end
endmodule
