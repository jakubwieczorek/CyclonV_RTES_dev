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

        -- Audio
        AUD_ADCDAT       : in    std_logic;
		  AUD_ADCLRCK      : inout std_logic; --44.1kHz
        AUD_BCLK         : inout std_logic;
        AUD_DACDAT       : out   std_logic;
        AUD_DACLRCK      : inout std_logic;
        AUD_XCK          : out   std_logic;

        -- CLOCK
        CLOCK_50         : in    std_logic;

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

        -- I2C for Audio and Video-In
        FPGA_I2C_SCLK    : out   std_logic;
        FPGA_I2C_SDAT    : inout std_logic;

        -- KEY_N
        KEY_N            : in    std_logic_vector(3 downto 0);

        -- LED
        LEDR             : out   std_logic_vector(9 downto 0)
    );
end entity DE1_SoC_top_level;

architecture rtl of DE1_SoC_top_level is

begin

end;
