// MMIO  
// 
// A 4-byte addressable memory-mapped IO module
// used to help demystify HW/SW communications a bit
//
// author: stf

module top_tb(
    input clk,
    input rst,

    input logic [31:0]  addr_in,
    input logic [31:0]  data_in,
    input logic         wr_in,

    input logic         rd_in,
    output logic 	rd_valid_out,
    output logic [31:0] data_out
);


   mmio mmio_inst(
        .clk(clk),
        .rst(rst),

        .addr_in(addr_in),
        .data_in(data_in),
	.wr_in(wr_in),

	.rd_in(rd_in),
	.rd_valid_out(rd_valid_out),
	.data_out(data_out)
   );


   // Print some stuff as an example
   initial begin
      if ($test$plusargs("trace") != 0) begin
         $display("[%0t] Tracing to logs/vlt_dump.vcd...\n", $time);
         $dumpfile("logs/vlt_dump.vcd");
         $dumpvars();
      end
      $display("[%0t] Model running...\n", $time);
   end

endmodule
