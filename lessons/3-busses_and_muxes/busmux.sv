// busmux : Introducing busses and a multiplexor
//
// author: stf

module busmux (
        // Inputs
	input logic [7:0] a,
	input logic [7:0] b,
	input logic select,

        // Outputs
	output logic [7:0] q
);
// -------------------------------

assign q = select ? b : a;

endmodule

