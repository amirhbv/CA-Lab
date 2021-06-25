`include "ISA.v"

module ForwardingUnit(
	input forwarding_enable,
	input MEM_wb_enable,
	input WB_wb_enable,
	input[`LEN_REG_ADDRESS - 1:0] reg_file_src1, // Rn
	input[`LEN_REG_ADDRESS - 1:0] reg_file_src2, // Rm
	input[`LEN_REG_ADDRESS - 1:0] MEM_reg_dest,
	input[`LEN_REG_ADDRESS - 1:0] WB_reg_dest,

	output reg[`LEN_FORW_SEL - 1:0] sel_op1, sel_op2
);
	always @(*) begin
		sel_op1 = `FORW_SEL_FROM_ID;
		sel_op2 = `FORW_SEL_FROM_ID;

		if (forwarding_enable == `ENABLE) begin
			if(WB_wb_enable) begin
				if(WB_reg_dest == reg_file_src1)
					sel_op1 = `FORW_SEL_FROM_WB;
				if(WB_reg_dest == reg_file_src2)
					sel_op2 = `FORW_SEL_FROM_WB;
			end

			if(MEM_wb_enable) begin
				if(MEM_reg_dest == reg_file_src1)
					sel_op1 = `FORW_SEL_FROM_MEM;
				if(MEM_reg_dest == reg_file_src2)
					sel_op2 = `FORW_SEL_FROM_MEM;
			end
		end
	end
endmodule
