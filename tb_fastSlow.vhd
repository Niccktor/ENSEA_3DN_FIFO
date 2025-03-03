
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.ENSEA_pkg.all;  -- Importation du package contenant le compteur

entity tb_FastSlow is
end tb_FastSlow;

architecture Behavioral of tb_FastSlow is
    -- Paramètre de test : FIFO de 16 mots (M=4)
    constant M : integer := 4;  

    -- Signaux de test
    signal clk      : STD_LOGIC := '0';
    signal rst      : STD_LOGIC := '0';
    signal incwrite : STD_LOGIC := '0';
    signal incread  : STD_LOGIC := '0';
    signal fast     : STD_LOGIC;
    signal slow     : STD_LOGIC;

    -- Période de l'horloge (10 ns)
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instanciation du module FastSlow
    uut: entity work.FastSlow
        generic map ( M => M )
        port map (
            clk      => clk,
            rst      => rst,
            incwrite => incwrite,
            incread  => incread,
            fast     => fast,
            slow     => slow
        );

    -- Génération de l'horloge (10 ns de période)
    process
    begin
        while now < 10000 ns loop  -- Simulation de 300 ns
            clk <= not clk;
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Stimulus principal
    process
    begin
        -- Étape 1 : Appliquer un reset initial
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 10 ns;

        -- Étape 2 : Remplissage progressif de la FIFO
        for i in 0 to 15 loop
            incwrite <= '1';
            wait for 10 ns;
        end loop;
	incwrite <= '0';
	wait for 30 ns;

        -- Étape 3 : Déchargement de la FIFO
        for i in 0 to 15 loop
            incread <= '1';
            wait for 10 ns;
        end loop;
        incread <= '0';
	incwrite <= '0';
	wait for 100 ns;

        -- Étape 4 : Vérification des seuils
        -- Écriture jusqu'au seuil de slow (>= 12 éléments)
        for i in 0 to 11 loop
            incwrite <= '1';
            wait for 10 ns;
        end loop;
        incwrite <= '0';
        -- Attendre pour observer slow actif
        wait for 20 ns;

        -- Lecture jusqu'au seuil de fast (< 2^M - 2 = 14 pour M=4)
        for i in 0 to 2 loop
            incread <= '1';
            wait for 10 ns;
        end loop;
        
        -- Attendre pour observer fast actif
        wait for 20 ns;

        -- Étape 5 : Appliquer un nouveau reset
        rst <= '1';
        wait for 20 ns;
        rst <= '0';

        -- Fin de la simulation
        wait;
    end process;

end Behavioral;
