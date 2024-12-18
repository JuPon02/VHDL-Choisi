library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.StatePackage.all;

entity LED is
	port(
		  O_led : out STD_LOGIC_VECTOR (10-1 downto 0);  -- Sortie (10 bits)
        I_SwitchsON : in STD_LOGIC_VECTOR (10-1 downto 0);  -- Entrée (10 bits)
		  I_JoueurChoisi : in STD_LOGIC_VECTOR (10-1 downto 0);  -- Entrée (10 bits)
		  t_StateMachine : in state_type;
		  RST_n, CLK : in std_logic
		 );
end entity;

architecture rtl of LED is
	signal etatLed01 : STD_LOGIC_VECTOR (10-1 downto 0);

begin
	process(CLK, RST_n)
	begin
		if RST_n = '0' then
			etatLed01 <= "0000000000";
			O_led <= "1111111111"; -- Valeur par défaut en cas de reset
		elsif (rising_edge(CLK)) then
			case t_StateMachine is 
				when MenuNombreJoueur => 
					O_led <= I_SwitchsON;
				when MenuNombreChoisis => 
					O_led <= I_SwitchsON;
					etatLed01 <= I_SwitchsON;
				when Chenillard =>
					O_led <= etatLed01;
				when AffichageChoisis => 
					O_led <= I_JoueurChoisi;
				when others =>
					O_led <= I_SwitchsON; -- Valeur par défaut
			end case;
		end if;
	end process;
end rtl;
