`include "ISA.v"

module MEM_Stage(
	input clk,
	input rst,
	input mem_clk,

	input mem_read_in,
	input mem_write_in,
	input [`LEN_ADDRESS - 1:0] address_in,
	input [`LEN_REGISTER - 1:0] data_in,

	output mem_ready,
	output [`LEN_REGISTER - 1:0] data_out
);

	wire [`LEN_ADDRESS - 1:0] actual_address = (address_in - 1024) >> 2;

	wire SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N;
	wire [`LEN_SRAM_ADDRESS_BUS - 1:0] SRAM_ADDR;
	wire [`LEN_SRAM_DATA_BUS - 1:0] SRAM_DQ;

	SRAM sram(
		.clk(mem_clk),
		.rst(rst),

		.write_enable(SRAM_WE_N),
		.address_in(SRAM_ADDR),

		.SRAM_UB_N(SRAM_UB_N),
		.SRAM_LB_N(SRAM_LB_N),
		.SRAM_CE_N(SRAM_CE_N),
		.SRAM_OE_N(SRAM_OE_N),

		.data(SRAM_DQ)
	);

	SRAM_Controller sram_ontroller(
		.clk(clk),
		.rst(rst),

		.mem_read(mem_read_in),
		.mem_write(mem_write_in),
		.address(actual_address),
		.data_in(data_in),

		.data_out(data_out),
		.mem_ready(mem_ready),

		.SRAM_UB_N(SRAM_UB_N),
		.SRAM_LB_N(SRAM_LB_N),
		.SRAM_WE_N(SRAM_WE_N),
		.SRAM_CE_N(SRAM_CE_N),
		.SRAM_OE_N(SRAM_OE_N),

		.SRAM_DQ(SRAM_DQ),
		.SRAM_ADDR(SRAM_ADDR)
	);

endmodule
