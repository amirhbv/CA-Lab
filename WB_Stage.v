`include "ISA.v"

module WB_Stage_Module(
	input mem_read_in,
	input [`LEN_REGISTER - 1:0] alu_result_in, memory_data_in,

	output[31:0] wb_data_out
);

	assign wb_data_out = (mem_read_in == `ENABLE) ? memory_data_in : alu_result_in;

endmodule

