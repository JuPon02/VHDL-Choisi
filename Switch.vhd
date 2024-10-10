ibrary IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Switch is
	port(
		I_switchs : in std_logic_vector(10-1 downto 0);
		O_switchs : out std_logic_vector(10-1 downto 0)
		);
end entity;

architecture rtl of Switch is
	begin
		O_switchs <= I_switchs;
end rtl;