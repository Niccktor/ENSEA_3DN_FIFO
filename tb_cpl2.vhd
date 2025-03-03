library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;
use work.mes_fonctions.all;  -- Importation du package contenant le CPL2

entity tb_cpl2 is
end tb_cpl2;

architecture Behavioral of tb_cpl2 is
    -- Paramètre de test
	signal N : natural := 4;

    -- Signaux de test
	signal clk : std_logic := '0';
	signal A : std_logic_vector (N-1 downto 0):= (others => '0');
	signal result  : std_logic_vector(N-1 downto 0);

    -- Période de l'horloge (10 ns)
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instanciation du module cpl2

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
	A <= std_logic_vector(to_unsigned(1, A'length)); -- 0001
       	result <= cpl2(A, N); -- CC2 de 0001 => 1110 + 1 => 1111
	wait for 10 ns;

	A <= std_logic_vector(to_unsigned(4, A'length)); -- 0100
       	result <= cpl2(A, N); -- CC2 de 0100 => 1011 + 1 => 1100
	wait for 10 ns;

	A <= std_logic_vector(to_unsigned(8, A'length)); -- 1000
       	result <= cpl2(A, N); -- CC2 de 0100 => 1011 + 1 => 1000
	wait for 10 ns;


        -- Fin de la simulation
        wait;
    end process;

end Behavioral;
