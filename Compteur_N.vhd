library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity compteur_decompteur is
    Generic ( N : integer := 8 );  -- Taille du compteur
    Port (
        clk     : in  STD_LOGIC;  -- Horloge
        rst     : in  STD_LOGIC;  -- Reset asynchrone actif à '1'
        enable  : in  STD_LOGIC;  -- Activation du compteur
        up_down : in  STD_LOGIC;  -- Mode: 1 = compte, 0 = décompte
        count   : out STD_LOGIC_VECTOR (N-1 downto 0)  -- Sortie du compteur
    );
end compteur_decompteur;

architecture Behavioral of compteur_decompteur is
    signal count_reg : STD_LOGIC_VECTOR (N-1 downto 0) := (others => '0');
begin
    process (clk, rst)
    begin
       if rising_edge(clk) then
            if rst = '1' then
               count_reg <= (others => '0');  -- Réinitialisation
            elsif enable = '1' then
                if up_down = '1' then
                    count_reg <= count_reg + 1;  -- Incrémentation
                else
                    count_reg <= count_reg - 1;  -- Décrémentation
                end if;
            end if;
        end if;
    end process;
    
    count <= count_reg;
end Behavioral;

