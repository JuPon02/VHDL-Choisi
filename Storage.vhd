library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.StatePackage.all;


entity Storage is

	port(I_BP : in std_logic_vector(4-1 downto 0);
		  I_Switches : in std_logic_vector(10-1 downto 0);
		  I_StateMachine : in state_type;
		  
		  O_LedJoueurs :out std_logic_vector(10-1 downto 0);
		  O_NombreJoueurs : out unsigned(4-1 downto 0);
		  O_NombreDeChoisis : out unsigned(4-1 downto 0);
		  O_NmbrSwitch_NmbrJoueur_ok : out std_logic;
		  CLK, RST : in std_logic
		 );
end entity;

architecture rtl of Storage is


	Signal NombreJoueur: unsigned(4-1  downto 0); 
	signal NombreSwitch : unsigned (4-1 downto 0):= (others => '0');
	Signal NombreJoueurChoisis: unsigned(4-1  downto 0); 
	signal previous_I_BP : std_logic_vector(3 downto 0);
	signal previous_Switch  : std_logic_vector(10-1 downto 0);
	signal count : unsigned(4-1  downto 0):= (others => '0');  -- Compteur interne
	
begin
	------------------------------------------------------
process(RST,CLK, I_Switches) -- Ajout d'I_StateMachine à la liste de sensibilité
begin
	if RST = '0' then
		O_LedJoueurs <= (others => '1');
    else
		O_LedJoueurs <= I_Switches;
    end if;
end process;

	------------------------------------------------------
process (CLK, RST)
    begin
        if RST = '0' then
            NombreJoueur <= "0010";
            NombreJoueurChoisis <= "0001";
            previous_I_BP <= (others => '0');
        elsif rising_edge(CLK) then
            -- Détection des fronts descendants
            if (previous_I_BP(0) = '1' and I_BP(0) = '0') or
               (previous_I_BP(1) = '1' and I_BP(1) = '0') or
               (previous_I_BP(2) = '1' and I_BP(2) = '0') then
                case I_StateMachine is
                    when MenuNombreJoueur =>
                        case I_BP is
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
                        case I_BP is
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
            previous_I_BP <= I_BP;
        end if;
    end process;
	O_NombreJoueurs <= NombreJoueur;
	O_NombreDeChoisis <= NombreJoueurChoisis;
	----------------------------------------------------------
	
    process(CLK , RST, previous_Switch, I_Switches,count)
    begin
        if RST = '0' then
            count <= (others => '0'); -- Réinitialise le compteur
            NombreSwitch <= (others => '0'); -- Réinitialise NombreSwitch
            --O_NombreJoueurs <= (others => '0'); -- Réinitialise la sortie
			previous_Switch <= "0000000000";
        elsif previous_Switch /= I_Switches then
				count <= (others => '0'); -- Réinitialise le compteur à chaque cycle d'horloge
				for i in 0 to 9 loop
					if I_Switches(i) = '1' then
						count <= count + 1; -- Incrémente le compteur
					end if;
				end loop;
				NombreSwitch <= count; -- Convertit l'entier en unsigned
--				O_NombreJoueurs <= NombreSwitch; -- Assigne le nombre de joueurs
				previous_Switch <= I_Switches;
            
        end if;
	end process;
	----------------------------------------------------------
	 --process(CLK, RST)
    --begin
   --     if RST = '0' then
   --         O_NmbrSwitch_NmbrJoueur_ok <= '0'; -- Réinitialisation
   --     elsif rising_edge(CLK) then
   --         if NombreSwitch = NombreJoueur then
              O_NmbrSwitch_NmbrJoueur_ok <= '1';
   --         else 
   --             O_NmbrSwitch_NmbrJoueur_ok <= '0';
   --         end if;
   --     end if;
    --end process;

	
end rtl;