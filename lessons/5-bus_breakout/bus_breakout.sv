// bus_breakout  (Readler -- VBE -- page 14)
//
// author: stf

// -----------------------------------
// Bus Breakout module
// -----------------------------------
module bus_breakout (
        // Inputs
        input logic [3:0] a,
        input logic [3:0] b,

        // Outputs
        output logic [5:0] q 

);

always_comb begin
	q = { b[3:2],
	      b[1] & a[3],
	      b[0] & a[2],
	      a[1:0] };
end

endmodule
// -----------------------------------
