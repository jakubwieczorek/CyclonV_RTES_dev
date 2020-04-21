library IEEE;
use IEEE.std_logic_1164.all;

ENTITY avalon_bus IS
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
END ENTITY;

ARCHITECTURE avalon_bus_logic OF avalon_bus IS
	
	component counter is
		port
		(
			-- Avalon interfaces signals
			Clk 			: IN  std_logic;
			nReset 		: IN  std_logic;
			Address 		: IN  std_logic_vector (2 DOWNTO 0);
			ChipSelect  : IN  std_logic;
			Read 			: IN  std_logic;
			Write 		: IN  std_logic;
			ReadData 	: OUT std_logic_vector (31 DOWNTO 0);
			WriteData 	: IN  std_logic_vector (31 DOWNTO 0);
			
			-- Interruptions
			IRQ 			: OUT std_logic
		);
	end component;
	
BEGIN
	
	counter_instance : component counter 
	port map
	(
		Clk => Clk,
		nReset => nReset,
		Address => Address,
		ChipSelect => ChipSelect,
		Read => Read,
		Write => Write,
		ReadData  => ReadData,
		WriteData => WriteData
	);
	
END ARCHITECTURE;
