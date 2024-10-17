library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity LED is
	port(
		  O_led : out STD_LOGIC_VECTOR (10-1 downto 0);  --entrée (10 bits)
        I_SwitchsON: in STD_LOGIC_VECTOR (10-1 downto 0);  --entrée (10 bits)
		  I_JoueurChoisi : in STD_LOGIC_VECTOR (10-1 downto 0);  --entrée (10 bits)
		  I_StateMachine : in STD_LOGIC_VECTOR (2-1 downto 0)  --entrée (10 bits)
		 );
end entity;

architecture rtl of LED is
signal etatLed01 : STD_LOGIC_VECTOR (10-1 downto 0):= (others => '0');
begin
	process(I_SwitchsON, I_JoueurChoisi, I_StateMachine)
		begin
		case(I_StateMachine) is 
			when "00"=> 
				O_led<= I_SwitchsON;
			when "01"=> 
				O_led<= I_SwitchsON;
				etatLed01 <= I_SwitchsON;
			when "10"=>
				O_led<= etatLed01;
			when "11"=> 
				O_led<= I_JoueurChoisi;
			when others =>
				O_led <= (others => '0'); -- Valeur par défaut
		end case;
	end process;
end rtl;