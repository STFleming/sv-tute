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
   logic [15:0] tb_a;
   logic [15:0] tb_b;
   logic [15:0] tb_c;
   logic [15:0] tb_d;
   logic [15:0] tb_e;
   logic [15:0] tb_f;
   logic [15:0] tb_g;
   logic [2:0] tb_sel;

   logic [15:0] tb_q;

   // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
   // Testbench logic for signal sequencing
   // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
   always_ff @(posedge clk) begin
	tb_a <= tb_a + 16'd1;
	tb_b <= tb_b + 16'd1;
	tb_c <= tb_c + 16'd1;
	tb_d <= tb_d + 16'd1;
	tb_e <= tb_e + 16'd1;
	tb_f <= tb_f + 16'd1;
	tb_g <= tb_g + 16'd1;
	tb_sel <= tb_sel + 3'd1;
	if (rst) begin
		tb_a <= 16'd0;
		tb_b <= 16'd100;
		tb_c <= 16'd200;
		tb_d <= 16'd300;
		tb_e <= 16'd400;
		tb_f <= 16'd500;
		tb_g <= 16'd600;
		tb_sel <= 3'd0;
	end
   end
   // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

   always_mux always_mux_inst(
	// inputs
        .a(tb_a),
        .b(tb_b),
        .c(tb_c),
        .d(tb_d),
        .e(tb_e),
        .f(tb_f),
        .g(tb_g),
        .select(tb_sel),
	
	// outputs
        .q(tb_q)
   );

   always_ff @(posedge clk) begin 
        $display("sel=%d, q=%d ", tb_sel, tb_q);
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
