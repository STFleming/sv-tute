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
	case (select)
		3'd0: q = a;
		3'd1: q = b;
		3'd2: q = c; 
		3'd3: q = d; 
		3'd4: q = e; 
		3'd5: q = f; 
		3'd6: q = g; 
	endcase
end

endmodule

