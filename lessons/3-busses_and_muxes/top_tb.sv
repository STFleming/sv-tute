// Busses and Muxes Testbench
//
// author: stf

module top_tb(
    input clk,
    input rst
);

   // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
   // Testbench signals
   // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
   logic [7:0] tb_a;
   logic [7:0] tb_b;
   logic tb_sel;

   logic [7:0] tb_q;

   // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
   // Testbench logic for signal sequencing
   // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
   always_ff @(posedge clk) begin
	tb_a <= tb_a + 8'd1;
	tb_b <= tb_b + 8'd1;
	tb_sel <= ~tb_sel;
	if (rst) begin
		tb_a <= 8'd0;
		tb_b <= 8'd100;
		tb_sel <= 1'b0;
	end
   end
   // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

   busmux busmux_inst(
	// inputs
        .a(tb_a),
        .b(tb_b),
        .select(tb_sel),
	
	// outputs
        .q(tb_q)
   );

   always_ff @(posedge clk) begin 
        $display("a=%d, b=%d, sel=%d, q=%d ", tb_a, tb_b, tb_sel, tb_q);
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
