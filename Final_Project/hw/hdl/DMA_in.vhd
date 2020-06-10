library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DMA_in is
	port
	(	
		-- Avalon standards
		Clk 			 	: in  std_logic;
		nReset 		 	: in  std_logic;
		
		-- External clock
		extClk			: in std_logic;
		
		-- Exported signals
		adcData 			: in 	std_logic;
		adcLRCK 			: in std_logic;
		
		-- Avalon master signals
		mAddress 	 	: out std_logic_vector(31 downto 0);
		mWriteData 	 	: out std_logic_vector(15 downto 0);
		mWaitRequest 	: in  std_logic;
		
		-- Data information signals
		currAdress 		: out std_logic_vector(31 downto 0)
		
	);
end DMA_in;

architecture dma_in_logic of DMA_in is
		
	signal RegWriteStart	: std_logic_vector(31 downto 0) := 16#0010000#;
	signal RegWriteMax	: std_logic_vector(31 downto 0) := 16#0110000#;
	signal initialized 	: std_logic;
	signal dataCount 		: std_logic_vector(5 downto 0);
	signal SampleData	   : std_logic_vector(16 downto 0);
	signal WriteReg		: unsigned(31 downto 0);
		
	type states_t is (IDLE, SEND_WRITE_REQUEST, WAIT_FOR_WRITE, READING_DATA);
	signal state : states_t;
	
begin
	initialize : process(nReset)
	begin
		WriteReg <= RegWriteStart;
		state <= IDLE;
		dataCount <= 0;
	end process initialize;
	
	mainReadWrite : process(Clk, nReset)
	begin
		if rising_edge(extClk) then
			case state is
				when READING_DATA => 
					mAddress <= (others => '0');
					SampleData(dataCount) <= data_in;
					if (dataCount >= 16) then
						state <= SEND_WRITE_REQUEST;
					else
						dataCount <= dataCount + 1;
					end if;
					
				when SEND_WRITE_REQUEST =>
					mAddress <= std_logic_vector(WriteReg);
					mWriteData <= SampleData;
					state <= WAIT_FOR_WRITE;
					
				when WAIT_FOR_WRITE =>
					if mWaitRequest = '0' then
						WriteReg <= WriteReg + 1;
						state <= IDLE;
					end if;
				
				when others => 
					state <= IDLE;
			end case;
		end if;
	end process mainReadWrite;
	
end dma_in_logic;