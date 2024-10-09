ibrary IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity driver_7s is
	port(I_data : in std_logic_vector(3 downto 0);
		 O_7s : out std_logic_vector(6 downto 0);
		 CLK, RESET : in std_logic 
		 );
end entity;

architecture rtl of driver_7s is
	begin
		process (CLK, RESET)
			begin 
			if (RESET = '1') then
				O_7s <= "0000000";
			elsif (rising_edge(CLK)) then
				case I_data is
					when "0000" =>
						O_7s <= "1111110";
					when "0001" =>
						O_7s <= "0110000";
					when "0010" =>
						O_7s <= "1101101";
					when "0011" =>
						O_7s <= "1111001";
					when "0100" =>
						O_7s <= "0110011";
					when "0101" =>
						O_7s <= "1011011";
					when "0110" =>
						O_7s <= "1011111";
					when "0111" =>
						O_7s <= "1110000";
					when "1000" =>
						O_7s <= "1111111";
					when "1001" =>
						O_7s <= "1111011";
					when others =>
						O_7s <= "0000000";
				end case;
		 	end if;
		end process;
end rtl;