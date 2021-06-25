`include "ISA.v"

module TB();
	reg clk = 0, rst, forwarding_enable = `ENABLE;

	ARM arm(clk, rst, forwarding_enable);

	always #10 clk = ~clk;

	initial begin
		rst = 0;
		#3;
		rst = 1;
		#19;
		rst = 0;
		#10000;
		$stop;
	end

endmodule
