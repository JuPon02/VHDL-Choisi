ibrary IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Random is
	port(
		CLOCK_50	: in	std_logic;
		 );
end entity;

architecture rtl of Random is

	signal timerCounter: std_logic_vector(3 downto 0);	

	begin
	
	process (CLOCK_50)
	begin
		if (rising_edge(CLOCK_50)) then
			if(TimerCounter = "1010") then
				TimerOK <= '1';
			else
				TimerCounter <= std_logic_vector(unsigned(TimerCounter) +  1);
			end if;
		end if;
	end process;
	
end rtl;
--test