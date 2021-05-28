`include "ISA.v"

module ControlUnit(
	input [`LEN_MODE - 1:0] mode,
	input is_second_op_immediate,
	input [`LEN_OPCODE - 1:0] opcode,
	input should_update_status_register,

	output is_immediate,
	output status_write_enable,
	output reg [`LEN_EXECUTE_COMMAND - 1:0] execute_command,
	output reg mem_read,
	output reg mem_write,
	output reg wb_enable,
	output reg is_branch
);

    assign is_immediate = is_second_op_immediate;
    assign status_write_enable = should_update_status_register;

    always @(mode, opcode, should_update_status_register) begin
		mem_read = `DISABLE;
		mem_write = `DISABLE;
		wb_enable = `DISABLE;
		is_branch = `DISABLE;

		case (mode)
			`MODE_ARITHMETHIC : begin
				case(opcode)
					`OP_MOV : begin
						execute_command = `EXE_MOV;
						wb_enable = `ENABLE;
					end

					`OP_MVN : begin
						execute_command = `EXE_MVN;
						wb_enable = `ENABLE;
					end

					`OP_ADD : begin
						execute_command = `EXE_ADD;
						wb_enable = `ENABLE;
					end

					`OP_ADC : begin
						execute_command = `EXE_ADC;
						wb_enable = `ENABLE;
					end

					`OP_SUB : begin
						execute_command = `EXE_SUB;
						wb_enable = `ENABLE;
					end

					`OP_SBC : begin
						execute_command = `EXE_SBC;
						wb_enable = `ENABLE;
					end

					`OP_AND : begin
						execute_command = `EXE_AND;
						wb_enable = `ENABLE;
					end

					`OP_ORR : begin
						execute_command = `EXE_ORR;
						wb_enable = `ENABLE;
					end

					`OP_EOR : begin
						execute_command = `EXE_EOR;
						wb_enable = `ENABLE;
					end

					`OP_CMP : begin
						execute_command = `EXE_CMP;
					end

					`OP_TST : begin
						execute_command = `EXE_TST;
					end

					`OP_LDR : begin
						execute_command = `EXE_LDR;
						wb_enable = `ENABLE;
					end

					`OP_STR : begin
						execute_command = `EXE_STR;
					end

				endcase
			end

			`MODE_MEMORY : begin
				execute_command = `EXE_ADD;
				case (should_update_status_register)
					`ENABLE : begin
						mem_read = `ENABLE;
						wb_enable = `ENABLE;
					end
					`DISABLE : begin
						mem_write = `ENABLE;
					end
				endcase
			end

			`MODE_BRANCH : begin
				is_branch = `ENABLE;
			end
		endcase

    end
endmodule
