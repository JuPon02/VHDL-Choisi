library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity driver_7s is
	port(I_data : in std_logic_vector(8-1 downto 0);
		 O_7s1,O_7s2,O_7s3,O_7s4,O_7s5,O_7s6 : out std_logic_vector(7-1 downto 0);
		 CLK, RST : in std_logic 
		 );
end entity;

architecture rtl of driver_7s is

signal Adresse7s : std_logic_vector(8-1 downto 0);
signal Affichage7s : std_logic_vector(7-1 downto 0);
Signal DataAffichage7s : std_logic_vector(8-1 downto 0);
signal previous7s_1, previous7s_2, previous7s_3, previous7s_4, previous7s_5, previous7s_6 : std_logic_vector(7-1 downto 0);


	begin
		process (CLK, RST)
			begin 
			if (RST = '0') then
				Adresse7s <= "00000000";
				Affichage7s <= "0000000";
				DataAffichage7s <= "00000000";
		--mettre 3 bit en entrée pour l'adresse
			elsif (rising_edge(CLK)) then
			Adresse7s <= "11100000" and I_data;
			DataAffichage7s <= "00011111" and I_data;	
				case DataAffichage7s is
					when "00000000" =>Affichage7s <= "1111110";--0
					when "00000001" =>Affichage7s <= "0110000";--1
					when "00000010" =>Affichage7s <= "1101101";--2
					when "00000011" =>Affichage7s <= "1111001";--3
					when "00000100" =>Affichage7s <= "0110011";--4
					when "00000101" =>Affichage7s <= "1011011";--5
					when "00000110" =>Affichage7s <= "1011111";--6
					when "00000111" =>Affichage7s <= "1110000";--7
					when "00001000" =>Affichage7s <= "1111111";--8
					when "00001001" =>Affichage7s <= "1111011";--9
					when "00001010" =>Affichage7s <= "1000000";--a
					when "00001011" =>Affichage7s <= "0100000";--b 
					when "00001100" =>Affichage7s <= "0010000";--c
					when "00001101" =>Affichage7s <= "0001000";--d
					when "00001111" =>Affichage7s <= "0000100";--e
					when "00010000" =>Affichage7s <= "0000010";--f
					when "00010001" =>Affichage7s <= "1100111";--P
					when "00010010" =>Affichage7s <= "1001110";--C
					when "00011111" => Affichage7s <= "0000000"; --rien
					when others =>
						Affichage7s <= "0000000";	
				end case;
		 	end if;
		end process;
		
		process(Affichage7s, RST, Adresse7s, previous7s_1, previous7s_2, previous7s_3, previous7s_4, previous7s_5, previous7s_6)
		begin
		if (RST = '1') then
			O_7s1 <= (others => '0');
			O_7s2 <= (others => '0');
			O_7s3 <= (others => '0');
			O_7s4 <= (others => '0');
			O_7s5 <= (others => '0');
			O_7s6 <= (others => '0');
		else
			previous7s_1<=previous7s_1;
			previous7s_2<=previous7s_2;
			previous7s_3<=previous7s_3;
			previous7s_4<=previous7s_4;
			previous7s_5<=previous7s_5;
			previous7s_6<=previous7s_6;
				case(Adresse7s) is
                when "00100000" => previous7s_1 <= Affichage7s;
                when "01000000" => previous7s_2 <= Affichage7s;
                when "01100000" => previous7s_3 <= Affichage7s;
                when "10000000" => previous7s_4 <= Affichage7s;
                when "10100000" => previous7s_5 <= Affichage7s;
                when "11000000" => previous7s_6 <= Affichage7s;
                when others => 
                    previous7s_1 <= (others => '0');
                    previous7s_2 <= (others => '0');
                    previous7s_3 <= (others => '0');
                    previous7s_4 <= (others => '0');
                    previous7s_5 <= (others => '0');
                    previous7s_6 <= (others => '0');
            end case;
        end if;

        -- Mise à jour des ports de sortie avec les signaux intermédiaires
        O_7s1 <= previous7s_1;
        O_7s2 <= previous7s_2;
        O_7s3 <= previous7s_3;
        O_7s4 <= previous7s_4;
        O_7s5 <= previous7s_5;
        O_7s6 <= previous7s_6;
		end process;
end rtl;