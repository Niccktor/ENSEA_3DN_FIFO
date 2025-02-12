library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

package ENSEA_pkg is
    -- D�claration de l'entit� du compteur
    component compteur_decompteur
        Generic ( N : integer := 8 );  -- Taille param�trable du compteur
        Port (
            clk     : in  STD_LOGIC;  -- Horloge
            rst     : in  STD_LOGIC;  -- Reset asynchrone actif � '1'
            enable  : in  STD_LOGIC;  -- Activation du compteur
            up_down : in  STD_LOGIC;  -- Mode: 1 = compte, 0 = d�compte
            count   : out STD_LOGIC_VECTOR (N-1 downto 0)  -- Sortie du compteur
        );
    end component;

end ENSEA_pkg;
