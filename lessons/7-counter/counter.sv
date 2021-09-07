// An 8 bit counter 
//
// author: stf

// -------------------------------
//  Counter hardware
// -------------------------------
module counter (
        input logic clk,
        input logic rst,

        output logic[7:0] cnt_out 
);
// -------------------------------

always_ff @(posedge clk) begin

	cnt_out <= cnt_out + 8'd1;

	if (rst) begin
		cnt_out <= 8'd0;
	end

end

endmodule
// ----- End of counter module -----
