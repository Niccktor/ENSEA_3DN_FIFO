library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- use work.CHECK_PKG.all;

entity regN is
    Generic ( M : integer := 8 );  -- Taille des adresses
    Port (
        clk      : in  STD_LOGIC;  -- Horloge
        rst      : in  STD_LOGIC;  -- Reset global
	D     : in STD_LOGIC_VECTOR (M-1 downto 0);
        N     : out STD_LOGIC_VECTOR (M-1 downto 0)
    );
end regN;

architecture Behavioral of regN is

begin
	process (clk, rst)
	begin
       	if rising_edge(clk) then
       		if rst = '1' then
              		N <= (others => '0');
                else
                    N <= D;
                end if;
        end if;
	end process;
end Behavioral;