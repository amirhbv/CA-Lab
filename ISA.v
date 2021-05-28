`timescale 1ns/1ns

`define LEN_ADDRESS	32
`define LEN_INSTRUCTION	32
`define LEN_STATUS 4

`define LEN_SHIFT_OPERAND 12
`define LEN_SIGNED_IMMEDIATE 24

`define LEN_INSTRUCTION_MEM 8
`define SIZE_INSTRUCTION_MEM 256

`define SIZE_DATA_MEMORY 512
`define LEN_DATA_MEMORY 8

`define LEN_REG_ADDRESS 4
`define LEN_REGISTER 32
`define SIZE_REGISTER_MEM 16

`define LEN_MODE 2
`define MODE_ARITHMETHIC 2'b00
`define MODE_MEMORY 2'b01
`define MODE_BRANCH 2'b10

// Instruction OpCode
`define LEN_OPCODE 4
`define OP_MOV 4'b1101
`define OP_MVN 4'b1111
`define OP_ADD 4'b0100
`define OP_ADC 4'b0101
`define OP_SUB 4'b0010
`define OP_SBC 4'b0110
`define OP_AND 4'b0000
`define OP_ORR 4'b1100
`define OP_EOR 4'b0001
`define OP_CMP 4'b1010
`define OP_TST 4'b1000
`define OP_LDR 4'b0100
`define OP_STR 4'b0100

// ALU OpCode
`define LEN_EXECUTE_COMMAND 4
`define EXE_MOV 4'b0001
`define EXE_MVN 4'b1001
`define EXE_ADD 4'b0010
`define EXE_ADC 4'b0011
`define EXE_SUB 4'b0100
`define EXE_SBC 4'b0101
`define EXE_AND 4'b0110
`define EXE_ORR 4'b0111
`define EXE_EOR 4'b1000
`define EXE_CMP 4'b1100
`define EXE_TST 4'b1110
`define EXE_LDR 4'b1010
`define EXE_STR 4'b1010

// Conditions
`define LEN_COND 4
`define COND_EQ 4'b0000
`define COND_NE 4'b0001
`define COND_CS_HS 4'b0010
`define COND_CC_LO 4'b0011
`define COND_MI 4'b0100
`define COND_PL 4'b0101
`define COND_VS 4'b0110
`define COND_VC 4'b0111
`define COND_HI 4'b1000
`define COND_LS 4'b1001
`define COND_GE 4'b1010
`define COND_LT 4'b1011
`define COND_GT 4'b1100
`define COND_LE 4'b1101
`define COND_AL 4'b1110

`define ENABLE 1'b1
`define DISABLE 1'b0

`define STATE_LSL_SHIFT 2'b00
`define STATE_LSR_SHIFT 2'b01
`define STATE_ASR_SHIFT 2'b10
`define STATE_ROR_SHIFT 2'b11
