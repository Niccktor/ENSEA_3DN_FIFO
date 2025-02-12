library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.ENSEA_pkg.all;  -- Importation du package contenant le compteur

entity GENADR is
    Generic ( M : integer := 8 );  -- Taille des adresses
    Port (
        clk      : in  STD_LOGIC;  -- Horloge
        rst      : in  STD_LOGIC;  -- Reset global
        incread  : in  STD_LOGIC;  -- Incrémentation adresse de lecture
        incwrite : in  STD_LOGIC;  -- Incrémentation adresse d'écriture
        selread  : in  STD_LOGIC;  -- Sélection du compteur actif
        Adrg     : out STD_LOGIC_VECTOR (M-1 downto 0)  -- Adresse générée
    );
end GENADR;

architecture Behavioral of GENADR is
    -- Signaux pour les deux compteurs
    signal count_read  : STD_LOGIC_VECTOR (M-1 downto 0);
    signal count_write : STD_LOGIC_VECTOR (M-1 downto 0);
    
begin
    -- Instanciation du compteur pour la lecture
    compteur_read : compteur_decompteur
        generic map ( N => M )
        port map (
            clk     => clk,
            rst     => rst,
            enable  => incread,  -- Se met à jour uniquement si incread = 1
            up_down => '1',  -- Mode compteur uniquement
            count   => count_read
        );

    -- Instanciation du compteur pour l'écriture
    compteur_write : compteur_decompteur
        generic map ( N => M )
        port map (
            clk     => clk,
            rst     => rst,
            enable  => incwrite,  -- Se met à jour uniquement si incwrite = 1
            up_down => '1',  -- Mode compteur uniquement
            count   => count_write
        );

    -- Multiplexeur combinatoire : sélection de l'adresse finale
    Adrg <= count_read when selread = '1' else count_write;

end Behavioral;

