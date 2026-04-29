library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_Stopwach_top is
-- Testbench nemá žádné porty
end tb_Stopwach_top;

architecture Behavioral of tb_Stopwach_top is

    -- 1. DEKLARACE TESTOVANÉHO MODULU (Název přesně podle tvého souboru)
    component Stopwach_top is
        Port ( 
            clk  : in  STD_LOGIC;
            btnd : in  STD_LOGIC;
            btnu : in  STD_LOGIC;
            btnc : in  STD_LOGIC;
            btnr : in  STD_LOGIC;
            btnl : in  STD_LOGIC;
            seg  : out STD_LOGIC_VECTOR (6 downto 0);
            dp   : out STD_LOGIC;
            an   : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;

    -- 2. SIMULAČNÍ SIGNÁLY
    signal clk  : STD_LOGIC := '0';
    signal btnd : STD_LOGIC := '0';
    signal btnu : STD_LOGIC := '0';
    signal btnc : STD_LOGIC := '0';
    signal btnr : STD_LOGIC := '0';
    signal btnl : STD_LOGIC := '0';
    
    signal seg  : STD_LOGIC_VECTOR (6 downto 0);
    signal dp   : STD_LOGIC;
    signal an   : STD_LOGIC_VECTOR (7 downto 0);

    constant c_CLK_PER : time := 10 ns;

begin

    -- 3. ZAPOJENÍ TESTOVANÉHO MODULU
    UUT: Stopwach_top
        port map (
            clk  => clk,
            btnd => btnd,
            btnu => btnu,
            btnc => btnc,
            btnr => btnr,
            btnl => btnl,
            seg  => seg,
            dp   => dp,
            an   => an
        );

    -- 4. GENERÁTOR HODIN
    p_clk_gen: process
    begin
        clk <= '0';
        wait for c_CLK_PER / 2;
        clk <= '1';
        wait for c_CLK_PER / 2;
    end process;

    -- 5. HLAVNÍ TESTOVACÍ SCÉNÁŘ
    p_stimulus: process
    begin
        report "Start simulace...";
        
        btnd <= '1';
        wait for 100 ns;
        btnd <= '0';
        wait for 10 ms;

        report "Mackam START...";
        btnu <= '1';
        wait for 20 ms;
        btnu <= '0';

        report "Stopky bezi...";
        wait for 40 ms;

        report "Ukladam mezi cas (LAP)...";
        btnc <= '1';
        wait for 20 ms;
        btnc <= '0';

        wait for 30 ms;

        report "Mackam STOP...";
        btnu <= '1';
        wait for 20 ms;
        btnu <= '0';
        
        report "Drzim VIEW pro zobrazeni LAPu...";
        btnl <= '1';
        wait for 20 ms;
        btnl <= '0';

        report "Konec simulace.";
        wait;
    end process;

end Behavioral;