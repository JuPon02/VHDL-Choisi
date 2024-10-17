library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity GestionBP is
    port(
        clk : in std_logic;                  
        I_BP : in std_logic_vector(3 downto 0); -- Entrée des boutons poussoirs
        O_BP : out std_logic_vector(3 downto 0) -- Sortie des boutons stables
    );
end entity GestionBP;

architecture rtl of GestionBP is

    constant DELAY_TICKS : integer := 500000; -- Nombre de cycles d'horloge pour atteindre le délai de debounce (10 ms à 50 MHz)
    
    -- Déclaration d'un tableau d'entiers
    type integer_array is array (0 to 3) of integer;
    signal debounce_counter : integer_array := (others => 0);
    signal stable_state     : std_logic_vector(3 downto 0) := (others => '1');

begin
    process(clk)
    begin
        if rising_edge(clk) then
            for i in 0 to 3 loop
                -- Si l'état du bouton change par rapport à l'état stable
                if I_BP(i) /= stable_state(i) then
                    -- Réinitialiser le compteur si l'état change
                    debounce_counter(i) <= 0;
                else
                    -- Incrémenter le compteur si l'état est stable
                    if debounce_counter(i) < DELAY_TICKS then
                        debounce_counter(i) <= debounce_counter(i) + 1;
                    end if;
                    
                    -- Si le compteur atteint le délai, on considère l'état comme stable
                    if debounce_counter(i) = DELAY_TICKS then
                        stable_state(i) <= I_BP(i);
                    end if;
                end if;
            end loop;
        end if;
    end process;

    -- La sortie est l'état stable des boutons
    O_BP <= stable_state;

end architecture;
