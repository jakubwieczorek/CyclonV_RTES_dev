library IEEE;
use IEEE.std_logic_1164.all;

ENTITY tst_bench IS
END tst_bench;

architecture tst_bench_logic OF tst_bench IS
	
	COMPONENT counter_parallel_port
		PORT
		(
			CLOCK_50 : in  STD_LOGIC;
			KEY_N		: in  STD_LOGIC_VECTOR(3 DOWNTO 0);
			LEDR		: out STD_LOGIC_VECTOR(9 DOWNTO 0)
		);
	END COMPONENT;

	signal mCLOCK_50 : STD_LOGIC;
	signal mKEY_N 	 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal mLEDR	 : STD_LOGIC_VECTOR(9 DOWNTO 0);

	begin
	
	counter_parallel_port_instance : counter_parallel_port
	PORT MAP
	(
		CLOCK_50 => mCLOCK_50,
		KEY_N 	=> mKEY_N,
		LEDR 		=> mLEDR
	);
	
	clock : process begin
		mCLOCK_50 <= '0';
		wait for 5 ns;
		mCLOCK_50 <= '1';
		wait for 5 ns;
	end process;
	
	stopsim : process begin
		wait for 300 ns;
		assert false;
		report "simulation finished" severity failure;
	end process;
END tst_bench_logic;