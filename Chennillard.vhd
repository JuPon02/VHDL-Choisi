library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity Chennillard is
    port(
        I_StateMachine : in std_logic_vector(1 downto 0);
        O_FinChennillard : out std_logic;
        O_Valor_7S : out std_logic_vector(5-1 downto 0);
        CLK, RESET : in std_logic
    );
end entity;

architecture rtl of Chennillard is

    -- Type énuméré pour les états
    type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15);
    signal state : state_type;
    signal slow_clk : std_logic := '0'; -- Signal pour l'horloge lente
    signal counter : integer := 0; -- Compteur pour diviser l'horloge
    signal cycle_count : integer := 0; -- Compteur de cycles pour savoir quand s'arrêter

    constant CLOCK_FREQUENCY : integer := 50000000; -- Fréquence de l'horloge d'entrée (50 MHz)
    constant HALF_SECOND_COUNT : integer := CLOCK_FREQUENCY / 2; -- Compte pour 0.5 seconde

begin

    -- Initialisation de la sortie à '0'
    O_FinChennillard <= '0';

    -- Processus pour générer une horloge lente de 0.5s
    process (CLK, RESET)
    begin
        if RESET = '1' then
            counter <= 0;
            slow_clk <= '0';
        elsif (rising_edge(CLK)) then
            if counter = HALF_SECOND_COUNT then
                counter <= 0;
                slow_clk <= not slow_clk; -- Inversion de l'horloge lente toutes les 0.5s
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    -- Processus de la machine d'états
    process (slow_clk, RESET)
    begin
        if RESET = '1' then
            state <= s0;
            cycle_count <= 0;
        elsif (rising_edge(slow_clk)) then
            -- Si l'état de la machine est "10" et que le chenillard n'a pas fini
            if I_StateMachine = "10" and cycle_count < 32 then
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
                    when s15 =>
                        state <= s0;
                        cycle_count <= cycle_count + 1; -- Augmente le compteur de cycles
                end case;
            elsif cycle_count >= 32 then
                O_FinChennillard <= '1'; -- Indique la fin du chenillard après 2 cycles complets
					 cycle_count <=0;
            end if;
        end if;
    end process;

    -- Sortie dépendant de l'état courant
    process (state)
    begin
        case state is
            when s0  => O_Valor_7S <= "01010";--a
            when s1  => O_Valor_7S <= "01010";--a
            when s2  => O_Valor_7S <= "01010";--a
            when s3  => O_Valor_7S <= "01010";--a
            when s4  => O_Valor_7S <= "01010";--a
            when s5  => O_Valor_7S <= "01010";--a
            when s6  => O_Valor_7S <= "01011";--b
            when s7  => O_Valor_7S <= "01100";--c
            when s8  => O_Valor_7S <= "01101";--d
            when s9  => O_Valor_7S <= "01101";--d
            when s10 => O_Valor_7S <= "01101";--d
            when s11 => O_Valor_7S <= "01101";--d
            when s12 => O_Valor_7S <= "01101";--d
            when s13 => O_Valor_7S <= "01101";--d
            when s14 => O_Valor_7S <= "01111";--e
            when s15 => O_Valor_7S <= "10000";--f
        end case;
    end process;

end rtl;
