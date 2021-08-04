module top_tb(
    input clk,
    input rst
);

   // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
   // Testbench signals
   // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
   logic [3:0] tb_in1;
   logic [3:0] tb_in2;

   logic [5:0] tb_out1;

   // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
   // Testbench logic for signal sequencing
   // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
   always_ff @(posedge clk) begin
	tb_in1 <= tb_in1 + 4'd1;	
	tb_in2 <= tb_in2 + 4'd1;	
	if (rst) begin
	    tb_in1 <= 4'd0;
	    tb_in2 <= 4'd8;
	end
   end
   // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

   bus_breakout bus_breakout_inst(

	// inputs
        .in_1(tb_in1),
        .in_2(tb_in2),
	
	// outputs
        .out_1(tb_out1)
   );

   always_ff @(posedge clk) begin 
        $display("tb_out1 = %d", tb_out1);
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
