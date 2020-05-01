library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;   

-- =================== README =========================================
--         Here It is for the SINGLE CYCLE CUSTOM INSTRUCTION !!!!
--         Everything is done by combinatorial operations (logic gates)
-- ====================================================================

ENTITY BitSwap IS

	PORT(
	-- Avalon interfaces signals
	--Other signals
	dataa							: IN   std_logic_vector( 31 DOWNTO 0);
	--datab						: IN   std_logic_vector( 31 DOWNTO 0);
	result						: OUT  std_logic_vector( 31 DOWNTO 0)    -- NO ';' for the LAST PORT ELEMENT
	);
End BitSwap;

ARCHITECTURE comp OF BitSwap IS

BEGIN

	result(31 DOWNTO 24) <= dataa(7 DOWNTO 0);
	result(7  DOWNTO 0 ) <= dataa(31 DOWNTO 24);
	PERM: for i in 0 to 15 generate
	   result(8+i) <= dataa(23-i);  
	end generate PERM;
	
END comp;  -- END OF ALL THE PROCESSES