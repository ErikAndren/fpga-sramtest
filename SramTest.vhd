library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

use work.Types.all;

entity SramTest is 
port (
	RootClk    : in bit1;
	ARst_N : in bit1;
	--
	Led0   : out bit1;
	Led1   : out bit1;
	Led2   : out bit1;
	Led3   : out bit1
);
end entity SramTest;

architecture rtl of SramTest is
	signal ARst : bit1;
	signal Clk : bit1;
	signal Rst_N : bit1;
	
begin
	RstSync : entity work.ResetSync
		port map (
			Clk      => Clk,
         AsyncRst => ARst_N,
         --
         Rst_N    => Rst_N
		);
        
	ARst <= not ARst_N;
   ClkPll0 : entity work.ClkPll
	Port map (
		inclk0 => RootClk,
      areset => ARst,
      c0     => Clk,
      Locked => open
   );
end architecture;

