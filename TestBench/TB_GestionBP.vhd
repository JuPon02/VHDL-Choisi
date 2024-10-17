library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity GestionBP_tb is
    -- Pas de ports pour un test bench
end entity GestionBP_tb;

architecture behavior of GestionBP_tb is

    -- Composant sous test (CUT)
    component GestionBP
        port(
            clk : in std_logic;                  
            I_BP : in std_logic_vector(3 downto 0); -- Entrée des boutons poussoirs
            O_BP : out std_logic_vector(3 downto 0) -- Sortie des boutons stables
        );
    end component;

    -- Signaux internes pour la simulation
    signal clk_tb : std_logic := '0';
    signal I_BP_tb : std_logic_vector(3 downto 0) := (others => '0');
    signal O_BP_tb : std_logic_vector(3 downto 0);

    -- Période de l'horloge
    constant clk_period : time := 20 ns;

begin

    -- Instanciation du composant sous test
    uut: GestionBP
        port map (
            clk => clk_tb,
            I_BP => I_BP_tb,
            O_BP => O_BP_tb
        );

    -- Génération de l'horloge
    clk_process : process
    begin
        clk_tb <= '0';
        wait for clk_period / 2;
        clk_tb <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimuli pour tester le module
    stimulus: process
    begin
        -- Initialisation des entrées
        I_BP_tb <= "0000";
        wait for 20 ns;
        
        -- Simuler l'appui sur le bouton 0
        I_BP_tb(0) <= '1';
        wait for 10 ms;
        I_BP_tb(0) <= '0';
        wait for 20 ms;
        
        -- Simuler l'appui sur le bouton 1
        I_BP_tb(1) <= '1';
        wait for 10 ms;
        I_BP_tb(1) <= '0';
        wait for 20 ms;

        -- Simuler l'appui sur le bouton 2
        I_BP_tb(2) <= '1';
        wait for 10 ms;
        I_BP_tb(2) <= '0';
        wait for 20 ms;

        -- Simuler l'appui sur le bouton 3
        I_BP_tb(3) <= '1';
        wait for 10 ms;
        I_BP_tb(3) <= '0';
        wait for 20 ms;
        
		I_BP_tb(0) <= '1';
        wait for 1 ms;
        I_BP_tb(0) <= '0';
        wait for 1 ms;
		I_BP_tb(0) <= '1';
        wait for 1 ms;
        I_BP_tb(0) <= '0';
        wait for 1 ms;
		I_BP_tb(0) <= '1';
        wait for 10 ms;
        I_BP_tb(0) <= '0';
        wait for 20 ms;
        -- Fin de la simulation
        wait;
    end process;

end architecture;
