library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.StatePackage.all;


entity menu is
	port(
		 O_Valor_7S : out std_logic_vector(8-1 downto 0);
		 I_NombreJoueurs : in unsigned(4-1 downto 0);
		 I_NombreDeChoisis : in unsigned(4-1 downto 0);
		 I_StateMachine : in state_type;
		 CLK, RST : in std_logic
		 );
end entity;

architecture rtl of menu is
	

begin
	process(I_NombreJoueurs,I_NombreDeChoisis, I_StateMachine)
	begin
		if I_StateMachine = MenuNombreJoueur then
			O_valor_7s <="01110001";
			case I_NombreJoueurs is
				when "0010" =>--2
					O_Valor_7S <= "01000010";
				when "0011" =>--3
					O_Valor_7S <= "01000010";
				when "0100" =>--4
					O_Valor_7S <= "01000100";
				when "0101" =>--5
					O_Valor_7S <= "01000101";
				when "0110" =>--6
					O_Valor_7S <= "01000110";
				when "0111" =>--7
					O_Valor_7S <= "01000111";
				when "1000" =>--8
					O_Valor_7S <= "01001000";
				when "1001" =>--9
					O_Valor_7S <= "01001001";
				when "1010" =>--10
					O_Valor_7S <= "01000010";
					O_Valor_7S <= "00100000";
				when others =>
			end case;
		elsif I_StateMachine = MenuNombreChoisis then
			O_valor_7s <="11010010";
			case I_NombreDeChoisis is
				when "0010" =>--2
					O_Valor_7S <= "10100010";
				when "0011" =>--3
					O_Valor_7S <= "10100010";
				when "0100" =>--4
					O_Valor_7S <= "10100100";
				when "0101" =>--5
					O_Valor_7S <= "10100101";
				when "0110" =>--6
					O_Valor_7S <= "10100110";
				when "0111" =>--7
					O_Valor_7S <= "10100111";
				when "1000" =>--8
					O_Valor_7S <= "10101000";
				when "1001" =>--9
					O_Valor_7S <= "10101001";
				when "1010" =>--10
					O_Valor_7S <= "10100010";
					O_Valor_7S <= "10000000";
				when others =>
			end case;
		end if;
	end process;
end rtl;
