`include "ISA.v"

module InstructionMemory (
	input [`LEN_ADDRESS - 1:0] address,

	output [`LEN_INSTRUCTION - 1:0] instruction
);
	reg[`LEN_INSTRUCTION_MEM - 1:0] data[0:`SIZE_INSTRUCTION_MEM - 1];

	assign instruction = {
		data[{address[`LEN_ADDRESS - 1:2], 2'b00}],
		data[{address[`LEN_ADDRESS - 1:2], 2'b01}],
		data[{address[`LEN_ADDRESS - 1:2], 2'b10}],
		data[{address[`LEN_ADDRESS - 1:2], 2'b11}]
	};

	initial begin
		data[0] <= 8'b11100000;
		data[1] <= 8'b00000000;
		data[2] <= 8'b00000000;
		data[3] <= 8'b00000000;

		{data[ 4], data[ 5], data[ 6], data[ 7]}      = 32'b1110_00_1_1101_0_0000_0000_000000010100;
		{data[ 8], data[ 9], data[10], data[11]}      = 32'b1110_00_1_1101_0_0000_0001_101000000001;
		{data[12], data[13], data[14], data[15]}      = 32'b1110_00_1_1101_0_0000_0010_000100000011;
		{data[16], data[17], data[18], data[19]}      = 32'b1110_00_0_0100_1_0010_0011_000000000010;
		{data[20], data[21], data[22], data[23]}      = 32'b1110_00_0_0101_0_0000_0100_000000000000;
		{data[24], data[25], data[26], data[27]}      = 32'b1110_00_0_0010_0_0100_0101_000100000100;
		{data[28], data[29], data[30], data[31]}      = 32'b1110_00_0_0110_0_0000_0110_000010100000;
		{data[32], data[33], data[34], data[35]}      = 32'b1110_00_0_1100_0_0101_0111_000101000010;
		{data[36], data[37], data[38], data[39]}      = 32'b1110_00_0_0000_0_0111_1000_000000000011;
		{data[40], data[41], data[42], data[43]}      = 32'b1110_00_0_1111_0_0000_1001_000000000110;
		{data[44], data[45], data[46], data[47]}      = 32'b1110_00_0_0001_0_0100_1010_000000000101;
		{data[48], data[49], data[50], data[51]}      = 32'b1110_00_0_1010_1_1000_0000_000000000110;
		{data[52], data[53], data[54], data[55]}      = 32'b0001_00_0_0100_0_0001_0001_000000000001;
		{data[56], data[57], data[58], data[59]}      = 32'b1110_00_0_1000_1_1001_0000_000000001000;
		{data[60], data[61], data[62], data[63]}      = 32'b0000_00_0_0100_0_0010_0010_000000000010;
		{data[64], data[65], data[66], data[67]}      = 32'b1110_00_1_1101_0_0000_0000_101100000001;
		{data[68], data[69], data[70], data[71]}      = 32'b1110_01_0_0100_0_0000_0001_000000000000;
		{data[72], data[73], data[74], data[75]}      = 32'b1110_01_0_0100_1_0000_1011_000000000000;
		{data[76], data[77], data[78], data[79]}      = 32'b1110_01_0_0100_0_0000_0010_000000000100;
		{data[80], data[81], data[82], data[83]}      = 32'b1110_01_0_0100_0_0000_0011_000000001000;
		{data[84], data[85], data[86], data[87]}      = 32'b1110_01_0_0100_0_0000_0100_000000001101;
		{data[88], data[89], data[90], data[91]}      = 32'b1110_01_0_0100_0_0000_0101_000000010000;
		{data[92], data[93], data[94], data[95]}      = 32'b1110_01_0_0100_0_0000_0110_000000010100;
		{data[96], data[97], data[98], data[99]}      = 32'b1110_01_0_0100_1_0000_1010_000000000100;
		{data[100], data[101], data[102], data[103]}  = 32'b1110_01_0_0100_0_0000_0111_000000011000;

		{data[104], data[105], data[106], data[107]}  = 32'b1110_00_1_1101_0_0000_0001_000000000100;
		{data[108], data[109], data[110], data[111]}  = 32'b1110_00_1_1101_0_0000_0010_000000000000;
		{data[112], data[113], data[114], data[115]}  = 32'b1110_00_1_1101_0_0000_0011_000000000000;
		{data[116], data[117], data[118], data[119]}  = 32'b1110_00_0_0100_0_0000_0100_000100000011;
		{data[120], data[121], data[122], data[123]}  = 32'b1110_01_0_0100_1_0100_0101_000000000000;
		{data[124], data[125], data[126], data[127]}  = 32'b1110_01_0_0100_1_0100_0110_000000000100;
		{data[128], data[129], data[130], data[131]}  = 32'b1110_00_0_1010_1_0101_0000_000000000110;
		{data[132], data[133], data[134], data[135]}  = 32'b1100_01_0_0100_0_0100_0110_000000000000;
		{data[136], data[137], data[138], data[139]}  = 32'b1100_01_0_0100_0_0100_0101_000000000100;
		{data[140], data[141], data[142], data[143]}  = 32'b1110_00_1_0100_0_0011_0011_000000000001;
		{data[144], data[145], data[146], data[147]}  = 32'b1110_00_1_1010_1_0011_0000_000000000011;
		{data[148], data[149], data[150], data[151]}  = 32'b1011_10_1_0_111111111111111111110111;
		{data[152], data[153], data[154], data[155]}  = 32'b1110_00_1_0100_0_0010_0010_000000000001;
		{data[156], data[157], data[158], data[159]}  = 32'b1110_00_0_1010_1_0010_0000_000000000001;
		{data[160], data[161], data[162], data[163]}  = 32'b1011_10_1_0_111111111111111111110011;
		{data[164], data[165], data[166], data[167]}  = 32'b1110_01_0_0100_1_0000_0001_000000000000;
		{data[168], data[169], data[170], data[171]}  = 32'b1110_01_0_0100_1_0000_0010_000000000100;
		{data[172], data[173], data[174], data[175]}  = 32'b1110_01_0_0100_1_0000_0011_000000001000;
		{data[176], data[177], data[178], data[179]}  = 32'b1110_01_0_0100_1_0000_0100_000000001100;
		{data[180], data[181], data[182], data[183]}  = 32'b1110_01_0_0100_1_0000_0101_000000010000;
		{data[184], data[185], data[186], data[187]}  = 32'b1110_01_0_0100_1_0000_0110_000000010100;
		{data[188], data[189], data[190], data[191]}  = 32'b1110_10_1_0_111111111111111111111111;

		data[196] <= 8'b11100000;
		data[197] <= 8'b00000000;
		data[198] <= 8'b00000000;
		data[199] <= 8'b00000000;

		data[200] <= 8'b11100000;
		data[201] <= 8'b00000000;
		data[202] <= 8'b00000000;
		data[203] <= 8'b00000000;

		data[204] <= 8'b11100000;
		data[205] <= 8'b00000000;
		data[206] <= 8'b00000000;
		data[207] <= 8'b00000000;

		data[208] <= 8'b11100000;
		data[209] <= 8'b00000000;
		data[210] <= 8'b00000000;
		data[211] <= 8'b00000000;

	end
endmodule
