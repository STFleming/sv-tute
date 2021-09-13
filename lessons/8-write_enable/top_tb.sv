// Testbench for the d_type flip flop module
//
// author: stf

module top_tb(
    input clk,
    input rst
);

   logic[31:0] tb_data;
   logic tb_wr;
   logic[31:0] tb_res;

   always_ff @(posedge clk) begin
	tb_data <= tb_data + 32'd1;
	tb_wr <= ~tb_wr;

	if (rst) begin
		tb_data <= 32'd0;
		tb_wr <= 1'b0;
	end
   end


   we_reg we_reg_inst(
        .clk(clk),
        .rst(rst),

	.data_in(tb_data),
	.wr_in(tb_wr),

        .data_out(tb_res)
   );

   always_ff @(posedge clk) begin 
        $display("data_out = %d", tb_res);
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
