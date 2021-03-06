`include "ISA.v"

module Memory(
	input clk,
	input rst,

	input mem_read_in,
	input mem_write_in,
	input [`LEN_REGISTER - 1:0] address_in, data_in,

	output [`LEN_REGISTER - 1:0] data_out
);

	reg [`LEN_REGISTER - 1:0] data [0:`SIZE_DATA_MEMORY - 1];

	assign data_out = (mem_read_in == `ENABLE) ? data[address_in] : `LEN_REGISTER'b0;

	always@(posedge clk) begin
		if(mem_write_in) begin
			data[address_in] <= data_in;
		end
	end

endmodule
