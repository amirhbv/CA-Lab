`include "ISA.v"

module ConditionChecker (
    input [`LEN_COND - 1:0] condition_code,
    input [`LEN_STATUS - 1:0] status_register,
    output reg condition_result
);

	wire n, z, c, v;
	assign {n, z, c, v} = status_register;

    always @(condition_code) begin
        case(condition_code)
            `COND_EQ : condition_result <= z;
            `COND_NE : condition_result <= ~z;
            `COND_CS_HS : condition_result <= c;
            `COND_CC_LO : condition_result <= ~c;
            `COND_MI : condition_result <= n;
            `COND_PL : condition_result <= ~n;
            `COND_VS : condition_result <= v;
            `COND_VC : condition_result <= ~v;
            `COND_HI : condition_result <= c & ~z;
            `COND_LS : condition_result <= ~c & z;
            `COND_GE : condition_result <= (n & v) | (~n & ~v);
            `COND_LT : condition_result <= (n & ~v) | (~n & v);
            `COND_GT : condition_result <= ~z & ((n & v) | (~n & ~v));
            `COND_LE : condition_result <= z & ((n & ~v) | (~n & v));
            `COND_AL : condition_result <= 1'b1;
        endcase
    end

endmodule
