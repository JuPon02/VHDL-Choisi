library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.StatePackage.all;

entity GestionBP is
    port(                 
        I_BP_n_n : in std_logic_vector(4-1 downto 0); -- Entrée des boutons poussoirs
        O_BP_n : out std_logic_vector(4-1 downto 0); -- Sortie des boutons stables
        CLK : in std_logic
    );
end entity GestionBP;

architecture rtl of GestionBP is
    signal previous_state : std_logic_vector(4-1 downto 0);
    signal counter : unsigned(24-1 downto 0);
    signal flag : std_logic;
begin
    process(CLK, I_BP_n_n)
    begin
        if I_BP_n_n = C_BP_RST then
            previous_state <= C_BP_RST;
            counter <= (others => '0');
            flag <= '0';
        elsif rising_edge(CLK) then
            if I_BP_n_n /= previous_state and flag = '0' then
                flag <= '1';
                previous_state <= I_BP_n_n;  
            elsif flag = '1' then
                counter <= counter + 1;
                if counter = "010011000100101101000000" then  -- 100ms
                    counter <= (others => '0');
                    flag <= '0';
                end if;
            end if;
        end if;
    end process;
    
    O_BP_n <= previous_state; -- Mise à jour de la sortie ici
end architecture;
