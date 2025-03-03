LIBRARY ieee  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
ENTITY ram_2pmxnbits_tb  IS 
  GENERIC (
    G_DATA_SIZE  : NATURAL   := 7 ;  
    G_ADDR_SIZE  : NATURAL   := 3 ); 
END ; 
 
ARCHITECTURE ram_2pmxnbits_tb_arch OF ram_2pmxnbits_tb IS
  SIGNAL clk_in_tb   :  STD_LOGIC  ; 
  SIGNAL CSB_tb   :  STD_LOGIC  ; 
  SIGNAL data_in_tb   :  std_logic_vector (G_DATA_SIZE downto 0)  ; 
  SIGNAL data_out_tb   :  std_logic_vector (G_DATA_SIZE downto 0)  ; 
  SIGNAL RWB_tb   :  STD_LOGIC  ; 
  SIGNAL addr_tb   :  std_logic_vector (G_ADDR_SIZE downto 0)  ; 
  COMPONENT RAM_2pMxNbits is
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
  end COMPONENT;
BEGIN
  dut : RAM_2pMxNbits 
  generic map(
    G_DATA_SIZE => G_DATA_SIZE,
    G_ADDR_SIZE => G_ADDR_SIZE
  )
  port map(
    data_in =>  data_in_tb,
    addr    =>  addr_tb,
    RWB     =>  RWB_tb,
    CSB     =>  CSB_tb,
    data_out  => data_out_tb
  );
process
begin
      CSB_tb <= '1';               --  disable
      RWB_tb <= '0';               --  Write
      addr_tb <= (others => '0');  --  addr = 0x0
      data_in_tb <= "11110000";    --  data = 0xF0
      CSB_tb <= '0';               --  enable
      wait for 10ns;
      
      CSB_tb <= '1';               --  disable
      RWB_tb <= '0';               --  Write
      addr_tb <= (others => '1');  --  addr = 0xF
      data_in_tb <= "00001111";    --  data = 0x0F
      CSB_tb <= '0';               --  enable
      wait for 10ns;
      
      CSB_tb <= '1';               --  disable
      RWB_tb <= '0';               --  Write
      addr_tb <= "0101";           --  addr = 0x5
      data_in_tb <= "10101010";    --  data = 0xAA
      CSB_tb <= '0';               --  enable
      wait for 10ns;
      
      CSB_tb <= '1';               --  disable
      RWB_tb <= '1';               --  Read
      addr_tb <= (others => '1');  --  addr = 0xF
      CSB_tb <= '0';               --  enable
      wait for 10ns;
      
      CSB_tb <= '1';               --  disable
      RWB_tb <= '1';               --  Read
      addr_tb <= (others => '0');  --  addr = 0x0
      CSB_tb <= '0';               --  enable
      wait for 10ns;
      
      CSB_tb <= '1';               --  disable
      RWB_tb <= '1';               --  Read
      addr_tb <= "0101";           --  addr = 0x5
      CSB_tb <= '0';               --  enable
      wait for 10ns;
      wait;
    end process;
process
BEGIN
  clk_in_tb <= '0';
  wait for 10ns;
  clk_in_tb <= '1';
  wait for 10ns;
END process;
END ; 

