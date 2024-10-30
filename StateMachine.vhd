library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.StatePackage.all;

entity StateMAchine is
    port(
        I_BP_n : in std_logic_vector(4-1 downto 0);
        I_switch_Joueurs_OK : in std_logic;
        O_State : out state_type;
        I_FinChennillard : in std_logic;
        CLK, RST_n : in std_logic
    );
end entity;

architecture rtl of StateMachine is

    signal state : state_type;
    signal previous_I_BP_n : std_logic_vector(3 downto 0);

begin

    process (CLK, I_BP_n, RST_n)
    begin
        if RST_n = '0' then
            state <= MenuNombreJoueur;
            previous_I_BP_n <= (others => '0');
        elsif rising_edge(CLK) then
            -- Determine the next state synchronously, based on
            -- the current state and the input
            if (previous_I_BP_n(0) = '1' and I_BP_n(0) = '0') or
               (previous_I_BP_n(1) = '1' and I_BP_n(1) = '0') or
               (previous_I_BP_n(2) = '1' and I_BP_n(2) = '0') or
               (I_FinChennillard = '1') then
                case state is
                    when MenuNombreJoueur =>
                        if I_BP_n = C_BP_right then
                            state <= MenuNombreChoisis;
                        else
                            state <= MenuNombreJoueur;
                        end if;
                    when MenuNombreChoisis =>
                        if I_BP_n = C_BP_right and I_switch_Joueurs_OK = '1' then
                            state <= Chenillard;
                        else
                            state <= MenuNombreChoisis;
                        end if;
                    when Chenillard =>
                        if I_FinChennillard = '1' then
                            state <= AffichageChoisis;
                        else
                            state <= Chenillard;
                        end if;
                    when AffichageChoisis =>
                        if I_BP_n = C_BP_right then
                            state <= MenuNombreJoueur;
                        else
                            state <= AffichageChoisis;
                        end if;
                end case;
            end if;
            previous_I_BP_n <= I_BP_n;
        end if;
    end process;

    -- Determine the output based only on the current state
    -- and the input (do not wait for a clock edge).
    process (state)
    begin
        case state is
            when MenuNombreJoueur =>
                O_State <= MenuNombreJoueur;
            when MenuNombreChoisis =>
                O_State <= MenuNombreChoisis;
            when Chenillard =>
                O_State <= Chenillard;
            when AffichageChoisis =>
                O_State <= AffichageChoisis;
        end case;
    end process;
end rtl;
