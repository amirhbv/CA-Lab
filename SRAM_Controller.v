`include "ISA.v"

module SRAM_Controller(
    input clk, rst,

    input mem_read, mem_write,
    input [`LEN_ADDRESS - 1:0] address,
    input [`LEN_REGISTER - 1:0] data_in,

    output [`LEN_REGISTER - 1:0] data_out,
	output mem_ready,

    output SRAM_UB_N,
    output SRAM_LB_N,
    output SRAM_WE_N,
    output SRAM_CE_N,
    output SRAM_OE_N,

    inout [`LEN_SRAM_DATA_BUS - 1:0] SRAM_DQ,
    output [`LEN_SRAM_ADDRESS_BUS - 1:0] SRAM_ADDR
);

    wire [`LEN_SRAM_STATE - 1:0] sram_state, next_sram_state;
    wire [`LEN_SRAM_COUNTER - 1:0] sram_counter, next_sram_counter;

	assign SRAM_UB_N = `SRAM_ENABLE;
	assign SRAM_LB_N = `SRAM_ENABLE;
	assign SRAM_CE_N = `SRAM_ENABLE;
	assign SRAM_OE_N = `SRAM_ENABLE;

	assign SRAM_WE_N = sram_state == `STATE_SRAM_WRITE ? `SRAM_ENABLE : sram_state == `STATE_SRAM_READ ? `SRAM_DISABLE : 1'bz;
	assign SRAM_DQ = sram_state == `STATE_SRAM_WRITE ? data_in : `LEN_REGISTER'bz;
	assign data_out = sram_state == `STATE_SRAM_READ ? SRAM_DQ : `LEN_REGISTER'bz;
	assign SRAM_ADDR = address[`LEN_SRAM_ADDRESS_BUS - 1:0];

    Register #(.WORD_LENGTH(`LEN_SRAM_STATE)) sram_state_reg(
		.clk(clk), .rst(rst), .ld(1'b1),
		.in(next_sram_state),

		.out(sram_state)
	);

    assign next_sram_state = (rst == `ENABLE) ? `STATE_SRAM_IDLE
        : (
            (sram_state == `STATE_SRAM_IDLE && mem_read == `ENABLE) 		? `STATE_SRAM_READ
            : (sram_state == `STATE_SRAM_IDLE && mem_write == `ENABLE) 		? `STATE_SRAM_WRITE
            : (sram_state == `STATE_SRAM_IDLE)								? `STATE_SRAM_IDLE
            : (sram_state == `STATE_SRAM_READ && (sram_counter == 3'd6)) 	? `STATE_SRAM_IDLE
            : (sram_state == `STATE_SRAM_READ)								? `STATE_SRAM_READ
            : (sram_state == `STATE_SRAM_WRITE && (sram_counter == 3'd6))	? `STATE_SRAM_IDLE
            : (sram_state == `STATE_SRAM_WRITE)								? `STATE_SRAM_WRITE
            : `STATE_SRAM_IDLE
        );

    Register #(.WORD_LENGTH(`LEN_SRAM_COUNTER)) sram_counter_reg(
		.clk(clk), .rst(rst), .ld(1'b1),
		.in(next_sram_counter),

		.out(sram_counter)
	);

    assign next_sram_counter = (sram_state == `STATE_SRAM_IDLE)		? 3'd0
        : (sram_state == `STATE_SRAM_READ && sram_counter == 3'd6) 	? 3'd0
        : (sram_state == `STATE_SRAM_READ)                         	? sram_counter + 3'd1
        : (sram_state == `STATE_SRAM_WRITE && sram_counter == 3'd6)	? 3'd0
        : (sram_state == `STATE_SRAM_WRITE)                        	? sram_counter + 3'd1
        : 3'd0;


	assign mem_ready = (rst == `ENABLE) ? `ENABLE
        : (
            ((sram_state == `STATE_SRAM_IDLE) && (mem_read == `ENABLE || mem_write == `ENABLE))	? `DISABLE
            : (sram_state == `STATE_SRAM_IDLE)                                                  ? `ENABLE
            : (sram_state == `STATE_SRAM_READ && (sram_counter == 3'd6))                  		? `ENABLE
            : (sram_state == `STATE_SRAM_READ)                                            		? `DISABLE
            : (sram_state == `STATE_SRAM_WRITE && (sram_counter == 3'd6))                 		? `ENABLE
            : (sram_state == `STATE_SRAM_WRITE)                                           		? `DISABLE
            : `ENABLE
        );

endmodule
