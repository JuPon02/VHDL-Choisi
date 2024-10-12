library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity LED is
	port(
		  I_led : in STD_LOGIC_VECTOR (10-1 downto 0);  --entrée (10 bits)
        I_SwitchsON: in STD_LOGIC_VECTOR (10-1 downto 0);  --entrée (10 bits)
		  I_JoueurChoisi : in STD_LOGIC_VECTOR (10-1 downto 0);  --entrée (10 bits)
		  I_StateMachine : in STD_LOGIC_VECTOR (2-1 downto 0)  --entrée (10 bits)
		 );
end entity;

architecture rtl of LED is
	begin

	
	end rtl;