`include "ISA.v"

module TB();
	reg clk = 0, mem_clk = 0, rst, forwarding_enable = `ENABLE;

	ARM arm(clk, rst, forwarding_enable, mem_clk);

	always #20 clk = ~clk;
	always #40 mem_clk = ~mem_clk;

	initial begin
		rst = 0;
		#3;
		rst = 1;
		#19;
		rst = 0;
		#90000;
		$stop;
	end

endmodule
