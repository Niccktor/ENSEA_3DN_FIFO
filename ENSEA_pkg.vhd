library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

package ENSEA_pkg is
    -- Déclaration de l'entité du compteur
    component compteur_decompteur
        Generic ( N : integer := 8 );  -- Taille paramétrable du compteur
        Port (
            clk     : in  STD_LOGIC;  -- Horloge
            rst     : in  STD_LOGIC;  -- Reset asynchrone actif à '1'
            enable  : in  STD_LOGIC;  -- Activation du compteur
            up_down : in  STD_LOGIC;  -- Mode: 1 = compte, 0 = décompte
            count   : out STD_LOGIC_VECTOR (N-1 downto 0)  -- Sortie du compteur
        );
    end component;

end ENSEA_pkg;
