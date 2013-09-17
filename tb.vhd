library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

use work.Types.all;

entity tb is
end entity;

architecture rtl of tb is
  signal Clk   : bit1;
  signal Rst_N : bit1;

  component CY7C1365_FT
    generic (
      addr_bits : natural := 18;
      data_bits : natural := 32;
      mem_sizes : natural := 524288
      );
    port (
      DQ     : inout word(data_bits-1 downto 0);
      ADDR   : in    word(addr_bits-1 downto 0);
      ADV_N  : in    bit1;
      CLK    : in    bit1;
      ADSC_N : in    bit1;
      ASDP_N : in    bit1;
      BWa_N  : in    bit1;
      BWb_N  : in    bit1;
      BWc_N  : in    bit1;
      BWd_N  : in    bit1;
      GW_N   : in    bit1;
      CE1_N  : in    bit1;
      CE2    : in    bit1;
      CE3_N  : in    bit1;
      OE_N   : in    bit1;
      ZZ     : in    bit1
      );
  end component;

  signal sram_addr : word(18-1 downto 0);
  signal sram_dq   : word(32-1 downto 0);

  signal sram_oe_n  : bit1;
  signal sram_ce1_n : bit1;
  signal sram_we    : bit1;
  signal sram_be_n0 : bit1;
  signal sram_be_n1 : bit1;
  signal sram_be_n2 : bit1;
  signal sram_be_n3 : bit1;
  signal sram_adsc  : bit1;
  signal sram_clk   : bit1;

begin
  ClkProc : process
  begin
    while true loop
      Clk <= '0';
      wait for 20 ns;
      Clk <= '1';
      wait for 20 ns;
    end loop;
  end process;

  RstProc : Process
  begin
    Rst_N <= '0';
    wait for 300 ns;
    Rst_N <= '1';
    wait;
  end Process;

  sram_dq <= (others => 'Z');
  
  DUT : entity work.SramTest
    port map (
      RootClk         => Clk,
      ARst_N          => Rst_N,
      --
      flash_sram_a2   => sram_addr(0),
      flash_sram_a3   => sram_addr(1),
      flash_sram_a4   => sram_addr(2),
      flash_sram_a5   => sram_addr(3),
      flash_sram_a6   => sram_addr(4),
      flash_sram_a7   => sram_addr(5),
      flash_sram_a8   => sram_addr(6),
      flash_sram_a9   => sram_addr(7),
      flash_sram_a10  => sram_addr(8),
      flash_sram_a11  => sram_addr(9),
      flash_sram_a12  => sram_addr(10),
      flash_sram_a13  => sram_addr(11),
      flash_sram_a14  => sram_addr(12),
      flash_sram_a15  => sram_addr(13),
      flash_sram_a16  => sram_addr(14),
      flash_sram_a17  => sram_addr(15),
      flash_sram_a18  => sram_addr(16),
      flash_sram_a19  => sram_addr(17),
      flash_sram_a20  => open,
      --
      flash_sram_dq0  => sram_dq(0), 
      flash_sram_dq1  => sram_dq(1), 
      flash_sram_dq2  => sram_dq(2), 
      flash_sram_dq3  => sram_dq(3), 
      flash_sram_dq4  => sram_dq(4), 
      flash_sram_dq5  => sram_dq(5), 
      flash_sram_dq6  => sram_dq(6), 
      flash_sram_dq7  => sram_dq(7), 
      flash_sram_dq8  => sram_dq(8), 
      flash_sram_dq9  => sram_dq(9), 
      flash_sram_dq10 => sram_dq(10), 
      flash_sram_dq11 => sram_dq(11), 
      flash_sram_dq12 => sram_dq(12), 
      flash_sram_dq13 => sram_dq(13), 
      flash_sram_dq14 => sram_dq(14), 
      flash_sram_dq15 => sram_dq(15), 
      flash_sram_dq16 => sram_dq(16), 
      flash_sram_dq17 => sram_dq(17), 
      flash_sram_dq18 => sram_dq(18), 
      flash_sram_dq19 => sram_dq(19), 
      flash_sram_dq20 => sram_dq(20), 
      flash_sram_dq21 => sram_dq(21), 
      flash_sram_dq22 => sram_dq(22), 
      flash_sram_dq23 => sram_dq(23), 
      flash_sram_dq24 => sram_dq(24), 
      flash_sram_dq25 => sram_dq(25), 
      flash_sram_dq26 => sram_dq(26), 
      flash_sram_dq27 => sram_dq(27), 
      flash_sram_dq28 => sram_dq(28), 
      flash_sram_dq29 => sram_dq(29), 
      flash_sram_dq30 => sram_dq(30), 
      flash_sram_dq31 => sram_dq(31), 
      --
      sram_oe_n       => sram_oe_n,
      sram_ce1_n      => sram_ce1_n,
      sram_we         => sram_we,
      sram_be_n0      => sram_be_n0,
      sram_be_n1      => sram_be_n1,
      sram_be_n2      => sram_be_n2,
      sram_be_n3      => sram_be_n3,
      sram_adsc       => sram_adsc,
      sram_clk        => sram_clk,
      --
      --
      Btn0            => '1',
      Btn1            => '1',
      Btn2            => '1',
      Btn3            => '1',
      --
      Led0            => open,
      Led1            => open,
      Led2            => open,
      Led3            => open
      );

    Sram : CY7C1365_FT
      generic map (
        addr_bits => 18,
        data_bits => 32,
        mem_sizes => 524288
        )
      port map (
        DQ     => sram_dq,
        ADDR   => sram_addr(18-1 downto 0),
        ADV_N  => '1',
        CLK    => sram_clk,
        ADSC_N => sram_adsc,
        ASDP_N => '1',
        BWa_N  => sram_be_n0,
        BWb_N  => sram_be_n1,
        BWc_N  => sram_be_n2,
        BWd_N  => sram_be_n3,
        GW_N   => '1',
        CE1_N  => sram_ce1_n,
        CE2    => '1',
        CE3_N  => '0',
        OE_N   => sram_oe_n,
        ZZ     => '0'        
        );
end architecture;
