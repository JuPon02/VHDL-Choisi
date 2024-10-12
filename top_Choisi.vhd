library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top_Choisi is
	port(
	clk        : in  std_logic
		 );
end entity;

architecture rtl of top_Choisi is

	component LED
		port(
			i_led : in STD_LOGIC_VECTOR (10-1 downto 0);  --entrée (10 bits)
			o_led : out STD_LOGIC_VECTOR (10-1 downto 0) --sortie (10 bits pour 10 led)
			 );
	end component;
	
	component Switch
		port(
			I_switchs : in std_logic_vector(10-1 downto 0);
			O_switchs : out std_logic_vector(10-1 downto 0)
			);
	end component;
	
	component driver7s
		port(
			I_data : in std_logic_vector(3 downto 0);
			O_7s : out std_logic_vector(6 downto 0);
			CLK, RESET : in std_logic 
			);
	end component;
	
	component Random 
		port(
			CLOCK_50	: in	std_logic;
			KEY			: in std_logic_vector(4-1 downto 0); --KEY(0) bouton de lancement sinon modif process ligne 18
			val_rand	: out std_logic_vector(4-1 downto 0) --Valeur du compteur lors de l'appui
			);
	end component;
	
	begin
	
--UUT1: driver7s
--    port map (
--        I_data => I_data1,
--        O_7s => O_7s1,
--        CLK => CLK1,
--        RESET => RESET1
--    );
--
--UUT2: driver7s
--    port map (
--        I_data => I_data2,
--        O_7s => O_7s2,
--        CLK => CLK2,
--        RESET => RESET2
--    );
--
--UUT3: driver7s
--    port map (
--        I_data => I_data3,
--        O_7s => O_7s3,
--        CLK => CLK3,
--        RESET => RESET3
--    );
--
--UUT4: driver7s
--    port map (
--        I_data => I_data4,
--        O_7s => O_7s4,
--        CLK => CLK4,
--        RESET => RESET4
--    );
--
--UUT5: driver7s
--    port map (
--        I_data => I_data5,
--        O_7s => O_7s5,
--        CLK => CLK5,
--        RESET => RESET5
--    );
--
--UUT6: driver7s
--    port map (
--        I_data => I_data6,
--        O_7s => O_7s6,
--        CLK => CLK6,
--        RESET => RESET6
--    );

		
end architecture;