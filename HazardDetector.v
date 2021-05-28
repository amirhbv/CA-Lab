`include "ISA.v"

module HazardDetector(
	input EX_wb_enable,
	input MEM_wb_enable,
	input[`LEN_REG_ADDRESS - 1:0] reg_file_src1, // Rn
	input[`LEN_REG_ADDRESS - 1:0] reg_file_src2, // Rm
	input[`LEN_REG_ADDRESS - 1:0] EX_reg_dest,
	input[`LEN_REG_ADDRESS - 1:0] MEM_reg_dest,
	input has_two_src,

	output reg hazard_detected
);

	always @(*) begin
		hazard_detected = 1'b0;

		if(EX_wb_enable) begin
			if(EX_reg_dest == reg_file_src1)
				hazard_detected = 1'b1;
			if(has_two_src == `ENABLE && (EX_reg_dest == reg_file_src2))
				hazard_detected = 1'b1;
		end

		if(MEM_wb_enable) begin
			if(MEM_reg_dest == reg_file_src1)
				hazard_detected = 1'b1;
			if(has_two_src == `ENABLE && (MEM_reg_dest == reg_file_src2))
				hazard_detected = 1'b1;
		end
	end

endmodule
