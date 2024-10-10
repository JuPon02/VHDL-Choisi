ibrary IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity LED is
	port(
		i_led : in STD_LOGIC_VECTOR (9 downto 0);  --entrée (10 bits)
        o_led : out STD_LOGIC_VECTOR (9 downto 0) --sortie (10 bits pour 10 led)
		 );
end entity;

architecture rtl of LED is
	begin
		
end rtl;
--test