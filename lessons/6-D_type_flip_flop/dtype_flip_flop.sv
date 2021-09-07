// A D_Type FlipFlop (Readler -- VBE -- page 15)
//
// author: stf

// -------------------------------
//  D type flip-flop module
// -------------------------------
module D_type_flip_flop (
        input logic clk,
        input logic rst,

        input logic din,
        output logic dout 
);
// -------------------------------

always_ff @(posedge clk) begin

	dout <= din; // Blocking assignment 

	if(rst) begin
		dout <= 1'b0;
	end
end

endmodule
// ----- End of D_type_flip_flop module -----
