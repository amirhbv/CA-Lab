`include "ISA.v"

module IF_Stage_Reg (
	input clk, rst,
    input freeze, flush,
	input [`LEN_ADDRESS - 1:0] pc_in,
	input [`LEN_INSTRUCTION - 1:0] instruction_in,

	output [`LEN_ADDRESS - 1:0] pc_out,
	output [`LEN_INSTRUCTION - 1:0] instruction_out
);

	RegisterFlush #(.WORD_LENGTH(`LEN_ADDRESS)) pc_register(
		.clk(clk), .rst(rst),
		.ld(~freeze), .flush(flush),
		.in(pc_in),

		.out(pc_out)
	);

	RegisterFlush #(.WORD_LENGTH(`LEN_INSTRUCTION)) instruction_register(
		.clk(clk), .rst(rst),
		.ld(~freeze), .flush(flush),
		.in(instruction_in),

		.out(instruction_out)
	);

endmodule
