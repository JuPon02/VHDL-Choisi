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
    signal DataAffiche7S : std_logic_vector(8-1 downto 0);
    signal DataAffiche7SChen : std_logic_vector(8-1 downto 0);
    signal DataAffiche7SMenu : std_logic_vector(8-1 downto 0);
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
            RST => EtatBP(3),
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

    i_Driv7s: entity work.driver_7s 
        port map(
            I_data => DataAffiche7s,
            O_7s1 => HEX0,
            O_7s2 => HEX1,
            O_7s3 => HEX2,
            O_7s4 => HEX3,
            O_7s5 => HEX4,
            O_7s6 => HEX5,
            CLK => CLOCK_50,
            RST => EtatBP(3)
        );

    i_FSM : entity work.StateMAchine 
        port map(
            I_BP => KEY,
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
            O_Valor_7S => DataAffiche7SChen,
            RST => EtatBP(3),
            CLK => CLOCK_50
        );

    i_Menu : entity work.menu 
        port map(
            O_Valor_7S => DataAffiche7SMenu,
            I_NombreJoueurs => NombreJoueur,
            I_NombreDeChoisis => NombreDeJoueurAChoisir,
            I_StateMachine => StateMachine,
				RST => EtatBP(3),
            CLK => CLOCK_50
        );

    i_random : entity work.Random 
        port map(
            I_NombreDeChoisis => NombreDeJoueurAChoisir,
            I_SwitchJoueurs => SW,
            I_StateMachine => StateMachine,
            O_JoueurChoisi => JoueurChoisi,
				RST => EtatBP(3),
            CLK => CLOCK_50
        );
	 i_GestionnaireSortie7s : entity work.Gestionnaire7s
	port map(
		 I_DataAffiche7SMenu => DataAffiche7SMenu,
		 I_DataAffiche7SChen => DataAffiche7SChen,
		 O_DataAffiche7S => DataAffiche7s,
		 I_StateMachine => StateMachine,
		 RST => EtatBP(3),
       CLK => CLOCK_50
		 );
end architecture;
