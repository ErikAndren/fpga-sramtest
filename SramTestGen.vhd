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
	 Btn0  : in  bit1;
	 Btn1  : in  bit1;
	 Btn2  : in  bit1;
	 Btn3  : in  bit1;
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
  signal   Data_D, Data_N         : word(4-1 downto 0);
  signal   Addr_D, Addr_N         : word(2-1 downto 0);
  signal   Btn_D                  : word(4-1 downto 0);
  signal   StrobeCnt_D, StrobeCnt_N : word(bits(StartCnt)-1 downto 0);
begin  -- rtl
  StimSync : process (Clk, Rst_N)
  begin  -- process Stim
    if Rst_N = '0' then                 -- asynchronous reset (active low)
      StartCnt_D <= conv_word(StartCnt, StartCnt_D'length);
		Data_D     <= (others => '0');
		Addr_D     <= (others => '0');
		Btn_D      <= (others => '1');
		StrobeCnt_D <= conv_word(StartCnt, StrobeCnt_D'length);
    elsif Clk'event and Clk = '1' then  -- rising clock edge
      StartCnt_D <= StartCnt_N;
		Data_D     <= Data_N;
		Addr_D     <= Addr_N;
		Btn_D      <= Btn3 & Btn2 & Btn1 & Btn0;
		StrobeCnt_D <= StrobeCnt_N;
    end if;
  end process StimSync;
  
  StimAsync : process (StartCnt_D, Data_D, Addr_D, StrobeCnt_D, Btn0, Btn1)
  begin
    StartCnt_N <= StartCnt_D;
	 StrobeCnt_N <= StrobeCnt_D - 1;
    --
    We         <= '0';
    Re         <= '0';
    Addr       <= (others => '0');
    Data       <= (others => '0');
	 Data_N     <= Data_D;
	 Addr_N     <= Addr_D;

    if StartCnt_D > 0 then
      StartCnt_N <= StartCnt_D - 1;
    end if;

    -- Perform write
    if StartCnt_D = 12 then
      We     <= '1';
      Addr   <= (others => '0');
      Data   <= xt0("1111", Data'length);
    end if;

	if StartCnt_D = 10 then
      We     <= '1';
      Addr   <= conv_word(1, Addr'length);
      Data   <= xt0("1110", Data'length);
    end if;

	if StartCnt_D = 8 then
      We     <= '1';
      Addr   <= conv_word(2, Addr'length);
      Data   <= xt0("1100", Data'length);
    end if;
	 
	 if StartCnt_D = 6 then
      We     <= '1';
      Addr   <= conv_word(3, Addr'length);
      Data   <= xt0("1000", Data'length);
    end if;
	 
    -- Perform first read
    if StartCnt_D = 1 then
      Re   <= '1';
      Addr <= (others => '0');
   end if;	
	
	if (StrobeCnt_D = 0) then
		if (Btn0 = '0') then
		Addr_N <= Addr_D + 1;
		Re     <= '1';
		Addr   <= xt0(Addr_D + 1, Addr'length);
	 end if;

	 if (Btn1 = '0') then
		Addr_N <= Addr_D - 1;
		Re     <= '1';	
		Addr   <= xt0(Addr_D - 1, Addr'length); 
	 end if;	 
	end if;

  end process;
end rtl;
