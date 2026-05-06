library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_display_driver is
-- Testbench nemá porty
end tb_display_driver;

architecture Behavioral of tb_display_driver is

    -- Deklarace testované komponenty
    component display_driver is
        port (
            clk      : in  std_logic;
            rst      : in  std_logic;
            data     : in  std_logic_vector(23 downto 0);
            seg      : out std_logic_vector(6 downto 0);
            an       : out std_logic_vector(5 downto 0)
        );
    end component;

    -- Vnitřní signály
    signal clk  : std_logic := '0';
    signal rst  : std_logic := '0';
    signal data : std_logic_vector(23 downto 0) := (others => '0');
    signal seg  : std_logic_vector(6 downto 0);
    signal an   : std_logic_vector(5 downto 0);

    -- 100 MHz hodiny
    constant clk_period : time := 10 ns;

begin

    -- Propojení
    uut: display_driver
        port map (
            clk  => clk,
            rst  => rst,
            data => data,
            seg  => seg,
            an   => an
        );

    -- Generátor hodin
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Hlavní stimulační proces
    stim_proc: process
    begin
        -- Startovní Reset
        rst <= '1';
        wait for 100 ns;
        rst <= '0';

        -- TEST 1: Pošleme na displej hodnotu "123456" (např. 12 minut, 34 sekund, 56 setin)
        data <= x"123456";
        
        -- Čekáme 8 milisekund! (Abychom viděli celý cyklus pro všech 6 anód, 
        -- protože každá anoda svítí 1 ms)
        wait for 8 ms;

        -- TEST 2: Změníme data na "987650"
        data <= x"987650";
        
        -- Čekáme dalších 8 milisekund
        wait for 8 ms;

        std.env.stop;
    end process;

end Behavioral;