library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity GestionBP is
    port(
        clk : in std_logic;                  
        KEY : in std_logic_vector(3 downto 0); -- Entrée des boutons poussoirs
        O_BP : out std_logic_vector(3 downto 0) -- Sortie des boutons stables
    );
end entity GestionBP;

architecture rtl of GestionBP is
    
    constant DELAY_TICKS : integer := 500000;  -- 10 ms à 50 MHz (50 MHz * 10 ms = 500 000 cycles)
    
    signal debounce_counter : integer_vector(3 downto 0)   := (others => 0);
    signal stable_state     : std_logic_vector(3 downto 0) := (others => '1');
    signal previous_state   : std_logic_vector(3 downto 0) := (others => '1');
    signal button_pressed   : std_logic_vector(3 downto 0) := (others => '0');
    
begin
    process (clk)
    begin
        if rising_edge(clk) then
            for i in 0 to 3 loop

                if KEY(i) /= stable_state(i) then
                    debounce_counter(i) <= 0;						-- Si bouton change d'état, réinitialiser le compteur
                else
                    if debounce_counter(i) < DELAY_TICKS then 		-- Incrémenter le compteur si l'état est stable
                        debounce_counter(i) <= debounce_counter(i) + 1;
                    end if;

                    if debounce_counter(i) = DELAY_TICKS then		 -- Si le compteur atteint la valeur du seuil (10ms), l'état est considéré comme stable
                        stable_state(i) <= KEY(i);
                    end if;
                end if;

                -- Détection d'une pression (front descendant)
                if stable_state(i) = '0' and previous_state(i) = '1' then
                    button_pressed(i) <= '1';  -- Appui détecté
                else
                    button_pressed(i) <= '0';  -- Sinon, pas d'appui
                end if;

                previous_state(i) <= stable_state(i);
            end loop;
        end if;
    end process;

    O_BP <= button_pressed;

end architecture;

