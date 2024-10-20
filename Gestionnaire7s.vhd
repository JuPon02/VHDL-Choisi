library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.StatePackage.all;


entity Gestionnaire7s is
	port(
		 I_DataAffiche7SMenu : in std_logic_vector(8-1 downto 0);
		 I_DataAffiche7SChen : in std_logic_vector(8-1 downto 0);
		 O_DataAffiche7S : out std_logic_vector(8-1 downto 0);
		 I_StateMachine : in state_type;
		 CLK, RST : in std_logic
		 );
end entity;

architecture rtl of Gestionnaire7s is
begin
	process(I_DataAffiche7SMenu,I_DataAffiche7SChen)
	begin
		case I_StateMachine is
			when MenuNombreJoueur =>
				O_DataAffiche7S <=I_DataAffiche7SMenu ;
			when MenuNombreChoisis =>
				O_DataAffiche7S<=I_DataAffiche7SMenu ;
			when Chenillard =>
				O_DataAffiche7S<=I_DataAffiche7SChen ;
			when AffichageChoisis => 
			
			when others =>
		end case;
	end process;

end rtl;