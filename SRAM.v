`include "ISA.v"

module SRAM(
	input clk,
	input rst,

	input write_enable,
	input [`LEN_SRAM_ADDRESS_BUS - 1:0] address_in,

    input SRAM_UB_N,
    input SRAM_LB_N,
    input SRAM_CE_N,
    input SRAM_OE_N,

	inout [`LEN_SRAM_DATA_BUS - 1:0] data
);

	reg[`LEN_SRAM_DATA_BUS - 1:0] data_memory[0:`SIZE_SRAM_DATA_MEMORY - 1];

	assign #30 data = (write_enable == `SRAM_DISABLE) ? data_memory[address_in] : `LEN_SRAM_DATA_BUS'bz;

	always@(posedge clk) begin
		if(write_enable == `SRAM_ENABLE) begin
			data_memory[address_in] = data;
		end
	end

endmodule
