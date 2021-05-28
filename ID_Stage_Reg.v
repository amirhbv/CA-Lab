`include "ISA.v"

module ID_Stage_Reg(
	input clk,
	input rst,
	input flush,
	input freeze,

	input [`LEN_ADDRESS - 1:0] pc_in,
	input [`LEN_STATUS - 1:0] status_reg_in,
	input [`LEN_REGISTER - 1:0] reg_file_out1_in, reg_file_out2_in,
	input [`LEN_SIGNED_IMMEDIATE - 1:0] signed_immediate_in,
	input [`LEN_SHIFT_OPERAND - 1:0] shift_operand_in,
	input is_immediate_in,
	input status_write_enable_in,
	input [`LEN_EXECUTE_COMMAND - 1:0] execute_command_in,
	input mem_read_in,
	input mem_write_in,
	input wb_enable_in,
	input is_branch_in,
	input [`LEN_REG_ADDRESS - 1:0] dest_reg_in,

	output [`LEN_ADDRESS - 1:0] pc_out,
	output [`LEN_STATUS - 1:0] status_reg_out,
	output [`LEN_REGISTER - 1:0] reg_file_out1_out, reg_file_out2_out,
	output [`LEN_SIGNED_IMMEDIATE - 1:0] signed_immediate_out,
	output [`LEN_SHIFT_OPERAND - 1:0] shift_operand_out,
	output is_immediate_out,
	output status_write_enable_out,
	output [`LEN_EXECUTE_COMMAND - 1:0] execute_command_out,
	output mem_read_out,
	output mem_write_out,
	output wb_enable_out,
	output is_branch_out,
	output [`LEN_REG_ADDRESS - 1:0] dest_reg_out
);

	RegisterFlush #(.WORD_LENGTH(`LEN_ADDRESS)) pc_reg(
		.clk(clk), .rst(rst), .flush(flush), .ld(~freeze),
		.in(pc_in),

		.out(pc_out)
	);

	RegisterFlush #(.WORD_LENGTH(`LEN_STATUS)) status_reg_reg(
		.clk(clk), .rst(rst), .flush(flush), .ld(~freeze),
		.in(status_reg_in),

		.out(status_reg_out)
	);

	RegisterFlush #(.WORD_LENGTH(`LEN_REGISTER)) reg_file_out1_reg(
		.clk(clk), .rst(rst), .flush(flush), .ld(~freeze),
		.in(reg_file_out1_in),

		.out(reg_file_out1_out)
	);

	RegisterFlush #(.WORD_LENGTH(`LEN_REGISTER)) reg_file_out2_reg(
		.clk(clk), .rst(rst), .flush(flush), .ld(~freeze),
		.in(reg_file_out2_in),

		.out(reg_file_out2_out)
	);

	RegisterFlush #(.WORD_LENGTH(`LEN_SIGNED_IMMEDIATE)) signed_immediate_reg(
		.clk(clk), .rst(rst), .flush(flush), .ld(~freeze),
		.in(signed_immediate_in),

		.out(signed_immediate_out)
	);

	RegisterFlush #(.WORD_LENGTH(`LEN_SHIFT_OPERAND)) shift_operand_reg(
		.clk(clk), .rst(rst), .flush(flush), .ld(~freeze),
		.in(shift_operand_in),

		.out(shift_operand_out)
	);

	RegisterFlush #(.WORD_LENGTH(1)) is_immediate_reg(
		.clk(clk), .rst(rst), .flush(flush), .ld(~freeze),
		.in(is_immediate_in),

		.out(is_immediate_out)
	);

	RegisterFlush #(.WORD_LENGTH(1)) status_write_enable_reg(
		.clk(clk), .rst(rst), .flush(flush), .ld(~freeze),
		.in(status_write_enable_in),

		.out(status_write_enable_out)
	);

	RegisterFlush #(.WORD_LENGTH(`LEN_EXECUTE_COMMAND)) execute_command_reg(
		.clk(clk), .rst(rst), .flush(flush), .ld(~freeze),
		.in(execute_command_in),

		.out(execute_command_out)
	);

	RegisterFlush #(.WORD_LENGTH(1)) mem_read_reg(
		.clk(clk), .rst(rst), .flush(flush), .ld(~freeze),
		.in(mem_read_in),

		.out(mem_read_out)
	);

	RegisterFlush #(.WORD_LENGTH(1)) mem_write_reg(
		.clk(clk), .rst(rst), .flush(flush), .ld(~freeze),
		.in(mem_write_in),

		.out(mem_write_out)
	);

	RegisterFlush #(.WORD_LENGTH(1)) wb_enable_reg(
		.clk(clk), .rst(rst), .flush(flush), .ld(~freeze),
		.in(wb_enable_in),

		.out(wb_enable_out)
	);

	RegisterFlush #(.WORD_LENGTH(1)) is_branch_reg(
		.clk(clk), .rst(rst), .flush(flush), .ld(~freeze),
		.in(is_branch_in),

		.out(is_branch_out)
	);

	RegisterFlush #(.WORD_LENGTH(`LEN_REG_ADDRESS)) dest_reg_reg(
		.clk(clk), .rst(rst), .flush(flush), .ld(~freeze),
		.in(dest_reg_in),

		.out(dest_reg_out)
	);

endmodule
