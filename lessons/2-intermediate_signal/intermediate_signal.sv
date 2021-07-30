// intermediate_signals  (Readler -- VBE -- page 8)
//
// Implements a 2 input MUX from first principles.
//
// author: stf

module intermediate_signal (
        // Inputs
        input logic in_1,
        input logic in_2,
        input logic in_3,

        // Outputs
        output logic out_1,
        output logic out_2
);
// -------------------------------

logic internal_sig;

assign internal_sig = in_1 & in_2;

assign out_1 = internal_sig & in_3;
assign out_2 = internal_sig | in_3;

endmodule

