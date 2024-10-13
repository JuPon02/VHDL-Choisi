library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity driver_7s is
	port(I_data : in std_logic_vector(5-1 downto 0);
		 O_7s : out std_logic_vector(7-1	 downto 0);
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
					when "00000" =>
						O_7s <= "1111110";--0
					when "00001" =>
						O_7s <= "0110000";--1
					when "00010" =>
						O_7s <= "1101101";--2
					when "00011" =>
						O_7s <= "1111001";--3
					when "00100" =>
						O_7s <= "0110011";--4
					when "00101" =>
						O_7s <= "1011011";--5
					when "00110" =>
						O_7s <= "1011111";--6
					when "00111" =>
						O_7s <= "1110000";--7
					when "01000" =>
						O_7s <= "1111111";--8
					when "01001" =>
						O_7s <= "1111011";--9
					when "01010" =>
						O_7s <= "1000000";--a
					when "01011" =>
						O_7s <= "0100000";--b 
					when "01100" =>
						O_7s <= "0010000";--c
					when "01101" =>
						O_7s <= "0001000";--d
					when "01111" =>
						O_7s <= "0000100";--e
					when "10000" =>
						O_7s <= "0000010";--f
					when "10001" =>
						O_7s <= "1100111";--P
					when "10010" =>
						O_7s <= "1001110";--C
						
					when others =>
						O_7s <= "0000000";	
				end case;
		 	end if;
		end process;
end rtl;