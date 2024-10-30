library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.StatePackage.all;

entity Random is
    port(
        I_NombreDeChoisis  : in unsigned(4-1 downto 0);
        I_SwitchJoueurs    : in std_logic_vector(10-1 downto 0);
        t_StateMachine     : in state_type;
        O_JoueurChoisi     : out std_logic_vector (10-1 downto 0);
        CLK, RST_n : in std_logic
    );
end entity;

architecture rtl of Random is
    signal TimerCounter : std_logic_vector(10-1 downto 0);
    signal Mask         : std_logic_vector(10-1 downto 0);
    signal Nombre_Choix : unsigned(4-1 downto 0) := "0000";
    signal PasEncoreTrouve : std_logic := '1';
	 signal Mask0,Mask1,Mask2,Mask3,Mask4,Mask5,Mask6,Mask7,Mask8,Mask9 : unsigned(4-1 downto 0);  
begin
    -- Compteur pour le Timer
    process (CLK, RST_n)
    begin
        if (RST_n = '0') then
            TimerCounter <= "0000000000";
        elsif (rising_edge(CLK)) then
            if (TimerCounter = "1111111111") then
                TimerCounter <= "0000000000";    
            else
                TimerCounter <= std_logic_vector(unsigned(TimerCounter) + 1);
            end if;
        end if;
    end process;

    -- Sélection des joueurs
    process (RST_n, CLK)
      
    begin
        if (RST_n = '0') then
            Mask <= "0000000000";
            
            PasEncoreTrouve <= '1';
        elsif (rising_edge(CLK)) then
            if (t_StateMachine = Chenillard and PasEncoreTrouve = '1') then
                Mask <= TimerCounter and I_SwitchJoueurs;
                
               -- Mise à jour de Nombre_Choix avec le compteur temporaire

                -- Vérifie si le nombre de choix est atteint
                if (Nombre_Choix = I_NombreDeChoisis) then
                    O_JoueurChoisi <= Mask;
                    -- Nombre_Choix <= "0000";
                    PasEncoreTrouve <= '0';
                end if;
				elsif t_StateMachine /= Chenillard then
					 PasEncoreTrouve <= '1';
            end if;
        end if;
    end process;
	 
	  Mask0 <= "0001" when Mask(0) = '1' else "0000";
	  Mask1 <= "0001" when Mask(1) = '1' else "0000";
	  Mask2 <= "0001" when Mask(2) = '1' else "0000";
	  Mask3 <= "0001" when Mask(3) = '1' else "0000";
	  Mask4 <= "0001" when Mask(4) = '1' else "0000";
	  Mask5 <= "0001" when Mask(5) = '1' else "0000";
	  Mask6 <= "0001" when Mask(6) = '1' else "0000";
	  Mask7 <= "0001" when Mask(7) = '1' else "0000";
	  Mask8 <= "0001" when Mask(8) = '1' else "0000";
	  Mask9 <= "0001" when Mask(9) = '1' else "0000";
	  Nombre_Choix <=  (Mask0+Mask1+Mask2+Mask3+Mask4+Mask5+Mask6+Mask7+Mask8+Mask9) when RST_n ='1' else "0000";
	  
end architecture;
