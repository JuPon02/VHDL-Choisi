library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Random is
	port(
		CLOCK_50	: in	std_logic;
		I_NombreDeChoisis : in unsigned(4-1 downto 0);
		I_SwitchJoueurs : in unsigned(10-1 downto 0);
		I_state 		: in std_logic_vector(2-1 downto 0);
		O_JoueurChoisi : out STD_LOGIC_VECTOR (10-1 downto 0)
		 );
end entity;

architecture rtl of Random is

	signal TimerCounter: std_logic_vector(16-1 downto 0);
	signal TimerChosen: std_logic_vector(16-1 downto 0);
	signal chosen_players : STD_LOGIC_VECTOR (10-1 downto 0);
	signal mod_result : std_logic_vector(4-1 downto 0);
	variable already_chosen : boolean;
	variable previous_chosen : integer_array(0 to 9); --Ca jsp c'est gpt
	variable Nombre_joueur : unsigned(std_logic_vector(4-1 downto 0);
	
	begin
	
	process (CLOCK_50)
	begin
		if (rising_edge(CLOCK_50)) then
			if(TimerCounter = "1111111111111111") then		--65535
				TimerCounter <= "0100000000000000";			--16384
			else
				TimerCounter <= std_logic_vector(unsigned(TimerCounter) +  1);
			end if;
		end if;
	end process;
	
	process (CLOCK_50)
	begin
		if (previous_Swith != I_SwitchJoueurs) then
		Nombre_joueur <= 0;
		for i in 0 to 9 loop
			if (I_SwitchJoueurs(i) = '1') then
			Nombre_joueur ++;
			end if;
		end loop;
		end if;
	end process;
	
	process(I_state)
	begin
		if (I_state = "10") then		-- Quand on est en s2
			TimerChosen <= TimerCounter;
			
			for i in 0 to I_NombreDeChoisis - 1 loop
			    mod_result := to_integer(unsigned(TimerCounter)) rem (to_integer(Nombre_joueur) - i);
				already_chosen := false;
				
                for j in 0 to i-1 loop
					if previous_chosen(j) = mod_result then
                    already_chosen := true;
					I_NombreDeChoisis ++;
                    end if;
                end loop;
			 
                if not already_chosen then
                    previous_chosen(i) := mod_result;  -- On enregistre cet index
                    chosen_players(to_integer(mod_result)) <= '1'; -- On met le bit correspondant à 1

                end if;
            end loop;
            
            -- Affecter le résultat final à la sortie
            O_JoueurChoisi <= chosen_players;
			
		end if;
	end process;
end architecture;
    