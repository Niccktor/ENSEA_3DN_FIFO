--mux.vhd
library ieee;
use ieee.std_logic_1164.all;

entity mux is
  port(IN1, IN2,sel : in std_logic;
    sort : out std_logic);
  end mux;
  
architecture mux of mux is
begin
  sort <= IN1 after 2ns when  sel = '0' else IN2 after 2ns;
end mux;