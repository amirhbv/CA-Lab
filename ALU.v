`include "ISA.v"

module ALU(
	input [`LEN_EXECUTE_COMMAND - 1:0] command,
	input [`LEN_REGISTER - 1:0] op1, op2,
	input [`LEN_STATUS - 1:0] status_reg_in,

	output [`LEN_REGISTER - 1:0] result,
	output [`LEN_STATUS - 1:0] status_bits
);

	wire cin = status_reg_in[1];

	wire c;
	assign {c, result} =
		(command == `EXE_MOV) ? op2 :
		(command == `EXE_MVN) ? ~op2 :
		(command == `EXE_ADD) ? op1 + op2 :
		(command == `EXE_ADC) ? op1 + op2 + cin :
		(command == `EXE_SUB) ? op1 - op2 :
		(command == `EXE_SBC) ? op1 - op2 - (cin ? `LEN_REGISTER'b0 : `LEN_REGISTER'b1) :
		(command == `EXE_AND) ? op1 & op2 :
		(command == `EXE_ORR) ? op1 | op2 :
		(command == `EXE_EOR) ? op1 ^ op2 :
		(command == `EXE_CMP) ? op1 - op2 :
		(command == `EXE_TST) ? op1 & op2 :
		(command == `EXE_LDR) ? op1 + op2 :
		(command == `EXE_STR) ? op1 + op2 :
		`LEN_REGISTER'b0;

	wire add_mode = (command == `EXE_ADD) | (command == `EXE_ADC);
	wire sub_mode = (command == `EXE_SUB) | (command == `EXE_SBC) | (command == `EXE_CMP);

	wire n = (result[31]);
	wire z = (result == 0);
	wire v =
		(add_mode) ? ( (op1[31] & op2[31] & ~result[31]) | (~op1[31] & ~op2[31] & result[31]) ) :
		(sub_mode) ? ( (op1[31] & ~op2[31] & ~result[31]) | (~op1[31] & op2[31] & result[31]) ) :
		1'b0;

  	assign status_bits = {n, z, c, v};

endmodule
