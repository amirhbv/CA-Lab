`include "ISA.v"

module StatusRegister (
    input clk, rst,
    input ld,
    input [`LEN_STATUS - 1:0] data_in,

    output reg [`LEN_STATUS - 1:0] data_out
);

	always@(negedge clk, posedge rst) begin
		if (rst) begin
			data_out <= 0;
		end else if (ld) begin
			data_out <= data_in;
		end
	end

endmodule
