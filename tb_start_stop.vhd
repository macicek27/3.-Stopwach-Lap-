library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_Start_Stop is
-- Testbench nemá porty
end tb_Start_Stop;

architecture Behavioral of tb_Start_Stop is

    -- 1. Deklarace tvé testované komponenty
    component Start_Stop is
        Port (
            clk    : in  STD_LOGIC;
            rst    : in  STD_LOGIC;
            btn_in : in  STD_LOGIC;
            ce     : in  STD_LOGIC;
            en     : out STD_LOGIC
        );
    end component;

    -- 2. Vnitřní signály testbenche
    signal clk    : STD_LOGIC := '0';
    signal rst    : STD_LOGIC := '0';
    signal btn_in : STD_LOGIC := '0';
    signal ce     : STD_LOGIC := '0';
    signal en     : STD_LOGIC;

    constant clk_period : time := 10 ns;

begin

    -- 3. Propojení testované komponenty (UUT)
    uut: Start_Stop 
        port map (
            clk    => clk,
            rst    => rst,
            btn_in => btn_in,
            ce     => ce,
            en     => en
        );

    -- 4. Generátor 100 MHz hodin
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- 5. Generátor povolovacích pulzů CE (např. každých 50 ns)
    ce_process: process
    begin
        ce <= '0';
        wait for 40 ns;
        ce <= '1';
        wait for 10 ns;
    end process;

    -- 6. Hlavní stimulační proces (mačkání tlačítka)
    stim_proc: process
    begin
        -- Počáteční Reset
        rst <= '1';
        wait for 25 ns;
        rst <= '0';
        wait for 20 ns;

        -- 1. STISK TLAČÍTKA (START)
        -- Počkáme na sestupnou hranu, ať se pulz krásně trefí do jednoho taktu
        wait until falling_edge(clk); 
        btn_in <= '1';
        wait for clk_period; -- Tlačítko stisknuto přesně 1 takt (jako z debounce)
        btn_in <= '0';
        
        -- Necháme "stopky" chvíli běžet (měli bychom vidět pulzující výstup 'en')
        wait for 150 ns;

        -- 2. STISK TLAČÍTKA (STOP)
        wait until falling_edge(clk);
        btn_in <= '1';
        wait for clk_period;
        btn_in <= '0';

        -- Necháme chvíli v klidu (výstup 'en' by měl být trvale 0)
        wait for 100 ns;

        -- Zastavení simulace
        std.env.stop;
    end process;

end Behavioral;