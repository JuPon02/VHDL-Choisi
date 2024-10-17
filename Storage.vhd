library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity Storage is
	generic(
		BP_up : std_logic_vector(4-1 downto 0):= "0001";
		BP_down : std_logic_vector(4-1 downto 0) := "0010";
		BP_left : std_logic_vector(4-1 downto 0) := "0100";
		BP_right : std_logic_vector(4-1 downto 0) := "1000"
	);
	port(I_BP : in std_logic_vector(4-1 downto 0);
		  I_Switches : in std_logic_vector(10-1 downto 0);
		  I_StateMachine : in std_logic_vector(2-1 downto 0);
		  
		  O_LedJoueurs :out std_logic_vector(10-1 downto 0);
		  O_NombreJoueurs : out unsigned(4-1 downto 0);
		  O_NombreDeChoisis : out unsigned(4-1 downto 0);
		  O_NmbrSwitch_NmbrJoueur_ok : out std_logic
		 );
end entity;

architecture rtl of Storage is
	Signal NombreJoueur: unsigned(4-1  downto 0); 
	Signal NombreJoueurChoisis: unsigned(4-1  downto 0); 
begin
	------------------------------------------------------
	process(I_Switches)
	begin
		if I_StateMachine = "11" then
		else
			O_LedJoueurs <= I_Switches;
		end if;
	end process;
	------------------------------------------------------
	process(I_BP)
	begin
		case I_StateMachine is
			when "00" =>
				case I_BP is
					when BP_up=>
						NombreJoueur <= NombreJoueur + 1;
						if(NombreJoueur>"1010") then
							NombreJoueur <= "1010";
						end if;
					when BP_down=>
						NombreJoueur <= NombreJoueur -1;
						if(NombreJoueur<"0010") then
								NombreJoueur <= "0010";
							end if;
				end case;
				O_NombreJoueurs <=NombreJoueur;
			when "01"=>
				case I_BP is
					when BP_up=>
						NombreJoueurChoisis <= NombreJoueurChoisis + 1;
						if(NombreJoueurChoisis>NombreJoueur-1) then
							NombreJoueurChoisis <= NombreJoueur-1;
						end if;
					when BP_down=>
						NombreJoueurChoisis <= NombreJoueurChoisis -1;
						if(NombreJoueurChoisis<"0001") then
								NombreJoueurChoisis <= "0001";
							end if;
				end case;
				O_NombreDeChoisis <= NombreJoueurChoisis; 
			when "10"=>
			
			when "11"=>
			
		end case;
	
	end process;
	----------------------------------------------------------
	process(I_Switches,NombreJoueur)
	begin
	-- Faudrait compter le nombre de switch ON 
--		if(I_Switches = NombreJoueur) then
--			O_Switch_Joueur <= '1';
--			else
--			O_Switch_Joueur <= '0';
--		end if;
		
	end process;
	----------------------------------------------------------
	
	
end rtl;