`include "ISA.v"

module IF_Stage (
	input clk, rst,
	input freeze, is_branch,
	input [`LEN_ADDRESS - 1:0] branch_address,

	output [`LEN_ADDRESS - 1:0] pc_out,
	output [`LEN_INSTRUCTION - 1:0] instruction_out
);

	wire [`LEN_ADDRESS - 1:0] inner_pc;

	PC pc(
		.clk(clk),
		.rst(rst),
		.freeze(freeze),
		.is_branch(is_branch),
		.branch_address(branch_address),

		.pc(inner_pc),
		.next_pc(pc_out)
	);

	InstructionMemory instruction_memory(
		.address(inner_pc),

		.instruction(instruction_out)
	);

endmodule
