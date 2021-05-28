`include "ISA.v"

module ARM(
  input clk, rst
);

	// TODO: Fix initial values
	wire flush = 0, freeze = 0, is_branch = 0, hazard_detected = 0;
    wire[`LEN_ADDRESS - 1:0] branch_address = 0;

    wire[`LEN_ADDRESS - 1:0] IF_pc;
    wire[`LEN_INSTRUCTION - 1:0] IF_instruction;

	IF_Stage_Module IF_stage_module(
		.clk(clk),
		.rst(rst),
		.flush(flush),
		.freeze(freeze),
		.is_branch(is_branch),
		.branch_address(branch_address),

		.pc(IF_pc),
		.instruction(IF_instruction)
	);


	wire[`LEN_STATUS - 1:0] status_reg_out;

    wire reg_file_wb_en;
    wire [`LEN_REG_ADDRESS - 1:0] reg_file_wb_address;
    wire [`LEN_REGISTER - 1:0] reg_file_wb_data;

    wire[`LEN_ADDRESS - 1:0] ID_pc;
    wire[`LEN_STATUS - 1:0] ID_status_reg;

	wire [`LEN_REGISTER - 1:0] ID_reg_file_out1;
	wire [`LEN_REGISTER - 1:0] ID_reg_file_out2;
	wire [`LEN_SIGNED_IMMEDIATE - 1:0] ID_signed_immediate;
	wire [`LEN_SHIFT_OPERAND - 1:0] ID_shift_operand;
	wire ID_is_immediate;
	wire ID_status_write_enable;
	wire [`LEN_EXECUTE_COMMAND - 1:0] ID_execute_command;
	wire ID_mem_read;
	wire ID_mem_write;
	wire ID_wb_enable;
	wire ID_is_branch;
	wire [`LEN_REG_ADDRESS - 1:0] ID_dest_reg;
	wire [`LEN_REG_ADDRESS - 1:0] ID_reg_file_src1;
	wire [`LEN_REG_ADDRESS - 1:0] ID_reg_file_src2;
	wire ID_has_two_src;

	ID_Stage_Module ID_stage_module(
		.clk(clk),
		.rst(rst),
		.flush(flush),
		.freeze(freeze),
		.hazard_detected(hazard_detected),

		.pc_in(IF_pc),
		.instruction_in(IF_instruction),
		.status_reg_in(status_reg_out),

		.reg_file_wb_en(reg_file_wb_en),
		.reg_file_wb_address(reg_file_wb_address),
		.reg_file_wb_data(reg_file_wb_data),

	// outputs from Reg:
		.pc_out(ID_pc),
		.status_reg_out(ID_status_reg),
		.reg_file_out1(ID_reg_file_out1),
		.reg_file_out2(ID_reg_file_out2),
		.signed_immediate_out(ID_signed_immediate),
		.shift_operand_out(ID_shift_operand),
		.is_immediate_out(ID_is_immediate),
		.status_write_enable_out(ID_status_write_enable),
		.execute_command_out(ID_execute_command),
		.mem_read_out(ID_mem_read),
		.mem_write_out(ID_mem_write),
		.wb_enable_out(ID_wb_enable),
		.is_branch_out(ID_is_branch),
		.dest_reg_out(ID_dest_reg),

	// outputs from Stage:
		.reg_file_src1(ID_reg_file_src1),
		.reg_file_src2(ID_reg_file_src2),
		.has_two_src(ID_has_two_src)
	);

	StatusRegister status_register(
		.clk(clk),
		.rst(rst),
		.ld(ID_status_write_enable),
		.data_in(4'b0), // TODO

		.data_out(status_reg_out)
	);

endmodule