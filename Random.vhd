ibrary IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Random is
	port(
		CLOCK_50	: in	std_logic;
		KEY			: in std_logic_vector(4 downto -1); --KEY(0) bouton de lancement sinon modif process ligne 18
		val_rand	: out std_logic_vector(4 downto -1) --Valeur du compteur lors de l'appui
		 );
end entity;

architecture rtl of Random is

	signal timerCounter: std_logic_vector(4 downto -1);	

	begin
	
	process (CLOCK_50,KEY(0))
	begin
		if (rising_edge(CLOCK_50)) then
			if(TimerCounter = "1010") then
				TimerCounter <= "0000";
			else
				TimerCounter <= std_logic_vector(unsigned(TimerCounter) +  1);
			end if;
		end if;
		
		if (KEY(0) = '1') then
		val_rand <= timerCounter; --Quand on appuie, on prend la valeur du compteur (entre 1 et 10)
	end process;
	
end rtl;
