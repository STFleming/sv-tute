// Testbench for the d_type flip flop module
//
// author: stf

module top_tb(
    input clk,
    input rst
);

   logic a_tb;

   logic[31:0] cnt;

   always_ff @(posedge clk) begin

	if (cnt >= 32'd4) begin
        	a_tb <= !a_tb;
		cnt <= 32'd0;
	end else begin
		cnt <= cnt + 32'd1;
	end

        if (rst) begin
        	a_tb <= 1'b0;
		cnt <= 32'd0;	
        end
   end
   
   logic out_tb;

   D_type_flip_flop D_type_flip_flop_inst(
        .clk(clk),
        .rst(rst),

        .din(a_tb),
        .dout(out_tb)
   );

   always_ff @(posedge clk) begin 
        $display("dout = %d", out_tb);
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
