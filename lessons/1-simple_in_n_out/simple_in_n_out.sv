// simple_in_n_out  (Readler -- VBE -- page 6)  
// 
//
// author: stf

// -------------------------------
// simple 
// -------------------------------
module simple_in_n_out (
    // Inputs
    input logic in_1,
    input logic in_2,
    input logic in_3,

    // Outputs
    output logic out_1,
    output logic out_2
);
// -------------------------------

assign out_1 = in_1 & in_2 & in_3;
assign out_2 = in_1 | in_2 | in_3;

endmodule
// ----- End of simple_in_n_out module -----

