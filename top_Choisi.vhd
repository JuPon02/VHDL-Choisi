ibrary IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top_Choisi is
	port(
		 );
end entity;

architecture rtl of top_Choisi is

	component LED
		port(
			i_led : in STD_LOGIC_VECTOR (10-1 downto 0);  --entrée (10 bits)
			o_led : out STD_LOGIC_VECTOR (10-1 downto 0) --sortie (10 bits pour 10 led)
			 );
	end component;
	
	component Switch
		port(
			I_switchs : in std_logic_vector(10-1 downto 0);
			O_switchs : out std_logic_vector(10-1 downto 0)
			);
	end component;
	
	component driver7s
		port(
			I_data : in std_logic_vector(3 downto 0);
			O_7s : out std_logic_vector(6 downto 0);
			CLK, RESET : in std_logic 
			);
	end component
	
	
	begin
		
end rtl;