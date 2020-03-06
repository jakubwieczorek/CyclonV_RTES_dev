library ieee;
use ieee.std_logic_1164.all;

entity DE1_SoC_top_level is
    port(
        CLOCK_50         : in    std_logic;
        KEY_N            : in    std_logic_vector(3 downto 0);
        LEDR             : out   std_logic_vector(9 downto 0)
    );
end entity DE1_SoC_top_level;

architecture rtl of DE1_SoC_top_level is

	component soc_system is
		port (
			clk     : in  std_logic                    := 'X';
			reset_n : in  std_logic                    := 'X';
			pio_0   : out std_logic_vector(9 downto 0)
		);
	end component soc_system;

begin

u0 : component soc_system
		port map (
			clk     => CLOCK_50,
			reset_n => KEY_N(0),
			pio_0   => LEDR
		);
		
end;
