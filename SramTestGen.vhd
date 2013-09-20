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
  constant StartCnt               : positive := 50000000;
  signal   StartCnt_D, StartCnt_N : word(bits(StartCnt)-1 downto 0);
  signal   Data_D, Data_N         : word(4-1 downto 0);
begin  -- rtl
  StimSync : process (Clk, Rst_N)
  begin  -- process Stim
    if Rst_N = '0' then                 -- asynchronous reset (active low)
      StartCnt_D <= conv_word(StartCnt, StartCnt_D'length);
		Data_D     <= (others => '0');
    elsif Clk'event and Clk = '1' then  -- rising clock edge
      StartCnt_D <= StartCnt_N;
		Data_D     <= Data_N;
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
	 Data_N     <= Data_D;

    if StartCnt_D > 0 then
      StartCnt_N <= StartCnt_D - 1;
    end if;

    -- Perform write
    if StartCnt_D = 25000000 then
      We     <= '1';
      Addr   <= xt0(Data_D, Addr'length);
      Data   <= xt0(Data_D, Data'length);

    end if;

    -- Perform read
    if StartCnt_D = 1 then
      Re   <= '1';
      Addr <= xt0(Data_D, Addr'length);
		StartCnt_N <= conv_word(StartCnt, StartCnt_N'length);
		Data_N <= Data_D + 1;
    end if;
  end process;
end rtl;
