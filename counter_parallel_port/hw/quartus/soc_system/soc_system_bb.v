
module soc_system (
	clk_clk,
	nios_buttons_external_connection_export,
	nios_leds_external_connection_export,
	parallel_port_0_conduit_end_export_export,
	pll_0_sdram_clk_clk,
	reset_reset_n,
	sdram_controller_0_wire_addr,
	sdram_controller_0_wire_ba,
	sdram_controller_0_wire_cas_n,
	sdram_controller_0_wire_cke,
	sdram_controller_0_wire_cs_n,
	sdram_controller_0_wire_dq,
	sdram_controller_0_wire_dqm,
	sdram_controller_0_wire_ras_n,
	sdram_controller_0_wire_we_n);	

	input		clk_clk;
	input	[2:0]	nios_buttons_external_connection_export;
	output	[9:0]	nios_leds_external_connection_export;
	inout	[7:0]	parallel_port_0_conduit_end_export_export;
	output		pll_0_sdram_clk_clk;
	input		reset_reset_n;
	output	[12:0]	sdram_controller_0_wire_addr;
	output	[1:0]	sdram_controller_0_wire_ba;
	output		sdram_controller_0_wire_cas_n;
	output		sdram_controller_0_wire_cke;
	output		sdram_controller_0_wire_cs_n;
	inout	[15:0]	sdram_controller_0_wire_dq;
	output	[1:0]	sdram_controller_0_wire_dqm;
	output		sdram_controller_0_wire_ras_n;
	output		sdram_controller_0_wire_we_n;
endmodule
