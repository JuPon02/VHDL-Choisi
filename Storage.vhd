library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.StatePackage.all;

entity Storage is
    port(
        I_BP_n : in std_logic_vector(4-1 downto 0);
        I_Switches : in std_logic_vector(10-1 downto 0);
        t_StateMachine : in state_type;
        O_LedJoueurs : out std_logic_vector(10-1 downto 0);
        O_NombreJoueurs : out unsigned(4-1 downto 0);
        O_NombreDeChoisis : out unsigned(4-1 downto 0);
        O_NmbrSwitch_NmbrJoueur_ok : out std_logic;
        CLK, RST_n : in std_logic
    );
end entity;

architecture rtl of Storage is
    signal NombreJoueur : unsigned(4-1 downto 0); 
    signal NombreSwitch : unsigned(4-1 downto 0) := (others => '0');
    signal NombreJoueurChoisis : unsigned(4-1 downto 0); 
    signal previous_I_BP_n : std_logic_vector(3 downto 0);
    signal previous_Switch : std_logic_vector(10-1 downto 0);
    signal count : unsigned(4-1 downto 0) := (others => '0');  -- Compteur interne
	 signal I_Switches0 : unsigned(4-1 downto 0); 
	signal I_Switches1 : unsigned(4-1 downto 0); 
	signal I_Switches2 : unsigned(4-1 downto 0); 
	signal I_Switches3 : unsigned(4-1 downto 0); 
	signal I_Switches4 : unsigned(4-1 downto 0); 
	signal I_Switches5 : unsigned(4-1 downto 0); 
	signal I_Switches6 : unsigned(4-1 downto 0); 
	signal I_Switches7 : unsigned(4-1 downto 0); 
	signal I_Switches8 : unsigned(4-1 downto 0); 
	signal I_Switches9 : unsigned(4-1 downto 0); 

begin
    ------------------------------------------------------
    process(RST_n, CLK, I_Switches) -- Ajout d't_StateMachine à la liste de sensibilité
    begin
        if RST_n = '0' then
            O_LedJoueurs <= (others => '1');
        else
            O_LedJoueurs <= I_Switches;
        end if;
    end process;

    ------------------------------------------------------
    process (CLK, RST_n)
    begin
        if RST_n = '0' then
            NombreJoueur <= "0010";
            NombreJoueurChoisis <= "0001";
            previous_I_BP_n <= (others => '0');
        elsif rising_edge(CLK) then
            -- Détection des fronts descendants
            if (previous_I_BP_n(0) = '1' and I_BP_n(0) = '0') or
               (previous_I_BP_n(1) = '1' and I_BP_n(1) = '0') or
               (previous_I_BP_n(2) = '1' and I_BP_n(2) = '0') then
                case t_StateMachine is
                    when MenuNombreJoueur =>
                        case I_BP_n is
                            when C_BP_up =>
                                if (NombreJoueur < "1010") then
                                    NombreJoueur <= NombreJoueur + 1;
                                end if;
                            when C_BP_down =>
                                if (NombreJoueur > "0010") then
                                    NombreJoueur <= NombreJoueur - 1;
                                end if;
                            when others =>
                                -- Optionnel : définir un comportement par défaut si nécessaire
                        end case;
                    when MenuNombreChoisis =>
                        case I_BP_n is
                            when C_BP_up =>
                                if (NombreJoueurChoisis < NombreJoueur - 1) then
                                    NombreJoueurChoisis <= NombreJoueurChoisis + 1;
                                end if;
                            when C_BP_down =>
                                if (NombreJoueurChoisis > "0001") then
                                    NombreJoueurChoisis <= NombreJoueurChoisis - 1;
                                end if;
                            when others =>
                                -- Optionnel : définir un comportement par défaut si nécessaire
                        end case;
                    when others =>
                        -- Optionnel : définir un comportement par défaut si nécessaire
                end case;
            end if;
            -- Mise à jour de l'état précédent des boutons
            previous_I_BP_n <= I_BP_n;
        end if;
    end process;

    O_NombreJoueurs <= NombreJoueur;
    O_NombreDeChoisis <= NombreJoueurChoisis;

    ----------------------------------------------------------
I_Switches0 <= "0001" when I_Switches(0) = '1' else "0000";
I_Switches1 <= "0001" when I_Switches(1) = '1' else "0000";
I_Switches2 <= "0001" when I_Switches(2) = '1' else "0000";
I_Switches3 <= "0001" when I_Switches(3) = '1' else "0000";
I_Switches4 <= "0001" when I_Switches(4) = '1' else "0000";
I_Switches5 <= "0001" when I_Switches(5) = '1' else "0000";
I_Switches6 <= "0001" when I_Switches(6) = '1' else "0000";
I_Switches7 <= "0001" when I_Switches(7) = '1' else "0000";
I_Switches8 <= "0001" when I_Switches(8) = '1' else "0000";
I_Switches9 <= "0001" when I_Switches(9) = '1' else "0000";
NombreSwitch <= I_Switches0+I_Switches1+I_Switches2+I_Switches3+I_Switches4+I_Switches5+I_Switches6+I_Switches7+I_Switches8+I_Switches9;

    ----------------------------------------------------------
     process(CLK, RST_n)
     begin
         if RST_n = '0' then
             O_NmbrSwitch_NmbrJoueur_ok <= '0'; -- Réinitialisation
         elsif rising_edge(CLK) then
             if NombreSwitch = NombreJoueur then
					O_NmbrSwitch_NmbrJoueur_ok <= '1';
             else 
                 O_NmbrSwitch_NmbrJoueur_ok <= '0';
             end if;
         end if;
     end process;

end rtl;
