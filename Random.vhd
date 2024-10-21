library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.StatePackage.all;

entity Random is
    port(
        I_NombreDeChoisis  : in unsigned(4-1 downto 0);
        I_SwitchJoueurs    : in std_logic_vector(10-1 downto 0);
        I_StateMachine     : in state_type;
        O_JoueurChoisi     : out std_logic_vector (10-1 downto 0);
		  CLK, RST : in std_logic
    );
end entity;

architecture rtl of Random is
    signal TimerCounter : std_logic_vector(10-1 downto 0);
    signal Mask         : std_logic_vector(10-1 downto 0);
    signal Nombre_Choix : unsigned(4-1 downto 0);
begin
    process (CLK, I_StateMachine)
    begin
			if (RST = '0') then
            TimerCounter <= "0000000000";
			else
				if (rising_edge(CLK)) then
					if (TimerCounter >= "1111111111") then
						 TimerCounter <= "0000000000";    
						 
					else
						 TimerCounter <= std_logic_vector(unsigned(TimerCounter) + 1);
					end if;
			  end if;
			end if;  
    end process;

    process (I_StateMachine, RST)
    begin
        if (RST = '0') then
            Mask <= "0000000000";
            Nombre_Choix <= "0000";
        end if;

        if (I_StateMachine = Chenillard) then -- Quand on est en s2
            Mask <= TimerCounter and I_SwitchJoueurs;

            for i in 0 to 9 loop
                if (Mask(i) = '1') then
                    Nombre_Choix <= Nombre_Choix + 1;
                end if;
            end loop;

            if (Nombre_Choix <= I_NombreDeChoisis) then
                O_JoueurChoisi <= Mask;
                Nombre_Choix <= "0000";
            else 
                Nombre_Choix <= "0000";
            end if;
        end if;
    end process;
end architecture;
