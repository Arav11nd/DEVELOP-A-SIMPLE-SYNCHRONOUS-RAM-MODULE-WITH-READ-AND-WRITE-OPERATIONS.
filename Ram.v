// Simple Synchronous RAM Module

module simple_ram #(
  parameter DATA_WIDTH = 8,
  parameter ADDR_WIDTH = 4,
  parameter DEPTH = 1 << ADDR_WIDTH // Calculate depth based on address width
) (
  input clk,
  input we,      // Write enable
  input [ADDR_WIDTH-1:0] addr,
  input [DATA_WIDTH-1:0] data_in,
  output reg [DATA_WIDTH-1:0] data_out
);

  reg [DATA_WIDTH-1:0] memory [0:DEPTH-1]; // Memory array

  always @(posedge clk) begin
    if (we) begin
      memory[addr] <= data_in; // Write operation
    end
    data_out <= memory[addr]; // Read operation (always performed)
  end

endmodule
