library ieee;
use ieee.std_logic_1164.all;

entity DE1_SoC_top_level is
    port(
        CLOCK_50         : in    std_logic;
		  
		  -- KEY_n
        KEY_N            : in    std_logic_vector(3 downto 0);
		  
		  -- LED
        LEDR             : out   std_logic_vector(9 downto 0);
		  
		  -- SDRAM
        DRAM_ADDR        : out   std_logic_vector(12 downto 0);
        DRAM_BA          : out   std_logic_vector(1 downto 0);
        DRAM_CAS_N       : out   std_logic;
        DRAM_CKE         : out   std_logic;
        DRAM_CLK         : out   std_logic;
        DRAM_CS_N        : out   std_logic;
        DRAM_DQ          : inout std_logic_vector(15 downto 0);
        DRAM_LDQM        : out   std_logic;
        DRAM_RAS_N       : out   std_logic;
        DRAM_UDQM        : out   std_logic;
        DRAM_WE_N        : out   std_logic;
		  
		  -- GPIO_0
		  GPIO_0 : inout std_logic_vector(7 downto 0)
    );
end DE1_SoC_top_level;

architecture rtl of DE1_SoC_top_level is

	component soc_system is
		port (
			clk_clk                              : in    std_logic                     := 'X';             -- clk
			reset_reset_n                        : in    std_logic                     := 'X';             -- reset_n
			sdram_controller_0_wire_addr         : out   std_logic_vector(12 downto 0);                    -- addr
			sdram_controller_0_wire_ba           : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_controller_0_wire_cas_n        : out   std_logic;                                        -- cas_n
			sdram_controller_0_wire_cke          : out   std_logic;                                        -- cke
			sdram_controller_0_wire_cs_n         : out   std_logic;                                        -- cs_n
			sdram_controller_0_wire_dq           : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			sdram_controller_0_wire_dqm          : out   std_logic_vector(1 downto 0);                     -- dqm
			sdram_controller_0_wire_ras_n        : out   std_logic;                                        -- ras_n
			sdram_controller_0_wire_we_n         : out   std_logic;                                        -- we_n
			parallel_port_0_conduit_end_export_export   : inout std_logic_vector(7 downto 0);				  -- export
			nios_leds_external_connection_export    : out   std_logic_vector(9 downto 0);                     -- export
			pll_0_sdram_clk_clk                    : out   std_logic;                                         -- clk
			nios_buttons_external_connection_export : in    std_logic_vector(2 downto 0)  := (others => 'X')  -- export
		);
	end component;
	
begin

	u0 : soc_system
		port map (
			clk_clk                              => CLOCK_50,                              --                           clk.clk
			reset_reset_n                        => KEY_N(0),                        --                         reset.reset_n
			sdram_controller_0_wire_addr         => DRAM_ADDR,         --       sdram_controller_0_wire.addr
			sdram_controller_0_wire_ba           => DRAM_BA,           --                              .ba
			sdram_controller_0_wire_cas_n        => DRAM_CAS_N,        --                              .cas_n
			sdram_controller_0_wire_cke          => DRAM_CKE,          --                              .cke
			sdram_controller_0_wire_cs_n         => DRAM_CS_N,         --                              .cs_n
			sdram_controller_0_wire_dq           => DRAM_DQ,           --                              .dq
			sdram_controller_0_wire_dqm(1)          => DRAM_UDQM,          --                              .dqm
			sdram_controller_0_wire_dqm(0)          => DRAM_LDQM,          --                              .dqm
			sdram_controller_0_wire_ras_n        => DRAM_RAS_N,        --                              .ras_n
			sdram_controller_0_wire_we_n         => DRAM_WE_N,         --                              .we_n
			parallel_port_0_conduit_end_export_export   => GPIO_0,   --   parallel_port_0_conduit_end.export
			nios_leds_external_connection_export => LEDR,  -- nios_leds_external_connection.export
			pll_0_sdram_clk_clk							 => DRAM_CLK,
			nios_buttons_external_connection_export => KEY_N(3 DOWNTO 1)
		);

end rtl;
