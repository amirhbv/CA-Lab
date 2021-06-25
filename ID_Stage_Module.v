`include "ISA.v"

module ID_Stage_Module(
	input clk,
	input rst,
	input flush,
	input hazard_detected,

	input[`LEN_ADDRESS - 1:0] pc_in,
	input [`LEN_INSTRUCTION - 1:0] instruction_in,
	input [`LEN_STATUS - 1:0] status_reg_in,

	input reg_file_wb_en,
	input [`LEN_REG_ADDRESS - 1:0] reg_file_wb_address,
	input [`LEN_REGISTER - 1:0] reg_file_wb_data,

// outputs from Reg:
	output [`LEN_ADDRESS - 1:0] pc_out,
	output [`LEN_STATUS - 1:0] status_reg_out,
	output [`LEN_REG_ADDRESS - 1:0] reg_file_src1_reg, reg_file_src2_reg,
	output [`LEN_REGISTER - 1:0] reg_file_out1, reg_file_out2,
	output [`LEN_SIGNED_IMMEDIATE - 1:0] signed_immediate_out,
	output [`LEN_SHIFT_OPERAND - 1:0] shift_operand_out,
	output is_immediate_out,
	output status_write_enable_out,
	output [`LEN_EXECUTE_COMMAND - 1:0] execute_command_out,
	output mem_read_out,
	output mem_write_out,
	output wb_enable_out,
	output is_branch_out,
	output [`LEN_REG_ADDRESS - 1:0] dest_reg_out,

// outputs from Stage:
	output [`LEN_REG_ADDRESS - 1:0] reg_file_src1, reg_file_src2,
	output wire has_two_src
);

	wire [`LEN_REGISTER - 1:0] inner_reg_file_out1, inner_reg_file_out2;
	wire [`LEN_SIGNED_IMMEDIATE - 1:0] inner_signed_immediate;
	wire [`LEN_SHIFT_OPERAND - 1:0] inner_shift_operand;
	wire inner_is_immediate;
	wire inner_status_write_enable;
	wire [`LEN_EXECUTE_COMMAND - 1:0] inner_execute_command;
	wire inner_mem_read;
	wire inner_mem_write;
	wire inner_wb_enable;
	wire inner_is_branch;
	wire [`LEN_REG_ADDRESS - 1:0] inner_dest_reg;

	ID_Stage ID_Stage(
		.clk(clk), .rst(rst),
		.hazard_detected(hazard_detected),

		.instruction_in(instruction_in),
		.status_register(status_reg_in),

		.reg_file_wb_en(reg_file_wb_en),
		.reg_file_wb_address(reg_file_wb_address),
		.reg_file_wb_data(reg_file_wb_data),


	// outputs to Reg:
		.reg_file_out1(inner_reg_file_out1),
		.reg_file_out2(inner_reg_file_out2),
		.signed_immediate(inner_signed_immediate),
		.shift_operand(inner_shift_operand),
		.is_immediate_out(inner_is_immediate),
		.status_write_enable_out(inner_status_write_enable),
		.execute_command_out(inner_execute_command),
		.mem_read_out(inner_mem_read),
		.mem_write_out(inner_mem_write),
		.wb_enable_out(inner_wb_enable),
		.is_branch_out(inner_is_branch),
		.dest_reg_out(inner_dest_reg),

	// outputs to top-module:
		.reg_file_src1(reg_file_src1),
		.reg_file_src2(reg_file_src2),
		.has_two_src(has_two_src)
	);

	ID_Stage_Reg ID_Stage_Reg(
		.clk(clk),
		.rst(rst),
		.flush(flush),

		.pc_in(pc_in),
		.status_reg_in(status_reg_in),
		.reg_file_src1_in(reg_file_src1),
		.reg_file_src2_in(reg_file_src2),
		.reg_file_out1_in(inner_reg_file_out1),
		.reg_file_out2_in(inner_reg_file_out2),
		.signed_immediate_in(inner_signed_immediate),
		.shift_operand_in(inner_shift_operand),
		.is_immediate_in(inner_is_immediate),
		.status_write_enable_in(inner_status_write_enable),
		.execute_command_in(inner_execute_command),
		.mem_read_in(inner_mem_read),
		.mem_write_in(inner_mem_write),
		.wb_enable_in(inner_wb_enable),
		.is_branch_in(inner_is_branch),
		.dest_reg_in(inner_dest_reg),

		.pc_out(pc_out),
		.status_reg_out(status_reg_out),
		.reg_file_src1_out(reg_file_src1_reg),
		.reg_file_src2_out(reg_file_src2_reg),
		.reg_file_out1_out(reg_file_out1),
		.reg_file_out2_out(reg_file_out2),
		.signed_immediate_out(signed_immediate_out),
		.shift_operand_out(shift_operand_out),
		.is_immediate_out(is_immediate_out),
		.status_write_enable_out(status_write_enable_out),
		.execute_command_out(execute_command_out),
		.mem_read_out(mem_read_out),
		.mem_write_out(mem_write_out),
		.wb_enable_out(wb_enable_out),
		.is_branch_out(is_branch_out),
		.dest_reg_out(dest_reg_out)
	);

endmodule
