library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

use work.Types.all;

entity SramController is
port (
        Clk   : in  bit1;
        Rst_N : in  bit1;
        -- Internal interface
        Addr  : in  word(21-1 downto 0);
        D     : in  word(32-1 downto 0);
        We    : in  bit1;
        Q     : out word(32-1 downto 0);
        -- External interface
        flash_sram_a2   : out   bit1;
        flash_sram_a3   : out   bit1;
        flash_sram_a4   : out   bit1;
        flash_sram_a5   : out   bit1;
        flash_sram_a6   : out   bit1;
        flash_sram_a7   : out   bit1;
        flash_sram_a8   : out   bit1;
        flash_sram_a9   : out   bit1;
        flash_sram_a10  : out   bit1;
        flash_sram_a11  : out   bit1;
        flash_sram_a12  : out   bit1;
        flash_sram_a13  : out   bit1;
        flash_sram_a14  : out   bit1;
        flash_sram_a15  : out   bit1;
        flash_sram_a16  : out   bit1;
        flash_sram_a17  : out   bit1;
        flash_sram_a18  : out   bit1;
        flash_sram_a19  : out   bit1;
        flash_sram_a20  : out   bit1;
        flash_sram_a21  : out   bit1;
        flash_sram_a22  : out   bit1;
        --
        flash_sram_dq0  : inout bit1;
        flash_sram_dq1  : inout bit1;
        flash_sram_dq2  : inout bit1;
        flash_sram_dq3  : inout bit1;
        flash_sram_dq4  : inout bit1;
        flash_sram_dq5  : inout bit1;
        flash_sram_dq6  : inout bit1;
        flash_sram_dq7  : inout bit1;
        flash_sram_dq8  : inout bit1;
        flash_sram_dq9  : inout bit1;
        flash_sram_dq10 : inout bit1;
        flash_sram_dq11 : inout bit1;
        flash_sram_dq12 : inout bit1;
        flash_sram_dq13 : inout bit1;
        flash_sram_dq14 : inout bit1;
        flash_sram_dq15 : inout bit1;
        flash_sram_dq16 : inout bit1;
        flash_sram_dq17 : inout bit1;
        flash_sram_dq18 : inout bit1;
        flash_sram_dq19 : inout bit1;
        flash_sram_dq20 : inout bit1;
        flash_sram_dq21 : inout bit1;
        flash_sram_dq22 : inout bit1;
        flash_sram_dq23 : inout bit1;
        flash_sram_dq24 : inout bit1;
        flash_sram_dq25 : inout bit1;
        flash_sram_dq26 : inout bit1;
        flash_sram_dq27 : inout bit1;
        flash_sram_dq28 : inout bit1;
        flash_sram_dq29 : inout bit1;
        flash_sram_dq30 : inout bit1;
        flash_sram_dq31 : inout bit1;
        --
        sram_oe_n       : out   bit1;
        sram_ce1_n      : out   bit1;
        sram_we_n       : out   bit1;
        sram_be_n0      : out   bit1;
        sram_be_n1      : out   bit1;
        sram_be_n2      : out   bit1;
        sram_be_n3      : out   bit1;
        sram_adsc_n     : out   bit1;
        sram_clk        : out   bit1
);
end entity SramController;

architecture rtl of SramController is

begin  -- rtl
  sram_clk <= Clk;
  
  

end rtl;
