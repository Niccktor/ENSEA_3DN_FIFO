LIBRARY ieee  ; 
USE ieee.std_logic_1164.all  ;

ENTITY mux_tb  IS 
END mux_tb; 
 
ARCHITECTURE mux_tb_arch OF mux_tb IS
  SIGNAL sort   :  STD_LOGIC  ; 
  SIGNAL sel   :  STD_LOGIC  ; 
  SIGNAL IN1   :  STD_LOGIC  ; 
  SIGNAL IN2   :  STD_LOGIC  ; 
  
  COMPONENT mux  
    PORT ( 
      sort  : out STD_LOGIC ; 
      sel  : in STD_LOGIC ; 
      IN1  : in STD_LOGIC ; 
      IN2  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : mux  
    PORT MAP ( 
      sort   => sort  ,
      sel   => sel  ,
      IN1   => IN1  ,
      IN2   => IN2   ) ;
PROCESS
BEGIN
  IN1 <= '0'; IN2 <= '0'; sel <= '0'; wait for 20ns;
  IN1 <= '0'; IN2 <= '1'; sel <= '0'; wait for 20ns;
  IN1 <= '1'; IN2 <= '0'; sel <= '1'; wait for 20ns;
  IN1 <= '0'; IN2 <= '1'; sel <= '0'; wait for 20ns;
  IN1 <= '1'; IN2 <= '0'; sel <= '0'; wait for 20ns;
  IN1 <= '0'; IN2 <= '1'; sel <= '1'; wait for 20ns;
    wait;
END process;
END ; 

