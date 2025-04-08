// Test Bench for Simple Synchronous RAM Module

module simple_ram_tb;

  // Parameters
  parameter DATA_WIDTH = 8;
  parameter ADDR_WIDTH = 4;
  parameter DEPTH = 1 << ADDR_WIDTH;

  // Signals
  reg clk;
  reg we;
  reg [ADDR_WIDTH-1:0] addr;
  reg [DATA_WIDTH-1:0] data_in;
  wire [DATA_WIDTH-1:0] data_out;

  // Instantiate the RAM module
  simple_ram #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .DEPTH(DEPTH)
  ) ram_inst (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // Clock period = 10 time units
  end

  // Test sequence
  initial begin
    // Initialize signals
    we = 0;
    addr = 0;
    data_in = 0;

    // Write data to memory
    #10;
    we = 1;
    addr = 4;
    data_in = 8'hAA;
    #10;
    addr = 8;
    data_in = 8'h55;
    #10;
    addr = 15;
    data_in = 8'hFF;
    #10;
    addr = 0;
    data_in = 8'h00;
    #10;

    // Disable write enable
    we = 0;

    // Read data from memory
    #10;
    addr = 4;
    #10;
    addr = 8;
    #10;
    addr = 15;
    #10;
    addr = 0;
    #10;

    // Finish simulation
    $finish;
  end

  // Monitor data
  initial begin
    $monitor("Time=%0t, addr=%0d, we=%0b, data_in=%0h, data_out=%0h", $time, addr, we, data_in, data_out);
  end

endmodule
