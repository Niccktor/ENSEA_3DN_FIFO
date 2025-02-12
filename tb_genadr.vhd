library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.ENSEA_pkg.all;  -- Importation du package contenant le compteur

entity tb_GENADR is
end tb_GENADR;

architecture Behavioral of tb_GENADR is
    -- Paramètre pour le test (taille de l'adresse)
    constant M : integer := 4;  -- Utilisation de 4 bits pour test rapide

    -- Signaux de test
    signal clk      : STD_LOGIC := '0';
    signal rst      : STD_LOGIC := '0';
    signal incread  : STD_LOGIC := '0';
    signal incwrite : STD_LOGIC := '0';
    signal selread  : STD_LOGIC := '0';
    signal Adrg     : STD_LOGIC_VECTOR (M-1 downto 0);

    -- Période de l'horloge (10 ns)
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instanciation du module GENADR
    uut: entity work.GENADR
        generic map ( M => M )
        port map (
            clk      => clk,
            rst      => rst,
            incread  => incread,
            incwrite => incwrite,
            selread  => selread,
            Adrg     => Adrg
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

        -- Étape 2 : Incrémentation de l'adresse de lecture
        incread <= '1';
	wait for 20 ns;
	selread <= '1';
        wait for 20 ns;
        incread <= '0';

        -- Étape 3 : Changer vers l'incrémentation de l'adresse d'écriture
        incwrite <= '1';
	wait for 20 ns;
	selread <= '0';
        wait for 40 ns;
        incwrite <= '0';

        -- Étape 4 : Sélectionner l'adresse de lecture
        selread <= '1';
        wait for 40 ns;

        -- Étape 5 : Sélectionner l'adresse d'écriture
        selread <= '0';
        wait for 40 ns;

        -- Étape 6 : Appliquer un nouveau reset pour vérifier la réinitialisation
        rst <= '1';
        wait for 20 ns;
        rst <= '0';

        -- Fin de la simulation
        wait;
    end process;

end Behavioral;

