// Testbench for the d_type flip flop module
//
// author: stf

module top_tb(
    input clk,
    input rst
);

   logic[7:0] cnt;

   counter counter_inst(
        .clk(clk),
        .rst(rst),

        .cnt_out(cnt)
   );

   always_ff @(posedge clk) begin 
        $display("cnt = %d", cnt);
   end


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
