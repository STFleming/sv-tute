// always_mux : introducing always_comb blocks, literals, and case statements  
//
// author: stf

module always_mux (
        // Inputs
	input logic [15:0] a,
	input logic [15:0] b,
	input logic [15:0] c,
	input logic [15:0] d,
	input logic [15:0] e,
	input logic [15:0] f,
	input logic [15:0] g,

	input logic [2:0] select,

        // Outputs
	output logic [15:0] q
);
// -------------------------------

always_comb begin
	q = {8'd0, 8'd100};
end

endmodule

