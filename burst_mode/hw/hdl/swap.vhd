library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity swap is
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
end swap;

architecture swap_logic of swap is
		
	signal RegAddStart, RegLgt, Result, ResultRegAddStart: std_logic_vector(31 downto 0);
	signal DataRd		   : std_logic_vector(31 downto 0);
	signal start, finish : std_logic;
	signal CntAdd, CntLgt, CntResultAdd			: unsigned(31 downto 0);
		
	type states_t is (IDLE, LOAD_PARAMETERS, RD_ACC, WAIT_RD, CALCULATE, SEND_WRITE_REQUEST, WAIT_FOR_WRITE);
	signal state : states_t;	
begin
	
	slaveWriteProcess : Process(Clk, nReset) 
	begin
		if nReset='0' then
			RegAddStart  		<= (others => '0');
			RegLgt		 		<= (others => '0');
			start 		 		<= '0';
			ResultRegAddStart <= (others => '0');
			
		elsif rising_edge(Clk) then
			start <= '0'; -- in FSM, there is no zeroing Start, by doing that here Start is an impuls
			if sChipSelect = '1' and sWrite = '1' then
				case sAddress is
					when "000" => RegAddStart 		  <= sWriteData; 
					when "001" => RegLgt  	 		  <= sWriteData; 
					when "010" => start 		 		  <= sWriteData(0); 
					when "011" => ResultRegAddStart <= sWriteData;
					when others => null;
				end case;
			end if;
		end if;
	end process slaveWriteProcess;
	
	slaveReadProcess : process(Clk) 
	begin
		if rising_edge(Clk) then
			if sChipSelect = '1' and sRead = '1' then
				sReadData <= (others => '0');
				case sAddress is
					when "000" => sReadData 	<= RegAddStart; 
					when "001" => sReadData 	<= RegLgt;
					when "010" => sReadData(0) <= start;
					when "011" => sReadData 	<= ResultRegAddStart; 
					when "101" => sReadData(0) <= finish;

					when others => null;
				end case;
			end if;
		end if;
	end process slaveReadProcess;
	
	transitionMasterFSM : process(Clk, nReset)
	begin
		if nReset = '0' then
			finish <= '0';
			CntAdd <= (others => '0');
			CntLgt <= (others => '0');
			CntResultAdd <= (others => '0');
			Result <= (others => '0');
		elsif rising_edge(Clk) then
			case state is
				when IDLE => 
				-- init master
					mAddress <= (others => '0');
					mByteEnable <= "0000";
					mWrite <= '0';
					mRead <= '0';
								
					if start = '1' then
						state <= LOAD_PARAMETERS;
						finish <= '0';
					end if;
					
				when LOAD_PARAMETERS =>
					CntAdd <= unsigned(RegAddStart);
					CntLgt <= unsigned(RegLgt);
					CntResultAdd <= unsigned(ResultRegAddStart);
					result <= (others => '0');
					
					state <= RD_ACC;
								
				when RD_ACC =>
					mAddress <= std_logic_vector(CntAdd); -- from that address data will be read directly from the memory
					mByteEnable <= "1111";
					mRead	 <= '1';
					mWrite <= '0';
				
					state <= WAIT_RD;
					
				when WAIT_RD =>
					if mWaitRequest = '0' then
						DataRd <= mReadData;
						mRead <= '0';
						state <= CALCULATE;
					end if;
					
				when CALCULATE =>
					-- 0x12345678 => 0x786A2C12
						Result <= DataRd;
					
					state <= SEND_WRITE_REQUEST;
				when SEND_WRITE_REQUEST =>
						mAddress <= std_logic_vector(CntResultAdd);
						mByteEnable <= "1111"; -- can be all the 111, because we want to write/read all bytes
						mWrite <= '1';
						mWriteData <= Result;
						state <= WAIT_FOR_WRITE;
				when WAIT_FOR_WRITE =>
					if mWaitRequest = '0' then
						mWrite <= '0'; -- all the time 

						if CntLgt > 0 then
							CntAdd <= CntAdd + 174;--4*44
							CntResultAdd <= CntResultAdd + 174;
							CntLgt <= CntLgt - 1; 
							state <= RD_ACC; -- if write only here it means that when I go to the IDLE I will still have write at 1
						else -- and for 1 cc more what was on the bus will be written into the memory. If it was trush, then that
							-- trash will be written as well.
							mByteEnable <= "0000";
							finish <= '1';
							state <= IDLE;
						end if;
						
					end if;
				
				when others => 
					state <= IDLE;
			end case;
		end if;
	end process transitionMasterFSM;
	
end swap_logic;