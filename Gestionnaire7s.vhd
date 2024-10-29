library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.StatePackage.all;


entity Gestionnaire7s is
	port(
		 I_DataAffiche7SMenu0,I_DataAffiche7SMenu1,I_DataAffiche7SMenu2,I_DataAffiche7SMenu3,I_DataAffiche7SMenu4,I_DataAffiche7SMenu5 : in std_logic_vector(5-1 downto 0);
		 I_DataAffiche7SChen0,I_DataAffiche7SChen1,I_DataAffiche7SChen2,I_DataAffiche7SChen3,I_DataAffiche7SChen4,I_DataAffiche7SChen5 : in std_logic_vector(5-1 downto 0);
		 O_DataAffiche7S0,O_DataAffiche7S1,O_DataAffiche7S2,O_DataAffiche7S3,O_DataAffiche7S4,O_DataAffiche7S5 : out std_logic_vector(5-1 downto 0);
		 I_StateMachine : in state_type;
		 CLK, RST : in std_logic
		 );
end entity;

architecture rtl of Gestionnaire7s is
begin
	process(CLK,RST,I_DataAffiche7SMenu0,I_DataAffiche7SMenu1,I_DataAffiche7SMenu2,I_DataAffiche7SMenu3,I_DataAffiche7SMenu4,I_DataAffiche7SMenu5,
	I_DataAffiche7SChen0,I_DataAffiche7SChen1,I_DataAffiche7SChen2,I_DataAffiche7SChen3,I_DataAffiche7SChen4,I_DataAffiche7SChen5)--I_DataAffiche7SMenu,I_DataAffiche7SChen
	begin
		if (RST  = '0') then
			O_DataAffiche7S0 <= "11111";
			O_DataAffiche7S1 <= "11111"; 
			O_DataAffiche7S2 <= "11111";
			O_DataAffiche7S3 <= "11111";
			O_DataAffiche7S4 <= "11111";
			O_DataAffiche7S5 <= "11111";
		elsif(rising_edge(CLK)) then
			case I_StateMachine is
				when MenuNombreJoueur =>
					O_DataAffiche7S0 <=I_DataAffiche7SMenu0 ;
					O_DataAffiche7S1 <=I_DataAffiche7SMenu1 ;
					O_DataAffiche7S2 <=I_DataAffiche7SMenu2 ;
					O_DataAffiche7S3 <=I_DataAffiche7SMenu3 ;
					O_DataAffiche7S4 <=I_DataAffiche7SMenu4 ;
					O_DataAffiche7S5 <=I_DataAffiche7SMenu5 ;
				when MenuNombreChoisis =>
					O_DataAffiche7S0<=I_DataAffiche7SMenu0 ;
					O_DataAffiche7S1<=I_DataAffiche7SMenu1 ;
					O_DataAffiche7S2<=I_DataAffiche7SMenu2 ;
					O_DataAffiche7S3<=I_DataAffiche7SMenu3 ;
					O_DataAffiche7S4<=I_DataAffiche7SMenu4 ;
					O_DataAffiche7S5<=I_DataAffiche7SMenu5 ;
				when Chenillard =>
					O_DataAffiche7S0<=I_DataAffiche7SChen0 ;
					O_DataAffiche7S1<=I_DataAffiche7SChen1 ;
					O_DataAffiche7S2<=I_DataAffiche7SChen2 ;
					O_DataAffiche7S3<=I_DataAffiche7SChen3 ;
					O_DataAffiche7S4<=I_DataAffiche7SChen4 ;
					O_DataAffiche7S5<=I_DataAffiche7SChen5 ;
				when AffichageChoisis => 
				
				when others =>
			end case;
		end if;
	end process;

end rtl;