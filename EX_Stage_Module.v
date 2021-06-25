`include "ISA.v"

module EX_Stage_Module(
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
	input [`LEN_FORW_SEL - 1:0] forw_sel_op1, forw_sel_op2,
	input [`LEN_REGISTER - 1:0] MEM_result, WB_result,
	input wb_enable_in,
	input [`LEN_REG_ADDRESS - 1:0] dest_reg_in,

// outputs from Reg:
	output mem_read_out,
	output mem_write_out,
	output wb_enable_out,
	output [`LEN_REG_ADDRESS - 1:0] dest_reg_out,
	output [`LEN_REGISTER - 1:0] alu_result_out, reg_file_out2_out,

// outputs from Stage:
	output [`LEN_STATUS - 1:0] status_bits,
	output [`LEN_ADDRESS - 1:0] branch_address
);

	wire [`LEN_REGISTER - 1:0] inner_alu_result, inner_reg_file_out2;

    EX_Stage EX_stage(
	// inputs:
		.clk(clk),
		.rst(rst),

		.pc_in(pc_in),
		.status_reg_in(status_reg_in),
		.reg_file_out1_in(reg_file_out1_in), // Rn
		.reg_file_out2_in(reg_file_out2_in), // Rm
		.signed_immediate_in(signed_immediate_in),
		.shift_operand_in(shift_operand_in),
		.is_immediate_in(is_immediate_in),
		.execute_command_in(execute_command_in),
		.mem_read_in(mem_read_in),
		.mem_write_in(mem_write_in),
		.forw_sel_op1(forw_sel_op1),
		.forw_sel_op2(forw_sel_op2),
		.MEM_result(MEM_result),
		.WB_result(WB_result),

	// outputs to Reg:
		.alu_result(inner_alu_result),
		.inner_reg_file_out2(inner_reg_file_out2),

	// outputs:
		.status_bits(status_bits),
		.branch_address(branch_address)
	);

    EX_Stage_Reg EX_stage_reg(
	// inputs:
		.clk(clk),
		.rst(rst),

		.mem_read_in(mem_read_in),
		.mem_write_in(mem_write_in),
		.wb_enable_in(wb_enable_in),
		.reg_file_out2_in(inner_reg_file_out2), // Rm
		.alu_result_in(inner_alu_result),
		.dest_reg_in(dest_reg_in),

	// outputs:
		.mem_read_out(mem_read_out),
		.mem_write_out(mem_write_out),
		.wb_enable_out(wb_enable_out),
		.reg_file_out2_out(reg_file_out2_out), // Rm
		.alu_result_out(alu_result_out),
		.dest_reg_out(dest_reg_out)
	);

endmodule
