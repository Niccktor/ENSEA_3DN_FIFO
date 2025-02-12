library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.ENSEA_pkg.all;  -- Importation du package contenant le compteur

entity tb_GENHL is
end tb_GENHL;

architecture Behavioral of tb_GENHL is
    -- Paramètre du diviseur pour test rapide (ex: 10 cycles au lieu de 200)
    constant DIV : integer := 10;

    -- Signaux internes pour la simulation
    signal clk     : STD_LOGIC := '0';
    signal rst     : STD_LOGIC := '0';
    signal ENREAD  : STD_LOGIC;
    signal ENWRITE : STD_LOGIC;

    -- Période de l'horloge (10 ns)
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instanciation du module GENHL
    uut: entity work.GENHL
        generic map ( DIV => DIV )
        port map (
            clk     => clk,
            rst     => rst,
            ENREAD  => ENREAD,
            ENWRITE => ENWRITE
        );

    -- Génération de l'horloge (10 ns de période)
    process
    begin
        while now < 200 ns loop  -- Simulation de 200 ns
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

        -- Étape 2 : Laisser tourner le diviseur et observer les sorties
        wait for 150 ns;

        -- Étape 3 : Appliquer un nouveau reset pour vérifier la réinitialisation
        rst <= '1';
        wait for 20 ns;
        rst <= '0';

        -- Fin de la simulation
        wait;
    end process;

end Behavioral;

