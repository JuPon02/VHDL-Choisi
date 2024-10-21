library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity GestionBP is
    port(                 
        I_BP : in std_logic_vector(4-1 downto 0); -- Entrée des boutons poussoirs
        O_BP : out std_logic_vector(4-1 downto 0); -- Sortie des boutons stables
		  CLK, RST : in std_logic
    );
end entity GestionBP;

architecture rtl of GestionBP is
    signal previous_state : std_logic_vector(4-1 downto 0):= "0000";
    signal counter : std_logic_vector(20-1 downto 0):="00000000000000000000";
    signal flag : std_logic := '0';
begin
    process(CLK)
    begin
			if rising_edge(clk) then
            if I_BP /= previous_state and flag = '0' then
					 O_BP <= previous_state; -- Mise à jour de la sortie ici
                flag <= '1';
                previous_state <= I_BP;
					
            end if;
            
            if flag = '1' then
                counter <= std_logic_vector(unsigned(counter) + 1);
                if counter = "00011010000100100000" then  --10ms
                    counter <= (others => '0');
                    flag <= '0';
                end if;
            end if;
        end if;
    end process;
end architecture;
