library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY parallel_port is 
	GENERIC(N : integer := 32);
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
		
		-- interrupts
		IRQ			: out std_logic;
		
		-- parallel port 
		ParPort 		: inout std_logic_vector(N-1 downto 0)
	);
END parallel_port;

ARCHITECTURE parallel_port_logic OF parallel_port IS
	signal iRegDir : std_logic_vector (N-1 DOWNTO 0); -- direction
	signal iRegPort: std_logic_vector (N-1 DOWNTO 0); -- data register 
	signal iRegPin : std_logic_vector (N-1 DOWNTO 0); -- current pin state
	signal iIRQEn 	 : std_logic := '1';

BEGIN

pPort : process(iRegDir, iRegPort) -- direction process
begin
	for i in 0 to N-1 loop
		if iRegDir(i) = '1' then
			ParPort(i) <= iRegPort(i); -- write
		else
			ParPort(i) <= 'Z'; -- read
		end if;
	end loop;
end process pPort;

iRegPin <= ParPort; -- current state of the port

pRegWr : process(Clk, nReset) -- write (control) process (to the port)
begin
	if nReset = '0' then
		iRegDir <= (others => '0'); -- Input by default
	elsif rising_edge(Clk) then
		if ChipSelect = '1' and Write = '1' then -- Write cycle
			case Address(2 downto 0) is
				when "000" => iRegDir  <= WriteData(N-1 downto 0); -- control direction
				when "001" => iRegPort <= WriteData(N-1 downto 0); -- write data
				when "010" => iRegPort <= iRegPort OR WriteData(N-1 downto 0); -- set particular bits
				when "011" => iRegPort <= iRegPort NAND WriteData(N-1 downto 0); -- reset particular bits
				when "100" => iIRQEn   <= WriteData(0);
				when others => null;
			end case;
		end if;
	end if;
end process pRegWr;

pRegRd : process(Clk) -- read process
begin
	if rising_edge(Clk) then
		ReadData <= (others => '0'); -- zeros by default
		if ChipSelect = '1' and Read = '1' then -- Read cycle
			case Address(2 downto 0) is
				when "000" => ReadData(N-1 downto 0) <= iRegDir; -- read direction
				when "001" => ReadData(N-1 downto 0) <= iRegPort; -- read the state of the port
				when "010" => ReadData(N-1 downto 0) <= iRegPin; -- read what is the data register
				when "011" => ReadData(0) <= iIRQEn;
				when others => null;
			end case;
		end if;
	end if;
end process pRegRd;

IRQ <= '1' when iIRQEn = '1' and iRegDir(2) = '1' and iRegPort(2) = '1' else '0';

--IRQ <= '1' when iIRQEn = '1' and iRegDir(2) = '1' and ParPort(2) = '1' else '0';

END;
