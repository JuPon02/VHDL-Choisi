library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity driver_7s is
	port(I_data : in std_logic_vector(5-1 downto 0);
		 O_7s_n : out std_logic_vector(7-1 downto 0);
		 CLK, RST_n : in std_logic 
		 );
end entity;

architecture rtl of driver_7s is


	begin
		process (CLK, RST_n)
			begin 
			if (RST_n = '0') then
				O_7s_n  <= "0000000";
		--mettre 3 bit en entrée pour l'adresse
			elsif (rising_edge(CLK)) then
				case I_data is
					when "00000" => O_7s_n  <= "1000000";--0
					when "00001" => O_7s_n  <= "1111001";--1
					when "00010" => O_7s_n  <= "0100100";--2
					when "00011" => O_7s_n  <= "0110000";--3
					when "00100" => O_7s_n  <= "0011001";--4
					when "00101" => O_7s_n  <= "0010010";--5
					when "00110" => O_7s_n  <= "0000010";--6
					when "00111" => O_7s_n  <= "1011000";--7
					when "01000" => O_7s_n  <= "0000000";--8
					when "01001" => O_7s_n  <= "0010000";--9
					when "01010" => O_7s_n  <= "1111110";--a
					when "01011" => O_7s_n  <= "1111101";--b 
					when "01100" => O_7s_n  <= "1111011";--c
					when "01101" => O_7s_n  <= "1110111";--d
					when "01111" => O_7s_n  <= "1101111";--e
					when "10000" => O_7s_n  <= "1011111";--f
					when "10001" => O_7s_n  <= "0001100";--P
					when "10010" => O_7s_n  <= "1000110";--C
					when "10011" => O_7s_n  <= "1110110";
					when "11111" => O_7s_n  <= "1111111"; --rien
					when others =>
						O_7s_n  <= "1111111";	
				end case;
		 	end if;
		end process;
end rtl;