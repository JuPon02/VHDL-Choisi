library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.StatePackage.all;

entity TB_Storage is
    -- Pas de ports pour un test bench
end entity TB_Storage;

architecture behavior of TB_Storage is

    -- Composant sous test (CUT)
    component Storage
        port(
          I_BP : in std_logic_vector(4-1 downto 0);
		  I_Switches : in std_logic_vector(10-1 downto 0);
		  I_StateMachine : in state_type;
		  
		  O_LedJoueurs :out std_logic_vector(10-1 downto 0);
		  O_NombreJoueurs : out unsigned(4-1 downto 0);
		  O_NombreDeChoisis : out unsigned(4-1 downto 0);
		  O_NmbrSwitch_NmbrJoueur_ok : out std_logic;
		  CLK, RST : in std_logic
        );
    end component;

    -- Signaux internes pour la simulation
	
	
		signal BP : std_logic_vector(4-1 downto 0):= (others => '1');
		signal Switches :  std_logic_vector(10-1 downto 0):= (others => '0');
		signal StateMachine : state_type;
	  
		signal LedJoueurs : std_logic_vector(10-1 downto 0):= (others => '0');
		signal NombreJoueurs : unsigned(4-1 downto 0):= (others => '0');
		signal NombreDeChoisis : unsigned(4-1 downto 0):= (others => '0');
		signal NmbrSwitch_NmbrJoueur_ok :std_logic:= '0';
		signal RST1 : std_logic:='1';
	
    signal clk_tb : std_logic := '0';
    signal I_BP_tb : std_logic_vector(3 downto 0) := (others => '0');
    signal O_BP_tb : std_logic_vector(3 downto 0);

    -- Période de l'horloge
    constant clk_period : time := 20 ns;

begin

    -- Instanciation du composant sous test
    uut: Storage
        port map (
            I_BP =>BP,
			  I_Switches =>Switches,
			  I_StateMachine =>StateMachine,
			  
			  O_LedJoueurs =>LedJoueurs,
			  O_NombreJoueurs =>NombreJoueurs,
			  O_NombreDeChoisis =>NombreDeChoisis,
			  O_NmbrSwitch_NmbrJoueur_ok =>NmbrSwitch_NmbrJoueur_ok,
			  CLK=>clk_tb,
			  RST =>RST1
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
        wait for 200 ns;
		RST1 <= '1';
        
        -- Simuler l'appui sur le bouton 0
        Switches(0) <= '1';
        wait for 100 ns;
        Switches(0) <= '0';
        wait for 100 ns;
        
        -- Simuler l'appui sur le bouton 1
        Switches(1) <= '1';
        wait for 100 ns;
        Switches(2) <= '1';
        wait for 100 ns;

        -- Simuler l'appui sur le bouton 2
        Switches(3) <= '1';
        wait for 100 ns;
        Switches(4) <= '1';
        wait for 200 ns;

        -- Simuler l'appui sur le bouton 3
        Switches(5) <= '1';
        wait for 200 ns;
        Switches(6) <= '0';
        wait for 200 ns;
        
		Switches(7) <= '1';
        wait for 200 ns;
        Switches(7) <= '0';
        wait for 200 ns;
		Switches(8) <= '1';
        wait for 200 ns;
        Switches(8) <= '0';
        wait for 200 ns;
		Switches(9)<= '1';
        wait for 100 ns;
        Switches(9) <= '0';
        wait for 200 ns;
        -- Fin de la simulation
		wait for 100 ns;
        RST1 <= '0';
        wait for 200 ns;
		RST1 <= '1';
				
        wait;
    end process;

end architecture;
