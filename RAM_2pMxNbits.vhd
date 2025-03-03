-- RAM_2pMxNbits.vhd
library IEEE;
USE IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;


entity RAM_2pMxNbits is
  generic(
    G_DATA_SIZE : natural := 8;
    G_ADDR_SIZE : natural := 4
  );
  port (
    data_in : in  std_logic_vector(G_DATA_SIZE downto 0);
    addr    : in  std_logic_vector(G_ADDR_SIZE downto 0);
    RWB     : in  std_logic;
    CSB     : in  std_logic;
    data_out  : out std_logic_vector(G_DATA_SIZE downto 0)
  );
end RAM_2pMxNbits;

architecture RAM_2pMxNbits of RAM_2pMxNbits is 
type memo is array (G_ADDR_SIZE downto 0) of std_logic_vector(G_DATA_SIZE downto 0);
signal donnee : memo;
begin
  process (CSB, RWB, data_in, addr)
    begin
      if CSB = '0' then
        if RWB = '1' then   -- Mode lecture
          data_out <= donnee(to_integer(unsigned(addr)));
      elsif RWB = '0' then  -- Mode ecriture
        donnee(to_integer(unsigned(addr))) <= data_in;
        data_out <= (others => 'Z');
      end if;
    else
      data_out <= (others => 'Z');
    end if;
  end process;
end RAM_2pMxNbits;

