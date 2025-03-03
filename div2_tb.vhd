LIBRARY ieee  ; 
USE ieee.std_logic_1164.all  ; 
ENTITY div2_tb  IS 
END ; 
 
ARCHITECTURE div2_tb_arch OF div2_tb IS
  SIGNAL clk_in   :  STD_LOGIC  ; 
  SIGNAL clk_out   :  STD_LOGIC := '0'; 
  SIGNAL rst   :  STD_LOGIC  ; 
  SIGNAL enable   :  STD_LOGIC := '1'  ; 
  COMPONENT div2  
    PORT ( 
      clk_in  : in STD_LOGIC ; 
      clk_out  : out STD_LOGIC ; 
      rst  : in STD_LOGIC ; 
      enable  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : div2  
    PORT MAP ( 
      clk_in   => clk_in  ,
      clk_out   => clk_out  ,
      rst   => rst  ,
      enable   => enable   ) ; 
PROCESS
BEGIN
  rst <= '0';
  enable <= '1';
  wait;
END process;

PROCESS 
BEGIN
  clk_in <= '0';
  wait for 10ns;
  clk_in <= '1';
  wait for 10ns;
END process;
END ; 

