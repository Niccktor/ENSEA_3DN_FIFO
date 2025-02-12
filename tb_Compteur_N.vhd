library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_compteur_decompteur is
end tb_compteur_decompteur;

architecture Behavioral of tb_compteur_decompteur is
    constant N : integer := 4;  -- Taille du compteur (modifiable)
    
    -- Signaux de test
    signal clk     : STD_LOGIC := '0';
    signal rst     : STD_LOGIC := '0';
    signal enable  : STD_LOGIC := '0';
    signal up_down : STD_LOGIC := '1';  -- Commence en comptage croissant
    signal count   : STD_LOGIC_VECTOR (N-1 downto 0);

    -- P�riode de l'horloge (10 ns)
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instanciation du compteur
    uut: entity work.compteur_decompteur
        generic map ( N => N )
        port map (
            clk     => clk,
            rst     => rst,
            enable  => enable,
            up_down => up_down,
            count   => count
        );

    -- G�n�ration de l'horloge
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
        -- R�initialisation du compteur
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 10 ns;

        -- Activation du compteur et test en comptage croissant
        enable <= '1';
        up_down <= '1';
        wait for 50 ns;  -- 5 cycles d'horloge

        -- Passage en mode d�compteur
        up_down <= '0';
        wait for 50 ns;  -- 5 cycles d'horloge

        -- D�sactivation du compteur
        enable <= '0';
        wait for 30 ns;

        -- R�initialisation � nouveau
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait;

    end process;

end Behavioral;
