module DataMemory(
    input clock,           // Clock input
    input write_enable,    // Write Enable signal
    input [31:0] address,  // Byte address input
    input [31:0] write_data, // Data to write into memory
    output [31:0] read_data  // Data read from memory
);
    reg [31:0] memory_array[63:0];  // Memory array of 64 words (32-bit each)
    
    // Asynchronous read: word-aligned address (ignore bottom 2 bits)
    assign read_data = memory_array[address[31:2]];
    
    // Synchronous write: on clock edge, write if write_enable is high
    always @(posedge clock) begin
        if (write_enable) 
            memory_array[address[31:2]] <= write_data;
    end
endmodule
