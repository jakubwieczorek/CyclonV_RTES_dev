library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY parallel_port_tb IS
END parallel_port_tb;

ARCHITECTURE parallel_port_tb_logic OF parallel_port_tb IS
	COMPONENT parallel_port IS
		PORT
		(
			Clk 			: in 	  STD_LOGIC;
			nReset 		: in 	  STD_LOGIC;
			
			Address 		: in 	  STD_LOGIC_VECTOR(2 DOWNTO 0);
			ChipSelect  : in 	  STD_LOGIC;
			
			Write 		: in 	  STD_LOGIC;
			WriteData 	: in	  STD_LOGIC_VECTOR(31 DOWNTO 0);
			Read 			: in 	  STD_LOGIC;
			ReadData 	: out   STD_LOGIC_VECTOR(31 DOWNTO 0);
			
			ParPort 		: inout STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;
	
	signal Clk 			: std_logic;
	signal nReset 		: std_logic;
	signal Address 	: std_logic_vector(2 downto 0);
	signal ChipSelect : std_logic;
	signal Write 		: std_logic;
	signal WriteData  : std_logic_vector(31 downto 0);
	signal Read 		: std_logic;
	signal ReadData   : std_logic_vector(31 downto 0);
	signal ParPort 	: std_logic_vector(31 downto 0);

	constant clock_period : time := 10 ns;
BEGIN	
	parallel_port_instance : parallel_port
	port map
	(
		Clk, nReset, Address, ChipSelect, Write, WriteData, Read, ReadData, ParPort
	);
	
	nReset <= '1',
		  '0' after clock_period,
		  '1' after clock_period + 2*clock_period;
	-- when 0 then reset
	
	ChipSelect <= '0',
		      '1' after clock_period*2; -- chip select all the time

	
	clk_process : process 
	begin
		Clk <= '1';
		wait for clock_period/2;
		Clk <= '0';
		wait for clock_period/2;
	end process clk_process;
	
	stop_sim : process 
	begin
		wait for 100*clock_period;
		assert false;
		report "simulation finished" severity failure;
	end process stop_sim;
END;