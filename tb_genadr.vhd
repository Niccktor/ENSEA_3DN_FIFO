library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.ENSEA_pkg.all;  -- Importation du package contenant le compteur

entity tb_GENADR is
end tb_GENADR;

architecture Behavioral of tb_GENADR is
    -- Param�tre pour le test (taille de l'adresse)
    constant M : integer := 4;  -- Utilisation de 4 bits pour test rapide

    -- Signaux de test
    signal clk      : STD_LOGIC := '0';
    signal rst      : STD_LOGIC := '0';
    signal incread  : STD_LOGIC := '0';
    signal incwrite : STD_LOGIC := '0';
    signal selread  : STD_LOGIC := '0';
    signal Adrg     : STD_LOGIC_VECTOR (M-1 downto 0);

    -- P�riode de l'horloge (10 ns)
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

    -- G�n�ration de l'horloge (10 ns de p�riode)
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
        -- �tape 1 : Appliquer un reset initial
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 10 ns;

        -- �tape 2 : Incr�mentation de l'adresse de lecture
        incread <= '1';
	wait for 20 ns;
	selread <= '1';
        wait for 20 ns;
        incread <= '0';

        -- �tape 3 : Changer vers l'incr�mentation de l'adresse d'�criture
        incwrite <= '1';
	wait for 20 ns;
	selread <= '0';
        wait for 40 ns;
        incwrite <= '0';

        -- �tape 4 : S�lectionner l'adresse de lecture
        selread <= '1';
        wait for 40 ns;

        -- �tape 5 : S�lectionner l'adresse d'�criture
        selread <= '0';
        wait for 40 ns;

        -- �tape 6 : Appliquer un nouveau reset pour v�rifier la r�initialisation
        rst <= '1';
        wait for 20 ns;
        rst <= '0';

        -- Fin de la simulation
        wait;
    end process;

end Behavioral;

