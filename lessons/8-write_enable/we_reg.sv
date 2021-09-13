// A 32-bit write enabled register 
//
// author: stf

// -------------------------------
//  Write enabled register
// -------------------------------
module we_reg (
        input logic clk,
        input logic rst,

	input logic[31:0] data_in,
	input logic wr_in,

        output logic[31:0] data_out 
);
// -------------------------------

always_ff @(posedge clk) begin

	data_out <= data_out;

	if(wr_in) begin
		data_out <= data_in;
	end

	if (rst) begin
		data_out <= 32'd0;
	end
end

endmodule
// ----- End of we_reg module -----
