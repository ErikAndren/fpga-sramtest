library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

use work.Types.all;

entity SramTest is
port (
        RootClk         : in    bit1;
        ARst_N          : in    bit1;
        --
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
        sram_oe_n       : out   bit1;
        sram_ce1_n      : out   bit1;
        sram_we         : out   bit1;
        sram_be_n0      : out   bit1;
        sram_be_n1      : out   bit1;
        sram_be_n2      : out   bit1;
        sram_be_n3      : out   bit1;
        sram_adsc       : out   bit1;
        sram_clk        : out   bit1;
        --
        --
        Btn0            : in    bit1;
        Btn1            : in    bit1;
        Btn2            : in    bit1;
        Btn3            : in    bit1;
        --
        Led0            : out   bit1;
        Led1            : out   bit1;
        Led2            : out   bit1;
        Led3            : out   bit1
);
end entity SramTest;

architecture rtl of SramTest is
  constant AddrW       : positive := 19;
  constant DataW       : positive := 32;
  --
  signal   ARst        : bit1;
  signal   Clk         : bit1;
  signal   Rst_N       : bit1;
  --
  signal   SramAddr    : word(AddrW-1 downto 0);
  signal   SramDataOut : word(DataW-1 downto 0);
  signal   SramWe      : bit1;
  signal   SramRe      : bit1;
  signal   SramDataIn  : word(DataW-1 downto 0);
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
      c0     => Clk
      );

  StimGen : entity work.SramTestGen
    generic map (
      AddrW => AddrW,
      DataW => DataW
      )
    port map (
      Clk   => Clk,
      Rst_N => Rst_N,
      --
      We    => SramWe,
      Re    => SramRe,
      Addr  => SramAddr,
      Data  => SramDataOut
      );
		
  -- Leds are active low
  Led0 <= SramDataIn(0);
  Led1 <= SramDataIn(1);
  Led2 <= SramDataIn(2);
  Led3 <= SramDataIn(3);
  
  SramControl : entity work.SramController
    generic map (
      AddrW => AddrW,
      DataW => DataW
      )
    port map (
      Clk             => Clk,
      Rst_N           => Rst_N,
      -- Internal interface
      Addr            => SramAddr,
      D               => SramDataOut,
      We              => SramWe,
      Re              => SramRe,
      Q               => SramDataIn,
      -- External interface
      flash_sram_a2   => flash_sram_a2,
      flash_sram_a3   => flash_sram_a3,
      flash_sram_a4   => flash_sram_a4,
      flash_sram_a5   => flash_sram_a5,
      flash_sram_a6   => flash_sram_a6,
      flash_sram_a7   => flash_sram_a7,
      flash_sram_a8   => flash_sram_a8,
      flash_sram_a9   => flash_sram_a9,
      flash_sram_a10  => flash_sram_a10,
      flash_sram_a11  => flash_sram_a11,
      flash_sram_a12  => flash_sram_a12,
      flash_sram_a13  => flash_sram_a13,
      flash_sram_a14  => flash_sram_a14,
      flash_sram_a15  => flash_sram_a15,
      flash_sram_a16  => flash_sram_a16,
      flash_sram_a17  => flash_sram_a17,
      flash_sram_a18  => flash_sram_a18,
      flash_sram_a19  => flash_sram_a19,
      flash_sram_a20  => flash_sram_a20,
      --
      flash_sram_dq0  => flash_sram_dq0,
      flash_sram_dq1  => flash_sram_dq1,
      flash_sram_dq2  => flash_sram_dq2,
      flash_sram_dq3  => flash_sram_dq3,
      flash_sram_dq4  => flash_sram_dq4,
      flash_sram_dq5  => flash_sram_dq5,
      flash_sram_dq6  => flash_sram_dq6,
      flash_sram_dq7  => flash_sram_dq7,
      flash_sram_dq8  => flash_sram_dq8,
      flash_sram_dq9  => flash_sram_dq9,
      flash_sram_dq10 => flash_sram_dq10,
      flash_sram_dq11 => flash_sram_dq11,
      flash_sram_dq12 => flash_sram_dq12,
      flash_sram_dq13 => flash_sram_dq13,
      flash_sram_dq14 => flash_sram_dq14,
      flash_sram_dq15 => flash_sram_dq15,
      flash_sram_dq16 => flash_sram_dq16,
      flash_sram_dq17 => flash_sram_dq17,
      flash_sram_dq18 => flash_sram_dq18,
      flash_sram_dq19 => flash_sram_dq19,
      flash_sram_dq20 => flash_sram_dq20,
      flash_sram_dq21 => flash_sram_dq21,
      flash_sram_dq22 => flash_sram_dq22,
      flash_sram_dq23 => flash_sram_dq23,
      flash_sram_dq24 => flash_sram_dq24,
      flash_sram_dq25 => flash_sram_dq25,
      flash_sram_dq26 => flash_sram_dq26,
      flash_sram_dq27 => flash_sram_dq27,
      flash_sram_dq28 => flash_sram_dq28,
      flash_sram_dq29 => flash_sram_dq29,
      flash_sram_dq30 => flash_sram_dq30,
      flash_sram_dq31 => flash_sram_dq31,
      --
      sram_oe         => sram_oe_n,
      sram_ce1_n      => sram_ce1_n,
      sram_we         => sram_we,
      sram_be_n0      => sram_be_n0,
      sram_be_n1      => sram_be_n1,
      sram_be_n2      => sram_be_n2,
      sram_be_n3      => sram_be_n3,
      sram_adsc       => sram_adsc,
      sram_clk        => sram_clk
      );
end architecture;

