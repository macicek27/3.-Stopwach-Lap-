library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_view is
-- Testbench nemá porty
end tb_view;

architecture Behavioral of tb_view is

    -- Deklarace testované komponenty
    component view is
        port (
            clk      : in  std_logic;
            rst      : in  std_logic;
            time_d   : in  std_logic_vector(18 downto 0);
            lap_d    : in  std_logic_vector(18 downto 0);
            view_in  : in  std_logic;
            view_out : out std_logic_vector(18 downto 0)
        );
    end component;

    -- Vnitřní signály
    signal clk      : std_logic := '0';
    signal rst      : std_logic := '0';
    signal time_d   : std_logic_vector(18 downto 0) := (others => '0');
    signal lap_d    : std_logic_vector(18 downto 0) := (others => '0');
    signal view_in  : std_logic := '0';
    signal view_out : std_logic_vector(18 downto 0);

    constant clk_period : time := 10 ns;

begin

    -- Propojení
    uut: view
        port map (
            clk      => clk,
            rst      => rst,
            time_d   => time_d,
            lap_d    => lap_d,
            view_in  => view_in,
            view_out => view_out
        );

    -- Generátor hodin
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Simulace běžícího času (time_d se neustále mění)
    time_process :process
    begin
        time_d <= "0000000000000001010"; -- hodnota 10
        wait for 50 ns;
        time_d <= "0000000000000010100"; -- hodnota 20
        wait for 50 ns;
        time_d <= "0000000000000011110"; -- hodnota 30
        wait for 50 ns;
        time_d <= "0000000000000101000"; -- hodnota 40
        wait for 50 ns;
    end process;

    -- Hlavní stimulační proces (přepínání zobrazení)
    stim_proc: process
    begin
        -- Nastavení nějaké "uložené" hodnoty z paměti
        lap_d <= "0000000001111101000"; -- Statická hodnota (např. 1000)

        -- Reset modulu
        rst <= '1';
        wait for 25 ns;
        rst <= '0';
        
        -- Necháme chvíli běžet ve výchozím stavu (měl by propouštět time_d)
        wait for 80 ns;

        -- 1. STISK TLAČÍTKA (Přepnutí na zobrazení paměti - lap_d)
        wait until falling_edge(clk);
        view_in <= '1';
        wait for clk_period;
        view_in <= '0';

        -- Necháme chvíli zobrazenou paměť
        wait for 100 ns;

        -- Změníme hodnotu lap_d (simulace listování pravým tlačítkem v paměti)
        lap_d <= "0000000011111010000"; -- (např. 2000)
        wait for 70 ns;

        -- 2. STISK TLAČÍTKA (Přepnutí zpět na běžící čas - time_d)
        wait until falling_edge(clk);
        view_in <= '1';
        wait for clk_period;
        view_in <= '0';

        -- Necháme dokreslit graf
        wait for 100 ns;

        std.env.stop;
    end process;

end Behavioral;