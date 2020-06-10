	soc_system u0 (
		.clk_clk                           (<connected-to-clk_clk>),                           //                         clk.clk
		.i2c_0_i2c_serial_sda_in           (<connected-to-i2c_0_i2c_serial_sda_in>),           //            i2c_0_i2c_serial.sda_in
		.i2c_0_i2c_serial_scl_in           (<connected-to-i2c_0_i2c_serial_scl_in>),           //                            .scl_in
		.i2c_0_i2c_serial_sda_oe           (<connected-to-i2c_0_i2c_serial_sda_oe>),           //                            .sda_oe
		.i2c_0_i2c_serial_scl_oe           (<connected-to-i2c_0_i2c_serial_scl_oe>),           //                            .scl_oe
		.reset_reset_n                     (<connected-to-reset_reset_n>),                     //                       reset.reset_n
		.new_sdram_controller_0_wire_addr  (<connected-to-new_sdram_controller_0_wire_addr>),  // new_sdram_controller_0_wire.addr
		.new_sdram_controller_0_wire_ba    (<connected-to-new_sdram_controller_0_wire_ba>),    //                            .ba
		.new_sdram_controller_0_wire_cas_n (<connected-to-new_sdram_controller_0_wire_cas_n>), //                            .cas_n
		.new_sdram_controller_0_wire_cke   (<connected-to-new_sdram_controller_0_wire_cke>),   //                            .cke
		.new_sdram_controller_0_wire_cs_n  (<connected-to-new_sdram_controller_0_wire_cs_n>),  //                            .cs_n
		.new_sdram_controller_0_wire_dq    (<connected-to-new_sdram_controller_0_wire_dq>),    //                            .dq
		.new_sdram_controller_0_wire_dqm   (<connected-to-new_sdram_controller_0_wire_dqm>),   //                            .dqm
		.new_sdram_controller_0_wire_ras_n (<connected-to-new_sdram_controller_0_wire_ras_n>), //                            .ras_n
		.new_sdram_controller_0_wire_we_n  (<connected-to-new_sdram_controller_0_wire_we_n>)   //                            .we_n
	);

