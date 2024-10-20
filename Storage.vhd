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
	signal NombreSwitch : unsigned (4-1 downto 0);
	Signal NombreJoueurChoisis: unsigned(4-1  downto 0); 
begin
	------------------------------------------------------
process(RST,CLK) -- Ajout d'I_StateMachine à la liste de sensibilité
begin
	if RST ='1' then
		O_LedJoueurs <= (others => '0');
    else
		O_LedJoueurs <= I_Switches;
    end if;
end process;

	------------------------------------------------------
	process(I_BP, I_StateMachine, NombreJoueur,NombreJoueurChoisis ) -- Ajout d'I_StateMachine à la liste de sensibilité
begin
    case I_StateMachine is
        when  MenuNombreJoueur=>
            case I_BP is
                when C_BP_up =>
                    NombreJoueur <= NombreJoueur + 1;
                    if (NombreJoueur > "1010") then
                        NombreJoueur <= "1010";
                    end if;
                when C_BP_down =>
                    NombreJoueur <= NombreJoueur - 1;
                    if (NombreJoueur < "0010") then
                        NombreJoueur <= "0010";
                    end if;
                when others =>
                    -- Optionnel : définir un comportement par défaut si nécessaire
            end case;
            O_NombreJoueurs <= NombreJoueur;
        when MenuNombreChoisis =>
            case I_BP is
                when C_BP_up =>
                    NombreJoueurChoisis <= NombreJoueurChoisis + 1;
                    if (NombreJoueurChoisis > NombreJoueur - 1) then
                        NombreJoueurChoisis <= NombreJoueur - 1;
                    end if;
                when C_BP_down =>
                    NombreJoueurChoisis <= NombreJoueurChoisis - 1;
                    if (NombreJoueurChoisis < "0001") then
                        NombreJoueurChoisis <= "0001";
                    end if;
                when others =>
                    -- Optionnel : définir un comportement par défaut si nécessaire
            end case;
            O_NombreDeChoisis <= NombreJoueurChoisis; 
        when others =>
            -- Ajoute une affectation par défaut pour éviter les latches
            O_NombreJoueurs <= (others => '0');
            O_NombreDeChoisis <= (others => '0');
    end case;
end process;

	----------------------------------------------------------
	process(I_Switches)
	begin
		NombreSwitch <= "0000";
		for i in 0 to 9 loop
				if (I_Switches(i) = '1') then
					NombreSwitch <= NombreSwitch+ 1;
				end if;
			end loop;
		if NombreSwitch = NombreJoueur then
			O_NmbrSwitch_NmbrJoueur_ok <= '1';
		else 
			O_NmbrSwitch_NmbrJoueur_ok <= '0';
		end if;
	end process;
	----------------------------------------------------------
	
	
end rtl;