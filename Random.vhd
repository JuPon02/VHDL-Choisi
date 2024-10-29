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
    signal Nombre_Choix : unsigned(4-1 downto 0) := "0000";
    signal PasEncoreTrouve : std_logic := '1';
begin
    -- Compteur pour le Timer
    process (CLK, RST)
    begin
        if (RST = '0') then
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
    process (RST, CLK)
        variable temp_count : unsigned(4-1 downto 0) := "0000";
    begin
        if (RST = '0') then
            Mask <= "0000000000";
            Nombre_Choix <= "0000";
            PasEncoreTrouve <= '1';
        elsif (rising_edge(CLK)) then
            if (I_StateMachine = Chenillard and PasEncoreTrouve = '1') then
                Mask <= TimerCounter and I_SwitchJoueurs;
                temp_count := "0000"; -- Réinitialise le compteur temporaire

                -- Compte le nombre de '1' dans Mask
                for i in 0 to 9 loop
                    if (Mask(i) = '1') then
                        temp_count := temp_count + 1;
                    end if;
                end loop;
                
                Nombre_Choix <= temp_count; -- Mise à jour de Nombre_Choix avec le compteur temporaire

                -- Vérifie si le nombre de choix est atteint
                if (Nombre_Choix = I_NombreDeChoisis) then
                    O_JoueurChoisi <= Mask;
                    Nombre_Choix <= "0000";
                    PasEncoreTrouve <= '0';
                end if;
            end if;
        end if;
    end process;
end architecture;
