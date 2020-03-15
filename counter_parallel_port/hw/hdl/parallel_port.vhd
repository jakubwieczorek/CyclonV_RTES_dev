library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY parallel_port is 
	PORT
	(
		-- avalon bus
		Clk 			: in 	  std_logic;
		nReset 		: in 	  std_logic;
		
		Address 		: in 	  std_logic_vector(2 downto 0);
		ChipSelect 	: in    std_logic;
		
		Write			: in 	  std_logic;
		WriteData 	: in	  std_logic_vector(31 downto 0);
		Read 			: in 	  std_logic;
		ReadData 	: out   std_logic_vector(31 downto 0);
		
		ParPort 		: inout std_logic_vector(31 downto 0)
	);
END parallel_port;

ARCHITECTURE parallel_port_logic OF parallel_port IS
	signal iRegDir : std_logic_vector (31 DOWNTO 0);
	signal iRegPort: std_logic_vector (31 DOWNTO 0);
	signal iRegPin : std_logic_vector (31 DOWNTO 0);
BEGIN

pPort : process(iRegDir, iRegPort)
begin
	for i in 0 to 31 loop
		if iRegDir(i) = '1' then
			ParPort(i) <= iRegPort(i); -- write
		else
			ParPort(i) <= 'Z'; -- read
		end if;
	end loop;
end process pPort;

iRegPin <= ParPort;

pRegWr : process(Clk, nReset)
begin
	if nReset = '0' then
		iRegDir <= (others => '0'); -- Input by default
	elsif rising_edge(Clk) then
		if ChipSelect = '1' and Write = '1' then -- Write cycle
			case Address(2 downto 0) is
				when "000" => iRegDir  <= WriteData; -- control direction
				when "010" => iRegPort <= WriteData; -- write data
				when "011" => iRegPort <= iRegPort OR WriteData; -- set particular bits
				when "100" => iRegPort <= iRegPort NAND WriteData; -- reset particular bits
				when others => null;
			end case;
		end if;
	end if;
end process pRegWr;

pRegRd : process(Clk)
begin
	if rising_edge(Clk) then
		ReadData <= (others => '0'); -- zeros by default
		if ChipSelect = '1' and Read = '1' then -- Read cycle
			case Address(2 downto 0) is
				when "000" => ReadData <= iRegDir ;
				when "001" => ReadData <= iRegPin;
				when "010" => ReadData <= iRegPort;
				when others => null;
			end case;
		end if;
	end if;
end process pRegRd;
END;