`include "ISA.v"

module ID_Stage(
	input clk,
	input rst,
	input hazard_detected,

	input [`LEN_INSTRUCTION - 1:0] instruction_in,
	input [`LEN_STATUS - 1:0] status_register,

	input reg_file_wb_en,
	input [`LEN_REG_ADDRESS - 1:0] reg_file_wb_address,
	input [`LEN_REGISTER - 1:0] reg_file_wb_data,


	output [`LEN_REGISTER - 1:0] reg_file_out1, reg_file_out2,
	output [`LEN_SIGNED_IMMEDIATE - 1:0] signed_immediate,
	output [`LEN_SHIFT_OPERAND - 1:0] shift_operand,
	output is_immediate_out,
	output status_write_enable_out,
	output [`LEN_EXECUTE_COMMAND - 1:0] execute_command_out,
	output mem_read_out,
	output mem_write_out,
	output wb_enable_out,
	output is_branch_out,
	output [`LEN_REG_ADDRESS - 1:0] dest_reg_out,

	output [`LEN_REG_ADDRESS - 1:0] reg_file_src1, reg_file_src2,
	output has_two_src
);

	// Decode Instruction
	wire [`LEN_COND - 1:0] cond;
	wire [`LEN_MODE - 1:0] mode;
	wire is_second_op_immediate;
	wire [`LEN_OPCODE - 1:0] opcode;
	wire should_update_status_register;
	wire [`LEN_REG_ADDRESS - 1:0] rn;
	wire [`LEN_REG_ADDRESS - 1:0] rd;
	// wire [`LEN_SHIFT_OPERAND - 1:0] shift_operand;
	wire [`LEN_REG_ADDRESS - 1:0] rm;

	assign {
		cond,
		mode,
		is_second_op_immediate,
		opcode,
		should_update_status_register,
		rn,
		rd,
		shift_operand
	} = instruction_in;

	assign signed_immediate = instruction_in[`LEN_SIGNED_IMMEDIATE - 1:0];
	assign rm = instruction_in[`LEN_REG_ADDRESS - 1:0];

	RegisterFile register_file(
		.clk(clk), .rst(rst),

		.src1(reg_file_src1),
		.src2(reg_file_src2),

		.wb_en(reg_file_wb_en),
		.wb_address(reg_file_wb_address),
		.wb_data(reg_file_wb_data),

		.reg1(reg_file_out1),
		.reg2(reg_file_out2)
	);

	wire is_immediate;
	wire status_write_enable;
	wire [`LEN_EXECUTE_COMMAND - 1:0] execute_command;
	wire mem_read;
	wire mem_write;
	wire wb_enable;
	wire is_branch;
	ControlUnit control_unit(
		.mode(mode),
		.is_second_op_immediate(is_second_op_immediate),
		.opcode(opcode),
		.should_update_status_register(should_update_status_register),

		.is_immediate(is_immediate),
		.status_write_enable(status_write_enable),
		.execute_command(execute_command),
		.mem_read(mem_read),
		.mem_write(mem_write),
		.wb_enable(wb_enable),
		.is_branch(is_branch)
	);

	assign reg_file_src1 = rn;
	assign reg_file_src2 = mem_write ? rd : rm;

	wire condition_result;

	ConditionChecker condition_checker(
		.condition_code(cond),
		.status_register(status_register),

		.condition_result(condition_result)
	);

	wire must_ignore_control_unit_result;
	assign must_ignore_control_unit_result = hazard_detected | (~condition_result);

	assign {
		is_immediate_out,
		status_write_enable_out,
		execute_command_out,
		mem_read_out,
		mem_write_out,
		wb_enable_out,
		is_branch_out
	} = must_ignore_control_unit_result ? 0 : {
		is_immediate,
		status_write_enable,
		execute_command,
		mem_read,
		mem_write,
		wb_enable,
		is_branch
	};

	assign dest_reg_out = rd;
	assign has_two_src = (~is_second_op_immediate) | mem_write_out;

endmodule
