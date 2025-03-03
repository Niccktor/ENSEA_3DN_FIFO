library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- use work.CHECK_PKG.all;

entity seq is
    Generic ( M : integer := 8 );  -- Taille des adresses
    Port (
	CLK		: in STD_LOGIC;		-- Horloge
	RST		: in STD_LOGIC;		-- Reset Global
	EnRead		: in STD_LOGIC;		-- Enable Read
	EnWrite		: in STD_LOGIC;		-- Enable Write
	req		: in STD_LOGIC;		-- Request Write

	Ack		: out STD_LOGIC;	-- Acknowledge
	RW_n		: out STD_LOGIC;	-- Read / Write enable
	OE		: out STD_LOGIC;	-- 
	IncWrite	: out STD_LOGIC;	-- Enable increment Write
	IncRead		: out STD_LOGIC;	-- Enable increment Read
	HL		: out STD_LOGIC;	-- 
	SelRead		: out STD_LOGIC;	-- 
	CS_n		: out STD_LOGIC		-- Chip enable
    );
end seq;

architecture Behavioral of seq is
	type Etat is (Repos, Lect1, Ecrire, Attente, Lect2);
begin
	process (clk, rst)
	begin
		if ()
	end process;
end Behavioral;