`include "ISA.v"

module TB();
	reg clk = 0, rst;

	ARM arm(clk, rst);

	always #10 clk = ~clk;

	initial begin
		rst = 0;
		#3;
		rst = 1;
		#19;
		rst = 0;
		#2000;
		$stop;
	end

endmodule
