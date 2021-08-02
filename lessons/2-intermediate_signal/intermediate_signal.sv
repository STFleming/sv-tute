// intermediate_signals  (Readler -- VBE -- page 8)
//
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

logic intermediate_signal; 

assign intermediate_signal = in_1 & in_2;
assign out_1 = intermediate_signal & in_3;
assign out_2 = intermediate_signal | in_3;

endmodule

