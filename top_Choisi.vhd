library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.StatePackage.all;

entity top_Choisi is
    port(
        KEY     : in std_logic_vector(4-1 downto 0); -- pour les pins  -> pinplaner (assignements)/datasheet -led :LEDR[] - BP: KEY[] -switch: SW[]
        SW      : in std_logic_vector(10-1 downto 0); -- zero up to 2
        CLOCK_50: in std_logic;
        LEDR    : out std_logic_vector(10-1 downto 0);
        HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : out std_logic_vector(7-1 downto 0)
    );
end entity;

architecture rtl of top_Choisi is
    signal JoueurChoisi : std_logic_vector(10-1 downto 0);
    signal StateMachine : state_type;
    signal DataAffiche7S0,DataAffiche7S1,DataAffiche7S2,DataAffiche7S3,DataAffiche7S4,DataAffiche7S5 : std_logic_vector(5-1 downto 0);
    signal DataAffiche7SChen0,DataAffiche7SChen1,DataAffiche7SChen2,DataAffiche7SChen3,DataAffiche7SChen4,DataAffiche7SChen5 : std_logic_vector(5-1 downto 0);
    signal DataAffiche7SMenu0,DataAffiche7SMenu1,DataAffiche7SMenu2,DataAffiche7SMenu3,DataAffiche7SMenu4,DataAffiche7SMenu5 : std_logic_vector(5-1 downto 0);
    signal EtatBP : std_logic_vector(4-1 downto 0);
    signal NombreJoueursEgaleNombreSwitch : std_logic;
    signal FlagChenillardFini: std_logic;
    signal LedSwitchON : std_logic_vector(10-1 downto 0);
    signal NombreJoueur : unsigned(4-1 downto 0);
    signal NombreDeJoueurAChoisir : unsigned(4-1 downto 0);
begin
    i_BP : entity work.GestionBP
        port map(
            I_BP => KEY,
            O_BP => EtatBP,
            CLK => CLOCK_50
        );

    i_led : entity work.LED
        port map(
            O_led => LEDR,  --entrée (10 bits)
            I_SwitchsON => LedSwitchON,  --entrée (10 bits)
            I_JoueurChoisi => JoueurChoisi,
            I_StateMachine => StateMachine,
            RST => EtatBP(3),
            CLK => CLOCK_50
        );


		i_Driv7s0: entity work.driver_7s 
			  port map(
					I_data => DataAffiche7s0,
					O_7s => HEX0,
					CLK => CLOCK_50,
					RST => EtatBP(3)
			  );
		i_Driv7s1: entity work.driver_7s 
		  port map(
				I_data => DataAffiche7s1,
				O_7s => HEX1,
				CLK => CLOCK_50,
				RST => EtatBP(3)
		  );

		i_Driv7s2: entity work.driver_7s 
		  port map(
				I_data => DataAffiche7s2,
				O_7s => HEX2,
				CLK => CLOCK_50,
				RST => EtatBP(3)
		  );

		i_Driv7s3: entity work.driver_7s 
		  port map(
				I_data => DataAffiche7s3,
				O_7s => HEX3,
				CLK => CLOCK_50,
				RST => EtatBP(3)
		  );

		i_Driv7s4: entity work.driver_7s 
		  port map(
				I_data => DataAffiche7s4,
				O_7s => HEX4,
				CLK => CLOCK_50,
				RST => EtatBP(3)
		  );

		i_Driv7s5: entity work.driver_7s 
		  port map(
				I_data => DataAffiche7s5,
				O_7s => HEX5,
				CLK => CLOCK_50,
				RST => EtatBP(3)
		  );	
		  	  
		  

    i_FSM : entity work.StateMAchine 
        port map(
            I_BP => EtatBP,
            I_switch_Joueurs_OK => NombreJoueursEgaleNombreSwitch,
            O_State => StateMachine, 
            I_FinChennillard => FlagChenillardFini,
				RST => EtatBP(3),
            CLK => CLOCK_50
        );

    i_Storage: entity work.Storage 
        port map(
            I_BP => EtatBP,
            I_Switches => SW,
            I_StateMachine => StateMachine,
            O_LedJoueurs => LedSwitchON,
            O_NombreJoueurs => NombreJoueur,
            O_NombreDeChoisis => NombreDeJoueurAChoisir,
            O_NmbrSwitch_NmbrJoueur_ok => NombreJoueursEgaleNombreSwitch,
				RST => EtatBP(3),
            CLK => CLOCK_50
        );

    i_Chenillard : entity work.Chennillard 
        port map(
            I_StateMachine => StateMachine,
            O_FinChennillard => FlagChenillardFini,
            O_Valor_7S0 => DataAffiche7SChen0,
				O_Valor_7S1 => DataAffiche7SChen1,
				O_Valor_7S2 => DataAffiche7SChen2,
				O_Valor_7S3 => DataAffiche7SChen3,
				O_Valor_7S4 => DataAffiche7SChen4,
				O_Valor_7S5 => DataAffiche7SChen5,
            RST => EtatBP(3),
            CLK => CLOCK_50
        );

    i_Menu : entity work.menu 
        port map(
            O_Valor_7S0 => DataAffiche7SMenu0,
				O_Valor_7S1 => DataAffiche7SMenu1,
				O_Valor_7S2 => DataAffiche7SMenu2,
				O_Valor_7S3 => DataAffiche7SMenu3,
				O_Valor_7S4 => DataAffiche7SMenu4,
				O_Valor_7S5 => DataAffiche7SMenu5,
            I_NombreJoueurs => NombreJoueur,
            I_NombreDeChoisis => NombreDeJoueurAChoisir,
            I_StateMachine => StateMachine,
				RST => EtatBP(3),
            CLK => CLOCK_50
        );

    i_random : entity work.Random 
        port map(
            I_NombreDeChoisis => NombreDeJoueurAChoisir,
            I_SwitchJoueurs => LedSwitchON,
            I_StateMachine => StateMachine,
            O_JoueurChoisi => JoueurChoisi,
				RST => EtatBP(3),
            CLK => CLOCK_50
        );
	 i_GestionnaireSortie7s : entity work.Gestionnaire7s
	port map(
			I_DataAffiche7SMenu0 => DataAffiche7SMenu0,
			I_DataAffiche7SMenu1 => DataAffiche7SMenu1,
			I_DataAffiche7SMenu2 => DataAffiche7SMenu2,
			I_DataAffiche7SMenu3 => DataAffiche7SMenu3,
			I_DataAffiche7SMenu4 => DataAffiche7SMenu4,
			I_DataAffiche7SMenu5 => DataAffiche7SMenu5,
			I_DataAffiche7SChen0 => DataAffiche7SChen0,
			I_DataAffiche7SChen1 => DataAffiche7SChen1,
			I_DataAffiche7SChen2 => DataAffiche7SChen2,
			I_DataAffiche7SChen3 => DataAffiche7SChen3,
			I_DataAffiche7SChen4 => DataAffiche7SChen4,
			I_DataAffiche7SChen5 => DataAffiche7SChen5,
			O_DataAffiche7S0 => DataAffiche7s0,
			O_DataAffiche7S1 => DataAffiche7s1,
			O_DataAffiche7S2 => DataAffiche7s2,
			O_DataAffiche7S3 => DataAffiche7s3,
			O_DataAffiche7S4 => DataAffiche7s4,
			O_DataAffiche7S5 => DataAffiche7s5,
			I_StateMachine => StateMachine,
			RST => EtatBP(3),
			CLK => CLOCK_50
		 );
end architecture;
