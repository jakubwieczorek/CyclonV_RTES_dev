	component soc_system is
		port (
			clk_clk                           : in    std_logic                     := 'X';             -- clk
			i2c_0_i2c_serial_sda_in           : in    std_logic                     := 'X';             -- sda_in
			i2c_0_i2c_serial_scl_in           : in    std_logic                     := 'X';             -- scl_in
			i2c_0_i2c_serial_sda_oe           : out   std_logic;                                        -- sda_oe
			i2c_0_i2c_serial_scl_oe           : out   std_logic;                                        -- scl_oe
			reset_reset_n                     : in    std_logic                     := 'X';             -- reset_n
			new_sdram_controller_0_wire_addr  : out   std_logic_vector(11 downto 0);                    -- addr
			new_sdram_controller_0_wire_ba    : out   std_logic_vector(1 downto 0);                     -- ba
			new_sdram_controller_0_wire_cas_n : out   std_logic;                                        -- cas_n
			new_sdram_controller_0_wire_cke   : out   std_logic;                                        -- cke
			new_sdram_controller_0_wire_cs_n  : out   std_logic;                                        -- cs_n
			new_sdram_controller_0_wire_dq    : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			new_sdram_controller_0_wire_dqm   : out   std_logic_vector(1 downto 0);                     -- dqm
			new_sdram_controller_0_wire_ras_n : out   std_logic;                                        -- ras_n
			new_sdram_controller_0_wire_we_n  : out   std_logic                                         -- we_n
		);
	end component soc_system;

	u0 : component soc_system
		port map (
			clk_clk                           => CONNECTED_TO_clk_clk,                           --                         clk.clk
			i2c_0_i2c_serial_sda_in           => CONNECTED_TO_i2c_0_i2c_serial_sda_in,           --            i2c_0_i2c_serial.sda_in
			i2c_0_i2c_serial_scl_in           => CONNECTED_TO_i2c_0_i2c_serial_scl_in,           --                            .scl_in
			i2c_0_i2c_serial_sda_oe           => CONNECTED_TO_i2c_0_i2c_serial_sda_oe,           --                            .sda_oe
			i2c_0_i2c_serial_scl_oe           => CONNECTED_TO_i2c_0_i2c_serial_scl_oe,           --                            .scl_oe
			reset_reset_n                     => CONNECTED_TO_reset_reset_n,                     --                       reset.reset_n
			new_sdram_controller_0_wire_addr  => CONNECTED_TO_new_sdram_controller_0_wire_addr,  -- new_sdram_controller_0_wire.addr
			new_sdram_controller_0_wire_ba    => CONNECTED_TO_new_sdram_controller_0_wire_ba,    --                            .ba
			new_sdram_controller_0_wire_cas_n => CONNECTED_TO_new_sdram_controller_0_wire_cas_n, --                            .cas_n
			new_sdram_controller_0_wire_cke   => CONNECTED_TO_new_sdram_controller_0_wire_cke,   --                            .cke
			new_sdram_controller_0_wire_cs_n  => CONNECTED_TO_new_sdram_controller_0_wire_cs_n,  --                            .cs_n
			new_sdram_controller_0_wire_dq    => CONNECTED_TO_new_sdram_controller_0_wire_dq,    --                            .dq
			new_sdram_controller_0_wire_dqm   => CONNECTED_TO_new_sdram_controller_0_wire_dqm,   --                            .dqm
			new_sdram_controller_0_wire_ras_n => CONNECTED_TO_new_sdram_controller_0_wire_ras_n, --                            .ras_n
			new_sdram_controller_0_wire_we_n  => CONNECTED_TO_new_sdram_controller_0_wire_we_n   --                            .we_n
		);

