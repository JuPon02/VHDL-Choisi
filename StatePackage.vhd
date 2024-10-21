library IEEE;
use IEEE.std_logic_1164.all;

package StatePackage is
    -- Déclaration du type d'état global
    type state_type is (MenuNombreJoueur, MenuNombreChoisis, Chenillard, AffichageChoisis);

    -- Déclaration des constantes globales pour les boutons poussoirs
    constant C_BP_right: std_logic_vector(3 downto 0) := "1110";        
    constant C_BP_up : std_logic_vector(3 downto 0) := "1101";
    constant C_BP_down: std_logic_vector(3 downto 0) := "1011";
    constant C_BP_RST: std_logic_vector(3 downto 0) := "0111";
end package StatePackage;
