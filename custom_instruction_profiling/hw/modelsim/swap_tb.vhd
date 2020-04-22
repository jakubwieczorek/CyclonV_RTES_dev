library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std;

entity swap_test is
end swap_test;

architecture swap_test_logic of swap_test is
	component swap is
		port
			(	
				-- avalon bus
				Clk 			 : in  std_logic;
				nReset 		 : in  std_logic;
				-- slave avalon 
				sAddress 	 : in  std_logic_vector(2 downto 0);
				sChipSelect  : in  std_logic;
				
				sWrite		 : in  std_logic;
				sWriteData 	 : in	 std_logic_vector(31 downto 0);
				sRead 		 : in  std_logic;
				sReadData 	 : out std_logic_vector(31 downto 0);
				-- master avalon 
				mAddress 	 : out  std_logic_vector(31 downto 0);
				mByteEnable 	 : out  std_logic_vector(3 downto 0);
				
				mWrite		 : out  std_logic;
				mWriteData 	 : out	 std_logic_vector(31 downto 0);
				mRead 		 : out  std_logic;
				mReadData 	 : in std_logic_vector(31 downto 0);
				mWaitRequest : in  std_logic
			);
	end component;
	
	signal Clk 			 : std_logic;
	signal nReset 		 : std_logic;
	-- slave avalon 
	signal sAddress 	 : std_logic_vector(2 downto 0);
	signal sChipSelect  : std_logic;
	
	signal sWrite		 : std_logic;
	signal sWriteData 	 : std_logic_vector(31 downto 0);
	signal sRead 		 : std_logic;
	signal sReadData 	 : std_logic_vector(31 downto 0);
	-- master avalon 
	signal mAddress 	 : std_logic_vector(31 downto 0);
	signal mByteEnable  : std_logic_vector(3 downto 0);
	
	signal mWrite		 : std_logic;
	signal mWriteData 	 : std_logic_vector(31 downto 0);
	signal mRead 		 : std_logic;
	signal mReadData 	 : std_logic_vector(31 downto 0);
	signal mWaitRequest : std_logic;
	
	constant period : time := 10 ns;
begin
	
	swap_instance : swap 
	port map
	(	
		-- avalon bus
		Clk,
		nReset,
		-- slave avalon 
		sAddress, 
		sChipSelect,
		
		sWrite,	
		sWriteData,
		sRead,
		sReadData,
		-- master avalon 
		mAddress,
		mByteEnable, 
		
		mWrite,
		mWriteData,
		mRead,
		mReadData, 
		mWaitRequest 
	);
	
	nReset <= '0' after period,
				 '1' after period + period/2;

	sChipSelect <= '1';
	sWrite <= '1';
	
	-- slave read
	sAddress <= "000" after period*2, -- RegAddStart
					"001" after period*3, -- RegLgt
					"011" after period*4, -- ResultRegAddStart
					"100" after period*5, -- operation
					"010" after period*6; -- start
					
	sWriteData <= x"FFFFFFFF" after period*2, -- RegAddStart
				     x"00000004" after period*3, -- RegLgt
	              x"AAAAAAAA" after period*4, -- ResultRegAddStart
	              x"FFFFFFF1" after period*5, -- operation
	              x"FFFFFFF1" after period*6; -- start
	-- slave read
	
	-- master 
	mReadData <= x"0000000B" after period*10; -- WAIT_RD state
	
	mWaitRequest <= '1' after period*10, -- master looks for the data
						 '0' after period*12; -- data in mReadData available 
	
	
	clk_process : process
	begin
		Clk <= '1';
		wait for period/2;
		Clk <= '0';
		wait for period/2;
	end process clk_process;
	
	
	end_process : process
	begin
		wait for period*50;
		assert false;
		report "simulation finished" severity failure;
	end process end_process;
end;