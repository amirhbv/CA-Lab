`include "ISA.v"

module Val2Generator(
	input [`LEN_ADDRESS - 1:0] op,
	input is_immediate,
	input is_mem_command,
	input [`LEN_SHIFT_OPERAND - 1:0] shift_operand,

	output [`LEN_ADDRESS - 1:0] result
);

	function [31:0] rotate_right(input [31:0] data, input [4:0] shift);
		reg [63:0] tmp;
		begin
			tmp = {data, data} >> shift;
			rotate_right = tmp[31:0];
		end
	endfunction

	wire[7:0] immediate_32_op = shift_operand[7:0];
	wire[4:0] rotation_count = {shift_operand[11:8] , 1'b0};
	wire [`LEN_ADDRESS - 1:0] immediate_32_result = rotate_right(immediate_32_op, rotation_count);


	wire [4:0] immediate_shift_count = shift_operand[11:7];
	wire [1:0] shift_state = shift_operand[6:5];
	wire [3:0] rm = shift_operand[3:0];
	wire b4 = shift_operand[4];

	wire [`LEN_ADDRESS - 1:0] immediate_shift_result =
		(shift_state == `STATE_LSL_SHIFT) ? op << immediate_shift_count :
		(shift_state == `STATE_LSR_SHIFT) ? op >> immediate_shift_count :
		(shift_state == `STATE_ASR_SHIFT) ? op >>> immediate_shift_count :
		(shift_state == `STATE_ROR_SHIFT) ? rotate_right(op , immediate_shift_count) :
		32'b0;

	wire offset_12 = {shift_operand, 20'b0} >>> 20;

	assign result = (is_mem_command) ? offset_12 :
		(is_immediate) ? immediate_32_result :
		(~is_immediate) & (~b4) ? immediate_shift_result :
		32'b0;

endmodule
