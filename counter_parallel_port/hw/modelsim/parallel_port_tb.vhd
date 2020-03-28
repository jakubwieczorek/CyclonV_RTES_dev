library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY parallel_port_tb IS
END parallel_port_tb;

ARCHITECTURE parallel_port_tb_logic OF parallel_port_tb IS
	COMPONENT parallel_port IS
		GENERIC(N : integer := 8);
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
			
			ParPort 		: inout STD_LOGIC_VECTOR(N-1 DOWNTO 0)
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
	signal ParPort 	: std_logic_vector(8-1 downto 0);

	constant clock_period : time := 10 ns;
BEGIN	
	parallel_port_instance : parallel_port
	port map
	(
		Clk, nReset, Address, ChipSelect, Write, WriteData, Read, ReadData, ParPort
	);
	
	nReset <= '1';
	
	ChipSelect <= '1'; -- chip select all the time

	Address <= "000", 
				  "010" after clock_period * 2;
	
	-- first write direction and data then read
	Write <= '1',
				'0' after clock_period*10;
				
	Read <= '0',
			  '1' after clock_period*10;
			  
	ParPort <= "ZZZZ1Z1Z";
	
	WriteData <= "00000000" & "00000000" & "00000000" & "11110101", -- direction
					 "00000000" & "00000000" & "00000000" & "01010001" after clock_period * 2,
					 "00000000" & "00000000" & "00000000" & "01010101" after clock_period * 2 + clock_period, -- data
					 "00000000" & "00000000" & "00000000" & "01010001" after clock_period * 2 + clock_period*2, -- data
					 "00000000" & "00000000" & "00000000" & "01010101" after clock_period * 2 + clock_period*3; -- data
	
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