library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY counter IS
	PORT
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
		
		-- Interrupts
		IRQ 			: OUT std_logic
	);
END counter;

ARCHITECTURE counter_logic OF counter IS
	signal iCounter : unsigned(31 DOWNTO 0);
	signal iEn 		 : std_logic; -- stop/start
	signal iRz 		 : std_logic; -- reset counter
	signal iEOT		 : std_logic; -- '1' when counter equals 0
	signal iClrEOT  : std_logic; -- has to be set to clear 'iEOT' at the beginning, otherwise IRQ will be fired if only iIRQEn is set
	signal iIRQEn 	 : std_logic;

BEGIN
	pCounter : process(Clk) begin
		if rising_edge(Clk) then
			if iRz= '1' then
				iCounter <= (others => '0');
			elsif iEn = '1' then
				iCounter <= iCounter+1;
			end if;
		end if;
	end process pCounter;
	
	pRegWr : process(Clk, nReset) begin
		if nReset = '0' then 
			iEn 	 <= '0'; 
			iRz 	 <= '0';
			iIRQEn <= '0';
		elsif rising_edge(Clk) then
			iRz 	  <= '0';
			iClrEOT <= '0';
			
			if ChipSelect = '1' and Write = '1' then -- Write cycle
				case Address(2 downto 0) is
					when "001" => iRz 	 <= '1'; -- Reset Counter (pulse)
					when "010" => iEn 	 <= '1'; -- Start Run
					when "011" => iEn 	 <= '0'; -- Stop Run
					when "100" => iIRQEn  <= WriteData(0);
					when "101" => iClrEOT <= WriteData(0);
					when others => null;
				end case;
			end if;
		end if;
	end process pRegWr;
	
	pRegRd : process(Clk) begin -- Read cycle
		if rising_edge(Clk) then
			ReadData <= (others => '0'); -- default value
			if ChipSelect = '1' and Read = '1' then -- Read cycle
				case Address(2 downto 0) is
					when "000"  => ReadData 	<= std_logic_vector(iCounter);
					when "100"  => ReadData(0) <= iIRQEn;
					when "101"  => ReadData(0) <= iEOT;
									   ReadData(1) <= iEn; -- Run
					when others => null;
				end case;
			end if;
		end if;
	end process pRegRd;
	
	pInterrupt : process(Clk) begin
		if rising_edge(Clk) then
			if iCounter = X"0000_0000" then
				iEOT <= '1';
			elsif iClrEOT = '1' then
				iEOT <= '0';
			end if;
		end if;
	end process pInterrupt;
	
	IRQ <= '1' when iEOT = '1' and iIRQEn = '1' and iEn = '1' else '0';
END counter_logic;