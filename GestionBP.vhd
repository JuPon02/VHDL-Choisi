library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity GestionBP is
	port(
			I_BP: in STD_LOGIC_VECTOR (10-1 downto 0);  --entrée (10 bits)
			O_BP: out STD_LOGIC_VECTOR (10-1 downto 0) --sortie (10 bits pour 10 led)
		 );
end entity;

architecture rtl of GestionBP is
	begin
		-- JAnti rebond
end rtl;
--test