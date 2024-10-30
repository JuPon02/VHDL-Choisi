library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.StatePackage.all;

entity menu is
	port(
		 O_Valor_7S0,O_Valor_7S1,O_Valor_7S2,O_Valor_7S3,O_Valor_7S4,O_Valor_7S5 : out std_logic_vector(5-1 downto 0);
		 I_NombreJoueurs : in unsigned(4-1 downto 0);
		 I_NombreDeChoisis : in unsigned(4-1 downto 0);
		 t_StateMachine : in state_type;
		 CLK, RST_n : in std_logic
		 );
end entity;

architecture rtl of menu is
	-- Compteur pour gérer l'affichage séquentiel lors du reset
	signal display_counter : integer range 0 to 3 := 0;
begin
	process(CLK, RST_n)
	begin
		if RST_n = '0' then
				O_Valor_7S5 <= "11111"; -- RIEN
				O_Valor_7S4 <= "00010"; -- Affiche 2
				O_Valor_7S3 <= "10001"; -- Affiche P
				O_Valor_7S2 <= "11111"; -- RIEN	
				O_Valor_7S1 <= "00001"; -- Affiche 1
				O_Valor_7S0 <= "10010"; -- Affiche c
		
		elsif (rising_edge(CLK)) then
			-- Comportement normal de la machine à états
			if t_StateMachine = MenuNombreJoueur then
				case I_NombreJoueurs is
					when "0010" => O_Valor_7S4 <= "00010"; -- 2
					when "0011" => O_Valor_7S4 <= "00011"; -- 3
					when "0100" => O_Valor_7S4 <= "00100"; -- 4
					when "0101" => O_Valor_7S4 <= "00101"; -- 5
					when "0110" => O_Valor_7S4 <= "00110"; -- 6
					when "0111" => O_Valor_7S4 <= "00111"; -- 7
					when "1000" => O_Valor_7s4	<= "01000"; -- 8
					when "1001" => O_Valor_7S4 <= "01001"; -- 9
										O_Valor_7S5 <= "11111"; -- RIEN
					when "1010" => O_Valor_7S4 <= "00000"; -- 0
										O_Valor_7S5 <= "00001"; -- 1
					when others =>
										O_Valor_7S5 <= "11111"; -- RIEN
										O_Valor_7S4 <= "11111"; -- RIEN
										O_Valor_7S3 <= "11111"; -- RIEN
										O_Valor_7S2 <= "11111"; -- RIEN	
										O_Valor_7S1 <= "11111"; -- RIEN
										O_Valor_7S0 <= "11111"; -- RIEN
							
				end case;

			elsif t_StateMachine = MenuNombreChoisis then
				case I_NombreDeChoisis is
					when "0001" => O_Valor_7S1 <= "00001"; -- 1
					when "0010" => O_Valor_7S1 <= "00010"; -- 2
					when "0011" => O_Valor_7S1 <= "00011"; -- 3
					when "0100" => O_Valor_7S1 <= "00100"; -- 4
					when "0101" => O_Valor_7S1 <= "00101"; -- 5
					when "0110" => O_Valor_7S1 <= "00110"; -- 6
					when "0111" => O_Valor_7S1 <= "00111"; -- 7
					when "1000" => O_Valor_7S1 <= "01000"; -- 8
					when "1001" => O_Valor_7S1 <= "01001"; -- 9
					when others =>	
										O_Valor_7S5 <= "11111"; -- RIEN
										O_Valor_7S4 <= "11111"; -- RIEN
										O_Valor_7S3 <= "11111"; -- RIEN
										O_Valor_7S2 <= "11111"; -- RIEN	
										O_Valor_7S1 <= "11111"; -- RIEN
										O_Valor_7S0 <= "11111"; -- RIEN
				end case;
			end if;
		end if;
	end process;
end rtl;
