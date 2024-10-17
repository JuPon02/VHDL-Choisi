library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity TB_LED is
port(
        LEDR : out STD_LOGIC_VECTOR (10-1 downto 0)
    );
end entity TB_LED;

architecture behavior of TB_LED is

    -- Composant sous test (CUT)
    component LED
        port(
            O_led : out STD_LOGIC_VECTOR (10-1 downto 0);  --entrée (10 bits)
			I_SwitchsON: in STD_LOGIC_VECTOR (10-1 downto 0);  --entrée (10 bits)
			I_JoueurChoisi : in STD_LOGIC_VECTOR (10-1 downto 0);  --entrée (10 bits)
			I_StateMachine : in STD_LOGIC_VECTOR (2-1 downto 0)  --entrée (10 bits)
        );
    end component;

    -- Signaux internes pour la simulation
    --signal O_led_tb : STD_LOGIC_VECTOR (10-1 downto 0):= (others => '0');
    signal I_SwitchsON_tb : STD_LOGIC_VECTOR (10-1 downto 0):= (others => '0');
    signal I_JoueurChoisi_tb : STD_LOGIC_VECTOR (10-1 downto 0):= (others => '0');
	signal I_StateMachine_tb : STD_LOGIC_VECTOR (2-1 downto 0):= (others => '0');

    -- Période de l'horloge
    constant clk_period : time := 20 ns;

begin

    -- Instanciation du composant sous test
    uut: LED
        port map (
            O_led => LEDR,
			I_SwitchsON => I_SwitchsON_tb,
			I_JoueurChoisi => I_JoueurChoisi_tb,
			I_StateMachine => I_StateMachine_tb
        ); 


    -- Stimuli pour tester le module
    stimulus: process
    begin
        I_StateMachine_tb <= "00";
        wait for 20 ns;
        
		I_JoueurChoisi_tb <= "0010000000";

        I_SwitchsON_tb(4) <= '1';
        wait for 10 ms;
		I_SwitchsON_tb(2) <= '1';
        wait for 10 ms;
		I_SwitchsON_tb(3) <= '1';
        wait for 10 ms;
		I_SwitchsON_tb(8) <= '1';
        wait for 10 ms;
		I_SwitchsON_tb(7) <= '1';
        wait for 10 ms;
		
		I_StateMachine_tb <= "01";
		wait for 10 ms;
		I_SwitchsON_tb(5) <= '1';
        wait for 10 ms;
		I_SwitchsON_tb(3) <= '0';
        wait for 10 ms;
		I_SwitchsON_tb(9) <= '1';
        wait for 10 ms;
		
		I_StateMachine_tb <= "10";
		wait for 10 ms;
		I_SwitchsON_tb(5) <= '0';
        wait for 10 ms;
		I_SwitchsON_tb(1) <= '1';
        wait for 10 ms;
		I_SwitchsON_tb(6) <= '1';
        wait for 10 ms;
		
		I_StateMachine_tb <= "11";
       
		wait for 10 ms;
		
		I_StateMachine_tb <= "00";
        -- Fin de la simulation
        wait;
    end process;

end architecture;
