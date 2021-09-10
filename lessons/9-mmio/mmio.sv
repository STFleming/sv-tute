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

logic [31:0] config_reg;
logic [31:0] input_data_reg;
logic [31:0] output_data_reg;
logic [31:0] status_reg;

// Write process
always_ff @(posedge clk) begin
	if ((addr_in[31:16] == 16'hFFFF) && wr_in) begin
		case(addr_in[15:0])
			16'h0000 : config_reg <= data_in; 			
			16'h0004 : input_data_reg <= data_in;  
			default: begin
			end
		endcase
	end

	if (rst) begin
		config_reg <= 32'd0;
		input_data_reg <= 32'd0;
	end
end

// Read Process 
always_ff @(posedge clk) begin
	rd_valid_out <= rd_in;

	if ((addr_in[31:16] == 16'hFFFF) && rd_in) begin
		case(addr_in[15:0])
			16'h0000 : data_out <= config_reg; 			
			16'h0004 : data_out <= input_data_reg + 32'd100;  
			16'h0008 : data_out <= output_data_reg;  
			16'h000C : data_out <= status_reg;  
			default: data_out <= 32'd0;
		endcase
	end

	if (rst) begin
		data_out <= 32'd0;	
	end
end

assign output_data_reg = input_data_reg + 32'd42;
assign status_reg = config_reg;

endmodule
// ----- End of MMIO interfacing module -----
