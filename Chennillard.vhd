library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.StatePackage.all;

entity Chennillard is
    port(
        t_StateMachine : in state_type;
        O_FinChennillard : out std_logic;
        O_Valor_7S0, O_Valor_7S1, O_Valor_7S2, O_Valor_7S3, O_Valor_7S4, O_Valor_7S5 : out std_logic_vector(5-1 downto 0);
        CLK, RST_n : in std_logic
    );
end entity;

architecture rtl of Chennillard is

    -- Type énuméré pour les états
    type state_type1 is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31, s32);
    signal state : state_type1;
    signal slow_clk : std_logic; -- Signal pour l'horloge lente
    signal counter : integer; -- Compteur pour diviser l'horloge

    constant CLOCK_FREQUENCY : integer := 10000000; -- Fréquence de l'horloge d'entrée (50 MHz)
    constant HALF_SECOND_COUNT : integer := CLOCK_FREQUENCY / 2; -- Compte pour 0.5 seconde

begin

    -- Processus pour générer une horloge lente de 0.5s
    process (CLK, RST_n, t_StateMachine)
    begin
        if RST_n = '0' then
            counter <= 0;
            slow_clk <= '0';
        elsif rising_edge(CLK) then
            if counter = HALF_SECOND_COUNT then
                slow_clk <= not slow_clk;
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    -- Processus de la machine d'états
    process (slow_clk, RST_n)
    begin
        if RST_n = '0' then
            state <= s0;
            O_FinChennillard <= '0';
        elsif rising_edge(slow_clk) then
            if t_StateMachine = Chenillard then
                case state is
                    when s0  => state <= s1;
                    when s1  => state <= s2;
                    when s2  => state <= s3;
                    when s3  => state <= s4;
                    when s4  => state <= s5;
                    when s5  => state <= s6;
                    when s6  => state <= s7;
                    when s7  => state <= s8;
                    when s8  => state <= s9;
                    when s9  => state <= s10;
                    when s10 => state <= s11;
                    when s11 => state <= s12;
                    when s12 => state <= s13;
                    when s13 => state <= s14;
                    when s14 => state <= s15;
                    when s15 => state <= s16;
                    when s16 => state <= s17;
                    when s17 => state <= s18;
                    when s18 => state <= s19;
                    when s19 => state <= s20;
                    when s20 => state <= s21;
                    when s21 => state <= s22;
                    when s22 => state <= s23;
                    when s23 => state <= s24;
                    when s24 => state <= s25;
                    when s25 => state <= s26;
                    when s26 => state <= s27;
                    when s27 => state <= s28;
                    when s28 => state <= s29;
                    when s29 => state <= s30;
                    when s30 => state <= s31;
                    when s31 => state <= s32;
                    when s32 => 
											state <= s0;
											O_FinChennillard <= '1';
                end case;
            else
                O_FinChennillard <= '0';  
            end if;
        end if;
    end process;

    -- Sortie dépendant de l'état courant
    process (state)
    begin
			case state is
            when s0  => O_Valor_7S5 <= "01010";--a
								O_Valor_7S4 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S1 <= "11111";
								O_Valor_7S0 <= "11111";
            when s1  => O_Valor_7S4 <= "01010";--a
								O_Valor_7S5 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S1 <= "11111";
								O_Valor_7S0 <= "11111";
            when s2  => O_Valor_7S3 <= "01010";--a
								O_Valor_7S5 <= "11111";
								O_Valor_7S4 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S1 <= "11111";
								O_Valor_7S0 <= "11111";
            when s3  => O_Valor_7S2 <= "01010";--a
								O_Valor_7S5 <= "11111";
								O_Valor_7S4 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S1 <= "11111";
								O_Valor_7S0 <= "11111";
            when s4  => O_Valor_7S1 <= "01010";--a
								O_Valor_7S5 <= "11111";
								O_Valor_7S4 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S0 <= "11111";
            when s5  => O_Valor_7S0 <= "01010";--a
								O_Valor_7S5 <= "11111";
								O_Valor_7S4 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S1 <= "11111";
            when s6  => O_Valor_7S0 <= "01011";--b
								O_Valor_7S5 <= "11111";
								O_Valor_7S4 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S1 <= "11111";
            when s7  => O_Valor_7S0 <= "01100";--c
								O_Valor_7S5 <= "11111";
								O_Valor_7S4 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S1 <= "11111";
            when s8  => O_Valor_7S0 <= "01101";--d
								O_Valor_7S5 <= "11111";
								O_Valor_7S4 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S1 <= "11111";
            when s9  => O_Valor_7S1 <= "01101";--d
								O_Valor_7S5 <= "11111";
								O_Valor_7S4 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S0 <= "11111";
            when s10 => O_Valor_7S2 <= "01101";--d
								O_Valor_7S5 <= "11111";
								O_Valor_7S4 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S1 <= "11111";
								O_Valor_7S0 <= "11111";
            when s11 => O_Valor_7S3 <= "01101";--d
								O_Valor_7S5 <= "11111";
								O_Valor_7S4 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S1 <= "11111";
								O_Valor_7S0 <= "11111";
            when s12 => O_Valor_7S4 <= "01101";--d
								O_Valor_7S5 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S1 <= "11111";
								O_Valor_7S0 <= "11111";
            when s13 => O_Valor_7S5 <= "01101";--d
								O_Valor_7S4 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S1 <= "11111";
								O_Valor_7S0 <= "11111";
            when s14 => O_Valor_7S5 <= "01111";--e
								O_Valor_7S4 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S1 <= "11111";
								O_Valor_7S0 <= "11111";
            when s15 => O_Valor_7S5 <= "10000";--f
								O_Valor_7S4 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S1 <= "11111";
								O_Valor_7S0 <= "11111";
				when s16 => O_Valor_7S5 <= "01010";--a
								O_Valor_7S4 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S1 <= "11111";
								O_Valor_7S0 <= "11111";
            when s17 => O_Valor_7S4 <= "01010";--a
								O_Valor_7S5 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S1 <= "11111";
								O_Valor_7S0 <= "11111";
            when s18 => O_Valor_7S3 <= "01010";--a
								O_Valor_7S5 <= "11111";
								O_Valor_7S4 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S1 <= "11111";
								O_Valor_7S0 <= "11111";
            when s19 => O_Valor_7S2 <= "01010";--a
								O_Valor_7S5 <= "11111";
								O_Valor_7S4 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S1 <= "11111";
								O_Valor_7S0 <= "11111";
            when s20 => O_Valor_7S1 <= "01010";--a
								O_Valor_7S5 <= "11111";
								O_Valor_7S4 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S0 <= "11111";
            when s21 => O_Valor_7S0 <= "01010";--a
								O_Valor_7S5 <= "11111";
								O_Valor_7S4 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S1 <= "11111";
            when s22 => O_Valor_7S0 <= "01011";--b
								O_Valor_7S5 <= "11111";
								O_Valor_7S4 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S1 <= "11111";
            when s23 => O_Valor_7S0 <= "01100";--c
								O_Valor_7S5 <= "11111";
								O_Valor_7S4 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S1 <= "11111";
            when s24 => O_Valor_7S0 <= "01101";--d
								O_Valor_7S5 <= "11111";
								O_Valor_7S4 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S1 <= "11111";
            when s25 => O_Valor_7S1 <= "01101";--d
								O_Valor_7S5 <= "11111";
								O_Valor_7S4 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S0 <= "11111";
            when s26	=> O_Valor_7S2 <= "01101";--d
								O_Valor_7S5 <= "11111";
								O_Valor_7S4 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S1 <= "11111";
								O_Valor_7S0 <= "11111";
            when s27 => O_Valor_7S3 <= "01101";--d
								O_Valor_7S5 <= "11111";
								O_Valor_7S4 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S1 <= "11111";
								O_Valor_7S0 <= "11111";
            when s28	=> O_Valor_7S4 <= "01101";--d
								O_Valor_7S5 <= "11111";
								O_Valor_7S3 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S1 <= "11111";
								O_Valor_7S0 <= "11111";
            when s29 => O_Valor_7S5 <= "01101";--d
								O_Valor_7S4 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S1 <= "11111";
								O_Valor_7S0 <= "11111";
            when s30 => O_Valor_7S5 <= "01111";--e
								O_Valor_7S4 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S1 <= "11111";
								O_Valor_7S0 <= "11111";
            when s31 => O_Valor_7S5 <= "10000";--f
								O_Valor_7S4 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S1 <= "11111";
								O_Valor_7S0 <= "11111";
				when s32 => O_Valor_7S5 <= "11111";
								O_Valor_7S4 <= "11111"; 
								O_Valor_7S3 <= "11111";
								O_Valor_7S2 <= "11111";
								O_Valor_7S1 <= "11111";
								O_Valor_7S0 <= "11111";
				when others =>
			end case;
	end process;

end rtl;
