`include "ISA.v"

module MEM_Stage_Module(
	input clk,
	input rst,
	input mem_clk,
	input freeze,

	input mem_read_in,
	input mem_write_in,
	input wb_enable_in,
	input [`LEN_REG_ADDRESS - 1:0] dest_reg_in,
	input [`LEN_REGISTER - 1:0] alu_result_in, reg_file_out2_in,

	output mem_read_out,
	output wb_enable_out,
	output [`LEN_REGISTER - 1:0] alu_result_out,
	output [`LEN_REG_ADDRESS - 1:0] dest_reg_out,
	output [`LEN_REGISTER - 1:0] memory_data_out,
	output mem_ready,

	output [`LEN_REGISTER - 1:0] result_out
);

	wire [`LEN_REGISTER - 1:0] inner_memory_data_out;

    MEM_Stage MEM_stage(
	// inputs:
		.clk(clk),
		.rst(rst),
		.mem_clk(mem_clk),

		.mem_read_in(mem_read_in),
		.mem_write_in(mem_write_in),
		.address_in(alu_result_in),
		.data_in(reg_file_out2_in),

	// outputs:
		.mem_ready(mem_ready),
		.data_out(inner_memory_data_out)
	);

	assign result_out = (mem_read_in) ? inner_memory_data_out : alu_result_in;

    MEM_Stage_Reg MEM_stage_reg(
	// inputs:
		.clk(clk),
		.rst(rst),
		.freeze(freeze),

		.mem_read_in(mem_read_in),
		.wb_enable_in(wb_enable_in),
		.alu_result_in(alu_result_in),
		.memory_data_in(inner_memory_data_out),
		.dest_reg_in(dest_reg_in),

	// outputs:
		.mem_read_out(mem_read_out),
		.wb_enable_out(wb_enable_out),
		.alu_result_out(alu_result_out),
		.dest_reg_out(dest_reg_out),
		.memory_data_out(memory_data_out)
	);

endmodule
