library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Menu is
	port(
		I_NombreJoueur : in STD_LOGIC_VECTOR (4-1 downto 0);  --entrée (10 bits);
		I_NombreJoueurChoisis : in STD_LOGIC_VECTOR (4-1 downto 0);  --entrée (10 bits);
		O_Affiche : in STD_LOGIC_VECTOR (5-1 downto 0)  --entrée (10 bits)
		 );
end entity;

architecture rtl of Menu is
	begin
		-- JE ne sais pas
end rtl;
--test