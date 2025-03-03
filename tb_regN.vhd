library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use WORK.CHECK_PKG.ALL;  -- Inclure le package CHECK_PKG

entity tb_regN is
end tb_regN;

architecture behavior of tb_regN is

    -- D�clarations de signaux pour tester regN
    signal clk     : std_logic := '0';
    signal D     : std_logic_vector(7 downto 0) := (others => '0');
    signal N    : std_logic_vector(7 downto 0);
    signal rst   : std_logic := '0';

    -- D�claration des param�tres de setup et hold
    constant T_SETUP : time := 5 ns;
    constant T_HOLD  : time := 5 ns;

begin
    UUT: entity work.regN
        port map (
            clk => clk,
            D => D,
            N => N,
            rst => rst
        );

    -- G�n�ration de l'horloge
    clk_process : process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;

    -- Simulation de l'entr�e et du reset
    stimulus_process : process
    begin
        -- Initialisation
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        
        -- Test de setup et hold avec diff�rents inputs
        -- Exemple de valeur pour `D`
        D <= "10101010"; -- valeur d'entr�e
        -- V�rifier les temps de setup et hold
        -- Temps de setup

        -- Test avec un autre signal d'entr�e
        D <= "11001100"; -- nouvelle valeur d'entr�e



        -- Fin de simulation
        wait;
	check_setup(clk, D, T_SETUP, warning, 20 ns, 50 ns);
        check_hold(clk, D, T_HOLD, warning, 20 ns, 50 ns);
	check_setup(clk, N, T_SETUP, warning, 20 ns, 50 ns);
        check_hold(clk, N, T_HOLD, warning, 20 ns, 50 ns);
    end process;
end behavior;
