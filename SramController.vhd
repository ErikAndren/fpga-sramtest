library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

use work.Types.all;

entity SramController is
  generic (
    AddrW : positive;
    DataW : positive
    );
  port (
    Clk             : in    bit1;
    Rst_N           : in    bit1;
    -- Internal interface
    Addr            : in    word(AddrW-1 downto 0);
    D               : in    word(DataW-1 downto 0);
    We              : in    bit1;
    Re              : in    bit1;
    Q               : out   word(32-1 downto 0);
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
    sram_oe         : out   bit1;
    sram_ce1_n      : out   bit1;
    sram_we         : out   bit1;
    sram_be_n0      : out   bit1;
    sram_be_n1      : out   bit1;
    sram_be_n2      : out   bit1;
    sram_be_n3      : out   bit1;
    sram_adsc       : out   bit1;
    sram_clk        : out   bit1
    );
end entity SramController;

architecture rtl of SramController is
  signal sram_be_n, sram_be_d             : bit1;
  signal sram_oe_n, sram_oe_d, sram_oe_d2 : bit1;
  signal sram_addr                        : word(AddrW-1 downto 0);
  signal sram_we_n, sram_we_d             : bit1;
  signal sram_dq, sram_dq_d                        : word(DataW-1 downto 0);
begin  -- rtl
  SramClkFeed  : sram_clk  <= Clk;
  SramAddrFeed : sram_addr <= Addr(AddrW-1 downto 0);
  QFeed        : Q         <= sram_dq_d;

  sram_adsc <= '1';
  
  CmdDec : process (We, Re)
  begin
    assert (We and Re) = '0' report "Write enable and read enable are asserted at the same time. This is fatal" severity failure;
    sram_oe_n   <= '1';
    sram_ce1_n  <= '1';
    sram_we_n   <= '1';
    sram_be_n   <= '1';

    if (We = '1') then
      sram_ce1_n  <= '0';
      sram_we_n   <= '0';
      sram_be_n   <= '0';
      sram_oe_n   <= '1';
    end if;

    if (Re = '1') then
      sram_ce1_n <= '0';
      sram_we_n  <= '1';
      sram_oe_n  <= '0';
      sram_be_n  <= '1';
    end if;
  end process;

  CmdFlop : process (Clk, Rst_N)
  begin  -- process CmdFlop
    if Rst_N = '0' then                 -- asynchronous reset (active low)
      sram_we_d   <= '1';
      sram_be_d   <= '1';
      sram_oe_d   <= '1';
      sram_oe_d2  <= '1';
    elsif rising_edge(Clk) then
      sram_we_d   <= sram_we_n;
      sram_be_d   <= sram_be_n;
      sram_oe_d   <= sram_oe_n;
      sram_oe_d2  <= sram_oe_d;

      if sram_oe_d2 = '0' then
        sram_dq_d <= sram_dq;
      else
        sram_dq_d <= D;
      end if;
    end if;
  end process CmdFlop;

  sram_be_n0 <= sram_be_d;
  sram_be_n1 <= sram_be_d;
  sram_be_n2 <= sram_be_d;
  sram_be_n3 <= sram_be_d;

  sram_we   <= sram_we_d;
  sram_oe   <= sram_oe_d;
  
  flash_sram_dq0  <= sram_dq_d(0) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq1  <= sram_dq_d(1) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq2  <= sram_dq_d(2) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq3  <= sram_dq_d(3) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq4  <= sram_dq_d(4) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq5  <= sram_dq_d(5) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq6  <= sram_dq_d(6) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq7  <= sram_dq_d(7) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq8  <= sram_dq_d(8) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq9  <= sram_dq_d(9) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq10 <= sram_dq_d(10) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq11 <= sram_dq_d(11) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq12 <= sram_dq_d(12) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq13 <= sram_dq_d(13) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq14 <= sram_dq_d(14) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq15 <= sram_dq_d(15) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq16 <= sram_dq_d(16) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq17 <= sram_dq_d(17) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq18 <= sram_dq_d(18) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq19 <= sram_dq_d(19) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq20 <= sram_dq_d(20) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq21 <= sram_dq_d(21) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq22 <= sram_dq_d(22) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq23 <= sram_dq_d(23) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq24 <= sram_dq_d(24) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq25 <= sram_dq_d(25) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq26 <= sram_dq_d(26) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq27 <= sram_dq_d(27) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq28 <= sram_dq_d(28) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq29 <= sram_dq_d(29) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq30 <= sram_dq_d(30) when sram_oe_d = '1' else 'Z'; 
  flash_sram_dq31 <= sram_dq_d(31) when sram_oe_d = '1' else 'Z';
  --
  sram_dq <= flash_sram_dq31 &
             flash_sram_dq30 &
             flash_sram_dq29 &
             flash_sram_dq28 &
             flash_sram_dq27 &
             flash_sram_dq26 &
             flash_sram_dq25 &
             flash_sram_dq24 &
             flash_sram_dq23 &
             flash_sram_dq22 &
             flash_sram_dq21 &
             flash_sram_dq20 &
             flash_sram_dq19 &
             flash_sram_dq18 &
             flash_sram_dq17 &
             flash_sram_dq16 &
             flash_sram_dq15 &
             flash_sram_dq14 &
             flash_sram_dq13 &
             flash_sram_dq12 &
             flash_sram_dq11 &
             flash_sram_dq10 &
             flash_sram_dq9 &
             flash_sram_dq8 &
             flash_sram_dq7 &
             flash_sram_dq6 &
             flash_sram_dq5 &
             flash_sram_dq4 &
             flash_sram_dq3 &
             flash_sram_dq2 &
             flash_sram_dq1 &
             flash_sram_dq0;

  flash_sram_a2  <= sram_addr(0);
  flash_sram_a3  <= sram_addr(1);
  flash_sram_a4  <= sram_addr(2);
  flash_sram_a5  <= sram_addr(3);
  flash_sram_a6  <= sram_addr(4);
  flash_sram_a7  <= sram_addr(5);
  flash_sram_a8  <= sram_addr(6);
  flash_sram_a9  <= sram_addr(7);
  flash_sram_a10 <= sram_addr(8);
  flash_sram_a11 <= sram_addr(9);
  flash_sram_a12 <= sram_addr(10);
  flash_sram_a13 <= sram_addr(11);
  flash_sram_a14 <= sram_addr(12);
  flash_sram_a15 <= sram_addr(13);
  flash_sram_a16 <= sram_addr(14);
  flash_sram_a17 <= sram_addr(15);
  flash_sram_a18 <= sram_addr(16);
  flash_sram_a19 <= sram_addr(17);
  flash_sram_a20 <= sram_addr(18);
  
end rtl;
