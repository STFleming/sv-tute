// A D_Type FlipFlop (Readler -- VBE -- page 15)
//
// author: stf

// -------------------------------
//  D type flip-flop module
// -------------------------------
module D_type_flip_flop (
        input logic clk,
        input logic rst,

        input logic in_1,
        output logic out_1
);
// -------------------------------

always_ff @(posedge clk) begin

        out_1 <= in_1;

        if (rst) begin
                out_1 <= 1'b0;
        end
end

endmodule
// ----- End of D_type_flip_flop module -----
