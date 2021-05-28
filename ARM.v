`include "ISA.v"

module ARM(
  input clk, rst
);

	wire freeze = 0, is_branch = 0, flush = 0;
    wire[`LEN_ADDRESS - 1:0] branch_address = 0;
    wire[`LEN_ADDRESS - 1:0] pc;
    wire[`LEN_INSTRUCTION - 1:0] instruction;

	IF_Stage_Module IF_stage_module(
		.clk(clk),
		.rst(rst),
		.freeze(freeze),
		.is_branch(is_branch),
		.flush(flush),
		.branch_address(branch_address),

		.pc(pc),
		.instruction(instruction)
	);

endmodule
