`include "ISA.v"

module RegisterFile (
	input clk, rst,
    input [`LEN_REG_ADDRESS - 1:0] src1, src2,

    input wb_en,
    input [`LEN_REG_ADDRESS - 1:0] wb_address,
	input [`LEN_REGISTER - 1:0] wb_data,

	output [`LEN_REGISTER - 1:0] reg1, reg2
);
    integer counter = 0;
    reg[`LEN_REGISTER - 1:0] data[0:`SIZE_REGISTER_MEM - 1];

    assign reg1 = data[src1];
    assign reg2 = data[src2];

    always @(negedge clk, posedge rst) begin
		if (rst) begin
			for(counter = 0; counter < `SIZE_REGISTER_MEM; counter = counter + 1) begin
				data[counter] <= counter;
			end
        end else if (wb_en) begin
			data[wb_address] = wb_data;
		end
	end

endmodule
