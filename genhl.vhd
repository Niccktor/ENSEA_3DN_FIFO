library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.ENSEA_pkg.all;  -- Importation du package contenant le compteur

entity GENHL is
    Generic ( DIV : integer := 200 );  -- Paramètre du diviseur
    Port (
        clk     : in  STD_LOGIC;  -- Horloge principale
        rst     : in  STD_LOGIC;  -- Reset actif à 1
        ENREAD  : out STD_LOGIC;  -- Signal de lecture (synchrone)
        ENWRITE : out STD_LOGIC   -- Signal d'écriture (asynchrone)
    );
end GENHL;

architecture Behavioral of GENHL is
    -- Taille du compteur (8 bits)
    constant N : integer := 8;  

    -- Signaux internes
    signal count_val : STD_LOGIC_VECTOR (N-1 downto 0);
    signal enable    : STD_LOGIC := '1';  -- Activation permanente du compteur
    signal up_down   : STD_LOGIC := '1';  -- Mode incrémentation
    signal count_max : STD_LOGIC := '0';  -- Signal de comparaison pour DIV
    signal reset     : STD_LOGIC := '0';

begin
    -- Instanciation du compteur
    compteur_inst : compteur_decompteur
        generic map ( N => N )
        port map (
            clk     => clk,
            rst     => reset,
            enable  => enable,
            up_down => up_down,
            count   => count_val
        );

    -- Détection de la valeur maximale (comparaison combinatoire)
    count_max <= '1' when (count_val = CONV_STD_LOGIC_VECTOR(DIV-1, N)) else '0';
    reset <= '1' when (count_val = CONV_STD_LOGIC_VECTOR(DIV-1, N) or rst = '1') else '0';
    -- Génération combinatoire des signaux ENREAD et ENWRITE
    ENREAD  <= count_max;   	-- ENREAD actif quand le compteur atteint DIV-1
    ENWRITE <= NOT count_max;  	-- ENWRITE 

end Behavioral;

