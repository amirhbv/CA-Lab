`include "ISA.v"

module ARM(
  input clk, rst, forwarding_enable, mem_clk
);

	wire flush, is_branch;
    wire[`LEN_ADDRESS - 1:0] branch_address;
	wire hazard_detected, inner_hazard_detected;
	wire mem_ready;

    wire[`LEN_ADDRESS - 1:0] IF_pc;
    wire[`LEN_INSTRUCTION - 1:0] IF_instruction;

	IF_Stage_Module IF_stage_module(
		.clk(clk),
		.rst(rst),
		.flush(flush),
		.freeze(hazard_detected | ~mem_ready),
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

	wire [`LEN_REG_ADDRESS - 1:0] ID_reg_file_src1_reg;
	wire [`LEN_REG_ADDRESS - 1:0] ID_reg_file_src2_reg;
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
		.freeze(~mem_ready),
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
		.reg_file_src1_reg(ID_reg_file_src1_reg), // Rn address
		.reg_file_src2_reg(ID_reg_file_src2_reg), // Rm address
		.reg_file_out1(ID_reg_file_out1), // Rn
		.reg_file_out2(ID_reg_file_out2), // Rm
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

	assign flush = ID_is_branch;
	assign is_branch = ID_is_branch;

	wire EX_mem_read;
	wire EX_mem_write;
	wire EX_wb_enable;
	wire [`LEN_REG_ADDRESS - 1:0] EX_dest_reg;
	wire [`LEN_REGISTER - 1:0] EX_reg_file_out2; // Rm
	wire [`LEN_REGISTER - 1:0] EX_alu_result;
	wire [`LEN_STATUS - 1:0] status_bits;

	wire [`LEN_FORW_SEL - 1:0] forw_sel_op1, forw_sel_op2;
	wire [`LEN_REGISTER - 1:0] MEM_result;

	EX_Stage_Module EX_stage_module(
		.clk(clk),
		.rst(rst),
		.freeze(~mem_ready),

		.pc_in(ID_pc),
		.status_reg_in(ID_status_reg),
		.reg_file_out1_in(ID_reg_file_out1), // Rn
		.reg_file_out2_in(ID_reg_file_out2), // Rm
		.signed_immediate_in(ID_signed_immediate),
		.shift_operand_in(ID_shift_operand),
		.is_immediate_in(ID_is_immediate),
		.execute_command_in(ID_execute_command),
		.mem_read_in(ID_mem_read),
		.mem_write_in(ID_mem_write),
		.forw_sel_op1(forw_sel_op1),
		.forw_sel_op2(forw_sel_op2),
		.MEM_result(MEM_result),
		.WB_result(reg_file_wb_data),
		.wb_enable_in(ID_wb_enable),
		.dest_reg_in(ID_dest_reg),


	// outputs from Reg:
		.mem_read_out(EX_mem_read),
		.mem_write_out(EX_mem_write),
		.wb_enable_out(EX_wb_enable),
		.dest_reg_out(EX_dest_reg),
		.reg_file_out2_out(EX_reg_file_out2),
		.alu_result_out(EX_alu_result),

	// outputs from Stage:
		.status_bits(status_bits),
		.branch_address(branch_address)
	);

	StatusRegister status_register(
		.clk(clk),
		.rst(rst),
		.ld(ID_status_write_enable),
		.data_in(status_bits),

		.data_out(status_reg_out)
	);


	wire MEM_mem_read;
	wire MEM_wb_enable;
	wire [`LEN_REGISTER - 1:0] MEM_alu_result;
	wire [`LEN_REG_ADDRESS - 1:0] MEM_dest_reg;
	wire [`LEN_REGISTER - 1:0] MEM_data_out;

	MEM_Stage_Module MEM_stage_module(
		.clk(clk),
		.rst(rst),
		.mem_clk(mem_clk),
		.freeze(~mem_ready),

		.mem_read_in(EX_mem_read),
		.mem_write_in(EX_mem_write),
		.wb_enable_in(EX_wb_enable),
		.dest_reg_in(EX_dest_reg),
		.reg_file_out2_in(EX_reg_file_out2),
		.alu_result_in(EX_alu_result),

		.mem_read_out(MEM_mem_read),
		.wb_enable_out(MEM_wb_enable),
		.alu_result_out(MEM_alu_result),
		.dest_reg_out(MEM_dest_reg),

		.mem_ready(mem_ready),
		.memory_data_out(MEM_data_out),

		.result_out(MEM_result)
	);

	assign reg_file_wb_en = MEM_wb_enable;
	assign reg_file_wb_address = MEM_dest_reg;

	WB_Stage_Module WB_stage_module(
		.mem_read_in(MEM_mem_read),
		.alu_result_in(MEM_alu_result),
		.memory_data_in(MEM_data_out),

		.wb_data_out(reg_file_wb_data)
	);

	HazardDetector hazard_detector(
		.EX_wb_enable(ID_wb_enable),
		.MEM_wb_enable(EX_wb_enable),
		.reg_file_src1(ID_reg_file_src1), // Rn
		.reg_file_src2(ID_reg_file_src2), // Rm
		.has_two_src(ID_has_two_src),
		.EX_reg_dest(ID_dest_reg),
		.MEM_reg_dest(EX_dest_reg),

		.hazard_detected(inner_hazard_detected)
	);

	assign hazard_detected = (forwarding_enable == `ENABLE) ? 0 : inner_hazard_detected;

	ForwardingUnit forwarding_unit(
		.forwarding_enable(forwarding_enable),
		.MEM_wb_enable(EX_wb_enable),
		.WB_wb_enable(MEM_wb_enable),
		.reg_file_src1(ID_reg_file_src1_reg), // Rn
		.reg_file_src2(ID_reg_file_src2_reg), // Rm
		.MEM_reg_dest(EX_dest_reg),
		.WB_reg_dest(MEM_dest_reg),

		.sel_op1(forw_sel_op1),
		.sel_op2(forw_sel_op2)
	);

endmodule
