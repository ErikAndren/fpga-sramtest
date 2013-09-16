library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.Types.all;

entity SramTestGen is
  generic (
    AddrW : positive;
    DataW : positive);
  port (
    Clk   : in  bit1;
    Rst_N : in  bit1;
    --
    We    : out bit1;
    Re    : out bit1;
    Addr  : out word(AddrW-1 downto 0);
    Data  : out word(DataW-1 downto 0)
    );
end entity SramTestGen;

architecture rtl of SramTestGen is
  constant StartCnt               : positive := 25000000;
  signal   StartCnt_D, StartCnt_N : word(bits(StartCnt)-1 downto 0);
  
begin  -- rtl
  StimSync : process (Clk, Rst_N)
  begin  -- process Stim
    if Rst_N = '0' then                 -- asynchronous reset (active low)
      StartCnt_D <= conv_word(StartCnt, StartCnt_D'length);
    elsif Clk'event and Clk = '1' then  -- rising clock edge
      StartCnt_D <= StartCnt_N;
    end if;
  end process StimSync;
  
  StimAsync : process (StartCnt_D)
  begin
    StartCnt_N <= StartCnt_D;
    --
    We         <= '0';
    Re         <= '0';
    Addr       <= (others => '0');
    Data       <= (others => '0');

    if StartCnt_D > 0 then
      StartCnt_N <= StartCnt_D - 1;
    end if;

    -- Perform write
    if StartCnt_D = 10 then
      We   <= '1';
      Addr <= conv_word(0, Addr'length);
      Data <= conv_word(2, Data'length);
    end if;

    -- Perform read
    if StartCnt_D = 1 then
      Re   <= '1';
      Addr <= conv_word(0, Addr'length);
    end if;
  end process;
end rtl;
