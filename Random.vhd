library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Random is
	port(
		CLOCK_50	: in	std_logic;
		I_NombreDeChoisis : in unsigned(4-1 downto 0);
		I_state 		: in std_logic_vector(2-1 downto 0);
		O_JoueurChoisi : out STD_LOGIC_VECTOR (10-1 downto 0)
		 );
end entity;

architecture rtl of Random is

	signal TimerCounter: std_logic_vector(16-1 downto 0);
	signal val_rand	:  std_logic_vector(4-1 downto 0); 	--Valeur du compteur lors de l'appui

	begin
	
	process (CLOCK_50,I_state)
	begin
		if (rising_edge(CLOCK_50)) then
			if(TimerCounter = "1111111111111111") then		--65535
				TimerCounter <= "0100000000000000";			--16384
			else
				TimerCounter <= std_logic_vector(unsigned(TimerCounter) +  1);
			end if;
		end if;
		
		if (I_state = "10") then		-- Quand on est en s2
			val_rand <= timerCounter; 	-- Quand on appuie, on prend la valeur du compteur
			
		end if;
	end process;
end architecture;
