`include "ISA.v"

module IF_Stage_Module (
	input clk, rst,
    input freeze, is_branch, flush,
	input [`LEN_ADDRESS - 1:0] branch_address,

	output [`LEN_ADDRESS - 1:0] pc,
	output [`LEN_INSTRUCTION - 1:0] instruction
);

	wire [`LEN_ADDRESS - 1:0] inner_pc;
	wire [`LEN_INSTRUCTION - 1:0] inner_instruction;

    IF_Stage IF_stage(
		.clk(clk),
		.rst(rst),
		.freeze(freeze),
		.is_branch(is_branch),
		.branch_address(branch_address),

		.pc_out(inner_pc),
		.instruction_out(inner_instruction)
    );

    IF_Stage_Reg IF_stage_reg(
		.clk(clk),
		.rst(rst),
		.freeze(freeze),
		.flush(flush),
		.pc_in(inner_pc),
		.instruction_in(inner_instruction),

		.pc_out(pc),
		.instruction_out(instruction)
    );

endmodule
