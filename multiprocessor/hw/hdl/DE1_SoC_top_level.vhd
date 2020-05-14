-- #############################################################################
-- DE1_SoC_top_level.vhd
--
-- BOARD         : DE1-SoC from Terasic
-- Author        : Sahand Kashani-Akhavan from Terasic documentation
-- Revision      : 1.4
-- Creation date : 04/02/2015
--
-- Syntax Rule : GROUP_NAME_N[bit]
--
-- GROUP  : specify a particular interface (ex: SDR_)
-- NAME   : signal name (ex: CONFIG, D, ...)
-- bit    : signal index
-- _N     : to specify an active-low signal
-- #############################################################################

library ieee;
use ieee.std_logic_1164.all;

entity DE1_SoC_top_level is
    port(

        -- CLOCK
        CLOCK_50         : in    std_logic;

        -- SDRAM
--        DRAM_ADDR        : out   std_logic_vector(12 downto 0);
--        DRAM_BA          : out   std_logic_vector(1 downto 0);
--        DRAM_CAS_N       : out   std_logic;
--        DRAM_CKE         : out   std_logic;
--        DRAM_CLK         : out   std_logic;
--        DRAM_CS_N        : out   std_logic;
--        DRAM_DQ          : inout std_logic_vector(15 downto 0);
--        DRAM_LDQM        : out   std_logic;
--        DRAM_RAS_N       : out   std_logic;
--        DRAM_UDQM        : out   std_logic;
--        DRAM_WE_N        : out   std_logic;


        -- KEY_N
        KEY_N            : in    std_logic_vector(3 downto 0);

        -- LED
        LEDR             : out   std_logic_vector(9 downto 0)
--
--        -- GPIO_0
--        GPIO_0           : inout std_logic_vector(35 downto 0);
--
--        -- GPIO_1
--        GPIO_1           : inout std_logic_vector(35 downto 0);
    );
end entity DE1_SoC_top_level;

architecture rtl of DE1_SoC_top_level is

	component soc_system is
		port (
			clk_clk                           : in  std_logic                    := 'X'; -- clk
			leds_0_external_connection_export : out std_logic_vector(7 downto 0);        -- export
			reset_reset_n                     : in  std_logic                    := 'X'  -- reset_n
		);
	end component soc_system;
	

begin

	u0 : component soc_system
		port map (
			clk_clk                           => CLOCK_50,                           --                        clk.clk
			leds_0_external_connection_export => LEDR(7 downto 0), -- leds_0_external_connection.export
			reset_reset_n                     => KEY_N(0)                      --                      reset.reset_n
		);

end;
