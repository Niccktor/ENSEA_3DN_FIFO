library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.ENSEA_pkg.all;  -- Importation du package contenant le compteur

entity FastSlow is
    Generic ( M : integer := 4 );  -- Taille du compteur (pour FIFO de 2^M mots)
    Port (
        clk      : in  STD_LOGIC;  -- Horloge
        rst      : in  STD_LOGIC;  -- Reset global
        incwrite : in  STD_LOGIC;  -- Incrémentation (écriture dans la FIFO)
        incread  : in  STD_LOGIC;  -- Décrémentation (lecture de la FIFO)
        fast     : out STD_LOGIC;  -- Signal de vitesse rapide
        slow     : out STD_LOGIC   -- Signal de vitesse lente
    );
end FastSlow;

architecture Behavioral of FastSlow is
    -- Signal pour le compteur du nombre de données dans la FIFO
    signal fifo_count : STD_LOGIC_VECTOR (M-1 downto 0);
    signal enable_tb : STD_LOGIC;

begin
    -- Instanciation du compteur-décompteur
    compteur_inst : compteur_decompteur
        generic map ( N => M )
        port map (
            clk     => clk,
            rst     => rst,
            enable  => enable_tb,   -- Active si lecture ou écriture
            up_down => incwrite,  -- Incrémente si incwrite=1, décrémente sinon
            count   => fifo_count
        );

    -- Logique combinatoire pour générer les signaux fast et slow

    process (fifo_count)
    begin

        if fifo_count < CONV_STD_LOGIC_VECTOR(2**M - 2, M) then
            fast <= '1';
        else
            fast <= '0';
        end if;

        if fifo_count >= CONV_STD_LOGIC_VECTOR(2**M - 2**(M-2), M) then
            slow <= '1';
        else
            slow <= '0';
        end if;
    end process;
    enable_tb <= incwrite or incread;
end Behavioral;

