`include "ISA.v"

module PC (
    input clk, rst,
	input freeze, is_branch,
	input [`LEN_ADDRESS - 1:0] branch_address,

	output [`LEN_ADDRESS - 1:0] pc,
	output [`LEN_ADDRESS - 1:0] next_pc
);
	wire [`LEN_ADDRESS - 1:0] inner_pc;

 	assign next_pc = pc + 4;
 	assign inner_pc = is_branch ? branch_address : next_pc;

	Register #(.WORD_LENGTH(`LEN_ADDRESS)) pc_register(
		.clk(clk), .rst(rst),
		.ld(~freeze),
		.in(inner_pc),

		.out(pc)
	);

endmodule
