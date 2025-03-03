--div2.vhdl
library ieee;
use ieee.std_logic_1164.all;

entity div2 is
  port(
  rst     : in STD_LOGIC; 
  enable  : in STD_LOGIC;
  clk_in  : in STD_LOGIC;
  clk_out   : out STD_LOGIC
  );
  end div2;
  
architecture div2 of div2 is
  
signal clk_s : STD_LOGIC := '0';

begin
  process (clk_in, rst)
  begin
    if enable = '1' then
      if rst = '1' then
        clk_s <= '0';
      elsif clk_in'event and clk_in = '1' then
        clk_s <= not clk_s;
      end if;
  end if;
  end process;
  clk_out <= clk_s;
end architecture;
