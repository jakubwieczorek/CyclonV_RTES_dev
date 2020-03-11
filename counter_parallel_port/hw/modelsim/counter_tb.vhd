library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY counter_tb IS
END counter_tb;

ARCHITECTURE counter_tb_logic OF counter_tb IS

	component counter
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

	signal Clk 			:  std_logic;
	signal nReset 		:  std_logic;
	signal Address 	:  std_logic_vector (2 DOWNTO 0);
	signal ChipSelect :  std_logic;
	signal Read 		:  std_logic;
	signal Write 		:  std_logic;
	signal ReadData 	:  std_logic_vector (31 DOWNTO 0);
	signal WriteData 	:  std_logic_vector (31 DOWNTO 0);
	signal IRQ 			:  std_logic;

   	constant clk_period : time := 10 ns;
	
BEGIN
	counter_instance : counter
	port map
	(
		Clk,
		nReset,
		Address,
		ChipSelect,
		Read,
		Write,
		ReadData,
		WriteData,
		IRQ
	);
	
	nReset <= '1',
		  '0' after clk_period,
		  '1' after clk_period + 2*clk_period;
	-- when 0 then reset
	
	ChipSelect <= '0',
		      '1' after clk_period*2; -- chip select all the time

	Write <= '0', 
		 '1' after clk_period*2,
		 '0' after clk_period*2 + clk_period*7, -- write 2nd to 9th cycle
		 '1' after clk_period*2 + clk_period*7 + clk_period*5; -- write 2nd to 9th cycle

	WriteData <= "00000000" & "00000000" & "00000000" & "00000001"; -- for interrupt
	-- enabling interrup works
	
	Read <= '0',
		'1' after clk_period*9,
		'0' after clk_period*9 + clk_period*2; -- from 9th to 15th cycle 
	-- reading data from counter works, it shows data on the the bus (ReadData signal) with one cycle delay -- according to the task.
	
	Address <= "000",
			"001" after clk_period*2, -- reset counter from 2nd to 5th cycle
		   "010" after clk_period*2 + clk_period*3, -- start from 5th to 9th s
			"000" after clk_period*2 + clk_period*3 + clk_period*4,
			"001" after clk_period*2 + clk_period*3 + clk_period*4 + clk_period*2, -- reset ones again to see interrupt
			"100" after clk_period*2 + clk_period*3 + clk_period*4 + clk_period*2 + clk_period*3, -- enable interrupt, iEOT was not cleard, so immediately interrupt will be fired
			"010" after clk_period*2 + clk_period*3 + clk_period*4 + clk_period*2 + clk_period*3 + clk_period*4; -- start ones again

	-- interrupt fired according to IRQ conditions: iEOT, iEN, iRQEn 
	-- reseting and starting works
			
	clk_process : process begin
		Clk <= '1';
		wait for clk_period/2;
		Clk <= '0';
		wait for clk_period/2;
	end process clk_process;
	
	stop_sim : process begin
		wait for clk_period * 100;
		assert false;
		report "simulation finished" severity failure;
	end process stop_sim;
	
END counter_tb_logic;
