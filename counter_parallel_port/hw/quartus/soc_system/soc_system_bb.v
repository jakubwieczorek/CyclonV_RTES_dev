
module soc_system (
	clk_clk,
	parallel_port_0_conduit_end_beginbursttransfer,
	pio_0_external_connection_export,
	reset_reset_n);	

	input		clk_clk;
	inout	[31:0]	parallel_port_0_conduit_end_beginbursttransfer;
	output	[9:0]	pio_0_external_connection_export;
	input		reset_reset_n;
endmodule
