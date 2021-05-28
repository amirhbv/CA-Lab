`include "ISA.v"

module EX_Stage_Reg(
	input clk, rst,
	input freeze,

	input mem_read_in,
	input mem_write_in,
	input wb_enable_in,
	input [`LEN_REG_ADDRESS - 1:0] dest_reg_in,
	input [`LEN_REGISTER - 1:0] alu_result_in, reg_file_out2_in,

	output mem_read_out,
	output mem_write_out,
	output wb_enable_out,
	output [`LEN_REG_ADDRESS - 1:0] dest_reg_out,
	output [`LEN_REGISTER - 1:0] alu_result_out, reg_file_out2_out
);

	Register #(.WORD_LENGTH(1)) mem_read_reg(
		.clk(clk), .rst(rst), .ld(~freeze),
		.in(mem_read_in),

		.out(mem_read_out)
	);

	Register #(.WORD_LENGTH(1)) mem_write_reg(
		.clk(clk), .rst(rst), .ld(~freeze),
		.in(mem_write_in),

		.out(mem_write_out)
	);

	Register #(.WORD_LENGTH(1)) wb_enable_reg(
		.clk(clk), .rst(rst), .ld(~freeze),
		.in(wb_enable_in),

		.out(wb_enable_out)
	);

	Register #(.WORD_LENGTH(`LEN_REG_ADDRESS)) dest_reg_reg(
		.clk(clk), .rst(rst), .ld(~freeze),
		.in(dest_reg_in),

		.out(dest_reg_out)
	);

	Register #(.WORD_LENGTH(`LEN_REGISTER)) alu_result_reg(
		.clk(clk), .rst(rst), .ld(~freeze),
		.in(alu_result_in),

		.out(alu_result_out)
	);

	Register #(.WORD_LENGTH(`LEN_REGISTER)) reg_file_out2_reg(
		.clk(clk), .rst(rst), .ld(~freeze),
		.in(reg_file_out2_in),

		.out(reg_file_out2_out)
	);

endmodule

