// MMIO  
// 
// A 4-byte addressable memory-mapped IO module
// used to help demystify HW/SW communications a bit
//
// author: stf

// -------------------------------
//  Memory Mapped IO block 
// -------------------------------
module mmio (
        input logic clk,
        input logic rst,

	input logic [31:0]   addr_in, // The address for the memory mapped register
	input logic [31:0]   data_in, // incoming data 
	input logic          wr_in,   // the write signal 

	input logic          rd_in,   // the read signal
	output logic 	     rd_valid_out, // when this is high there is a valid read signal at the output
	output logic [31:0]  data_out // the output data
);
// -------------------------------

logic [31:0] reg1;
logic [31:0] reg2;

// write logic
always_ff @(posedge clk) begin
	if( (addr_in[31:16] == 16'hFFFF) & wr_in) begin

		case(addr_in[15:0])
			16'h0000: reg1 <= data_in;
			16'h0004: reg2 <= data_in;
			default: begin
				// dont change the values otherwise
			end
		endcase
	
	end

	if(rst) begin
		reg1 <= 32'd0;
		reg2 <= 32'd0;
	end
end


// read logic
always_ff @(posedge clk) begin

	rd_valid_out <= rd_in;

	if ((addr_in[31:16] == 16'hFFFF) & rd_in) begin

		case(addr_in[15:0])
			16'h0000: data_out <= reg1;
			16'h0004: data_out <= reg2;
			default: begin
				// keep data_out the same value
			end
		endcase
	end

	if (rst) begin
		data_out <= 32'd0;
	end

end




endmodule
// ----- End of MMIO interfacing module -----
