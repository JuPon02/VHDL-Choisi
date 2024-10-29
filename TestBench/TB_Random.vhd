library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.StatePackage.all;

entity TB_Random is
    -- Pas de ports pour un test bench
end entity TB_Random;

architecture behavior of TB_Random is

    -- Composant sous test (CUT)
    component Random
        port(
			I_NombreDeChoisis  : in unsigned(4-1 downto 0);
			I_SwitchJoueurs    : in std_logic_vector(10-1 downto 0);
			I_StateMachine     : in state_type;
			O_JoueurChoisi     : out std_logic_vector (10-1 downto 0);
			CLK, RST : in std_logic
        );
    end component;

    -- Signaux internes pour la simulation
	
		signal Switches :  std_logic_vector(10-1 downto 0):= (others => '0');
		signal JoueurChoisi :  std_logic_vector(10-1 downto 0):= (others => '0');
		signal StateMachine : state_type:=MenuNombreJoueur;
		signal NombreDeChoisis : unsigned(4-1 downto 0):= (others => '0');
		signal RST1 : std_logic:='1';
	
    signal clk_tb : std_logic := '0';
    -- Période de l'horloge
    constant clk_period : time := 20 ns;

begin

    -- Instanciation du composant sous test
    uut: Random
        port map (
            I_NombreDeChoisis  => NombreDeChoisis,
			I_SwitchJoueurs => Switches,
			I_StateMachine => StateMachine,
			O_JoueurChoisi => JoueurChoisi,
			CLK =>clk_tb,
			RST => RST1
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
		wait for 200 ns;
        RST1 <= '0';
        wait for 100 ns;
		RST1 <= '1';
        
		wait for 100 ns;
		NombreDeChoisis <= "0001";
		Switches <= "0010100101";
        -- Simuler l'appui sur le bouton 0
        
        wait for 200 ns;
		
		StateMachine <= Chenillard;
		wait for 200 ns;
        RST1 <= '0';
        wait for 100 ns;
		RST1 <= '1';
		
        -- Fin de la simulation
        wait;
    end process;

end architecture;
