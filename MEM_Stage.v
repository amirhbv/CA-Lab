`include "ISA.v"

module MEM_Stage(
	input clk,
	input rst,

	input mem_read_in,
	input mem_write_in,
	input [`LEN_REGISTER - 1:0] alu_result_in, data_in,

	output [`LEN_REGISTER - 1:0] data_out
);

	reg [`LEN_REGISTER - 1:0] data [0:63];

	wire[31:0] actual_address = (alu_result_in - 1024) >> 2;

	assign data_out = (mem_read_in == `ENABLE) ? data[actual_address] : 32'b0;

	always@(posedge clk) begin
		if(mem_write_in) begin
			data[actual_address] <= data_in;
		end
	end

endmodule
