library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity StateMAchine is
	generic(
		BP_up : std_logic_vector(4-1 downto 0):= "0001";
		BP_down : std_logic_vector(4-1 downto 0) := "0010";
		BP_left : std_logic_vector(4-1 downto 0) := "0100";
		BP_right : std_logic_vector(4-1 downto 0) := "1000"
	);
	port(	I_BP : in std_logic_vector(4-1 downto 0);
			I_switch_Joueurs_OK : in std_logic;
			O_State : out std_logic_vector(2-1 downto 0);
			CLK, RESET, I_FinChennillard : in std_logic 
		 );
end entity;

architecture rtl of StateMachine is

	-- Build an enumerated type for the state machine
	type state_type is (s0, s1, s2, s3);

	-- Register to hold the current state
	signal state : state_type;

begin

	process (clk, reset)
	begin

		if reset = '1' then
			state <= s0;

		elsif (rising_edge(clk)) then

			-- Determine the next state synchronously, based on
			-- the current state and the input
			case state is
				when s0=>
					if I_BP = BP_right then
						state <= s1;
					else
						state <= s0;
					end if;
				when s1=>
					if I_BP = BP_right and I_switch_Joueurs_OK = '1' then
						state <= s2;
					elsif I_BP = BP_left then
						state <= s0;
					else
						state <= s1;
					end if;
				when s2=>
					if I_FinChennillard = '1' then
						state <= s3;
					else
						state <= s2;
					end if;
				when s3=>
					if I_BP = BP_right then
						state <= s0;
					else
						state <= s3;
					end if;
			end case;

		end if;
	end process;

	-- Determine the output based only on the current state
	-- and the input (do not wait for a clock edge).
	process (state)
	begin
			case state is
				when s0=>
					O_State <= "00";
				when s1=>
					O_State <= "01";
				when s2=>
					O_State <= "10";
				when s3=>
					O_State <= "11";
			end case;
	end process;
end rtl;