`include "ISA.v"

module MEM_Stage(
	input clk,
	input rst,

	input mem_read_in,
	input mem_write_in,
	input [`LEN_REGISTER - 1:0] address_in, data_in,

	output [`LEN_REGISTER - 1:0] data_out
);

	Memory memory(
	// inputs:
		.clk(clk),
		.rst(rst),

		.mem_read_in(mem_read_in),
		.mem_write_in(mem_write_in),
		.address_in(address_in),
		.data_in(data_in),

	// outputs:
		.data_out(data_out)
	);

endmodule
