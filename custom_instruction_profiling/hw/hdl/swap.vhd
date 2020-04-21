library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity swap_accelerator is
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
end swap_accelerator;

architecture swap_accelerator_logic of swap_accelerator is
		
	signal RegAddStart, RegLgt, Result, ResultRegAddStart: std_logic_vector(31 downto 0);
	signal DataRd		   : std_logic_vector(31 downto 0);
	signal start, finish : std_logic;
	signal CntAdd, CntLgt, CntResultAdd			: unsigned(31 downto 0);
		
	type states_t is (IDLE, LOAD_PARAMETERS, RD_ACC, WAIT_RD, CALCULATE, SEND_WRITE_REQUEST, WAIT_FOR_WRITE);
	signal state, nextState : states_t;
	
	signal operation : std_logic;
	
begin
	
	slaveWriteProcess : Process(Clk, nReset) 
	begin
		if nReset='0' then
			RegAddStart  		<= (others => '0');
			RegLgt		 		<= (others => '0');
			start 		 		<= '0';
			ResultRegAddStart <= (others => '0');
			
		elsif sChipSelect = '1' and sWrite = '1' then
			case sAddress is
				when "000" => RegAddStart 		  <= sWriteData; 
				when "001" => RegLgt  	 		  <= sWriteData; 
				when "010" => start 		 		  <= sWriteData(0); 
				when "011" => ResultRegAddStart <= sWriteData;
				when "100" => operation 		  <= sWriteData(0); 

				when others => null;
			end case;
		end if;
	end process slaveWriteProcess;
	
	slaveReadProcess : process(Clk) 
	begin
		if sChipSelect = '1' and sRead = '1' then
			case sAddress is
				when "000" => sReadData 	<= RegAddStart; 
				when "001" => sReadData 	<= RegLgt;
				when "010" => sReadData(0) <= start;
				when "011" => sReadData 	<= ResultRegAddStart; 
				when "100" => sReadData(0) <= operation;

				when others => null;
			end case;
		end if;
	end process slaveReadProcess;
	
	transitionMasterFSM : process(state, start, mWaitRequest)
	begin
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
				CntAdd <= unsigned(RegAddStart); -- why unsigned?
				CntLgt <= unsigned(RegLgt);
				CntResultAdd <= unsigned(ResultRegAddStart);
				result <= (others => '0');
				
				nextState <= RD_ACC;
							
			when RD_ACC =>
				mAddress <= std_logic_vector(CntAdd); -- from that address DMA will read data
				mByteEnable <= "1111";
				mRead	 <= '1';
				mWrite <= '0';
			
				nextState <= WAIT_RD;
				
			when WAIT_RD =>
				if mWaitRequest = '0' then
					DataRd <= mReadData;
					mRead <= '0';
					nextState <= CALCULATE;
				end if;
				
			when CALCULATE =>
				if operation = '1' then
					for i in 0 to 31 loop
						Result(i) <= DataRd(31-i);
					end loop;
				else
					Result(31 downto 0) <= DataRd(7 downto 0) & DataRd(15 downto 8) & DataRd(23 downto 16) & DataRd(31 downto 24);
				end if;
				
				nextState <= SEND_WRITE_REQUEST;
			when SEND_WRITE_REQUEST =>
				mAddress <= std_logic_vector(CntResultAdd);
				mByteEnable <= "1111";
				mWrite <= '1';
				mWriteData <= Result;
				nextState <= WAIT_FOR_WRITE;
			
			when SEND_WRITE_REQUEST =>
				if mWaitRequest = '0' then
					CntLgt <= CntLgt - 1;
					
					if CntLgt > 0 then
						CntAdd <= CntAdd + 4;
						CntResultAdd <= CntResultAdd + 4;
						nextState <= RD_ACC;
					else
						mByteEnable <= "0000";
						mWrite <= '0';
						finish <= '1';
						nextState <= IDLE;
					end if;
				end if;
			
			when others => 
				nextState <= IDLE;
		end case;
	end process transitionMasterFSM;
	
	state_register : process(Clk)
		begin 
			if rising_edge(Clk) then
				state <= nextState;
			end if;
	end process state_register;
	
end swap_accelerator_logic;