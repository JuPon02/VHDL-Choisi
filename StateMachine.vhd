library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.StatePackage.all;


entity StateMAchine is
	port(	I_BP : in std_logic_vector(4-1 downto 0);
			I_switch_Joueurs_OK : in std_logic;
			O_State : out state_type;
			CLK, RESET, I_FinChennillard : in std_logic 
		 );
end entity;

architecture rtl of StateMachine is

	signal state : state_type;

begin

	process (clk, reset)
	begin

		if reset = '1' then
			state <= MenuNombreJoueur;

		elsif (rising_edge(clk)) then

			-- Determine the next state synchronously, based on
			-- the current state and the input
			case state is
				when MenuNombreJoueur=>
					if I_BP = C_BP_right then
						state <= MenuNombreChoisis;
					else
						state <= MenuNombreJoueur;
					end if;
				when MenuNombreChoisis=>
					if I_BP = C_BP_right and I_switch_Joueurs_OK = '1' then
						state <= Chenillard;
					elsif I_BP = C_BP_RST then
						state <= MenuNombreJoueur;
					else
						state <= MenuNombreChoisis;
					end if;
				when Chenillard=>
					if I_FinChennillard = '1' then
						state <= AffichageChoisis;
					else
						state <= Chenillard;
					end if;
				when AffichageChoisis=>
					if I_BP = C_BP_right then
						state <= MenuNombreJoueur;
					else
						state <= AffichageChoisis;
					end if;
			end case;

		end if;
	end process;

	-- Determine the output based only on the current state
	-- and the input (do not wait for a clock edge).
	process (state)
	begin
			case state is
				when MenuNombreJoueur=>
					O_State <= MenuNombreJoueur;
				when MenuNombreChoisis=>
					O_State <= MenuNombreChoisis;
				when Chenillard=>
					O_State <= Chenillard;
				when AffichageChoisis=>
					O_State <= AffichageChoisis;
			end case;
	end process;
end rtl;