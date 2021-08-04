// bus_breakout  (Readler -- VBE -- page 14)
//
// author: stf

// -----------------------------------
// Bus Breakout module
// -----------------------------------
module bus_breakout (
        // Inputs
        input logic [3:0] in_1,
        input logic [3:0] in_2,

        // Outputs
        output logic [5:0] out_1

);

assign out_1 = {    in_2[3:2],
                    (in_1[3] & in_2[1]),
                    (in_1[2] & in_2[0]),
                    in_1[1:0]
                };

endmodule
// -----------------------------------
