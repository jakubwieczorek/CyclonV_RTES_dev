library ieee;
use ieee.std_logic_1164.all;

entity DE1_SoC_top_level is
    port(
        CLOCK_50         : in    std_logic;
        KEY_N            : in    std_logic_vector(3 downto 0);
        LEDR             : out   std_logic_vector(9 downto 0)
    );
end DE1_SoC_top_level;

architecture rtl of DE1_SoC_top_level is

	component soc_system
		port 
		(
			clk     : in  std_logic                    := 'X';
			reset_n : in  std_logic                    := 'X';
			pio_0   : out std_logic_vector(9 downto 0)
		);
	end component;
	
	component avalon_bus
		PORT
		(
			Clk 			: IN  std_logic;
			nReset 		: IN  std_logic;
			Address 		: IN  std_logic_vector (2 DOWNTO 0);
			ChipSelect  : IN  std_logic;
			Read 			: IN  std_logic;
			Write 		: IN  std_logic;
			ReadData 	: OUT std_logic_vector (31 DOWNTO 0);
			WriteData 	: IN  std_logic_vector (31 DOWNTO 0)
		);
	end component;
	
	signal mAddress 	 : std_logic_vector(2 DOWNTO 0);
	signal mChipSelect : std_logic;
	signal mRead		 : std_logic;
	signal mWrite		 : std_logic;
	signal mReadData 	 : std_logic_vector(31 DOWNTO 0);
	signal mWriteData	 : std_logic_vector(31 DOWNTO 0);
	
begin

u0 : soc_system
	port map 
	(
		clk     => CLOCK_50,
		reset_n => KEY_N(0),
		pio_0   => LEDR
	);

avalon_bus_instance : avalon_bus
	port map 
	(
		clk        => CLOCK_50,
		nReset     => KEY_N(0),
		Address    => mAddress,
		ChipSelect => mChipSelect,
		Read		  => mRead,
		Write		  => mWrite,
		ReadData	  => mReadData,
		WriteData  => mWriteData
	);
	
end rtl;
