`include "ISA.v"

module EX_Stage(
	input clk,
	input rst,

	input [`LEN_ADDRESS - 1:0] pc_in,
	input [`LEN_STATUS - 1:0] status_reg_in,
	input [`LEN_REGISTER - 1:0] reg_file_out1_in, reg_file_out2_in,
	input [`LEN_SIGNED_IMMEDIATE - 1:0] signed_immediate_in,
	input [`LEN_SHIFT_OPERAND - 1:0] shift_operand_in,
	input is_immediate_in,
	input [`LEN_EXECUTE_COMMAND - 1:0] execute_command_in,
	input mem_read_in,
	input mem_write_in,

	output [`LEN_REGISTER - 1:0] alu_result,
	output [`LEN_STATUS - 1:0] status_bits,
	output [`LEN_ADDRESS - 1:0] branch_address
);

	wire is_mem_command = mem_read_in | mem_write_in;

	wire [`LEN_REGISTER - 1:0] alu_sesond_op;
	Val2Generator val2_generator(
		.op(reg_file_out2_in),
		.is_immediate(is_immediate_in),
		.is_mem_command(is_mem_command),
		.shift_operand(shift_operand_in),

		.result(alu_sesond_op)
	);

	ALU alu(
		.command(execute_command_in),
		.op1(reg_file_out1_in),
		.op2(alu_sesond_op),
		.status_reg_in(status_reg_in),

		.result(alu_result),
		.status_bits(status_bits)
	);

	wire [`LEN_ADDRESS - 1:0] sign_extended_signed_immediate_in = {{8{signed_immediate_in[23]}} , signed_immediate_in};
	assign branch_address = (sign_extended_signed_immediate_in << 2) + pc_in;

endmodule
