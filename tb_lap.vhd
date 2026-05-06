library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_lap is
end tb_lap;

architecture Behavioral of tb_lap is

    component lap is
        Port (
            clk     : in  STD_LOGIC;
            rst     : in  STD_LOGIC;
            lap_in  : in  STD_LOGIC_VECTOR(18 downto 0);
            lap_sv  : in  STD_LOGIC;
            lap_sr  : in  STD_LOGIC;
            lap_out : out STD_LOGIC_VECTOR(18 downto 0)
        );
    end component;

    signal clk     : STD_LOGIC := '0';
    signal rst     : STD_LOGIC := '0';
    signal lap_in  : STD_LOGIC_VECTOR(18 downto 0) := (others => '0');
    signal lap_sv  : STD_LOGIC := '0';
    signal lap_sr  : STD_LOGIC := '0';
    signal lap_out : STD_LOGIC_VECTOR(18 downto 0);

    constant clk_period : time := 10 ns;

begin

    uut: lap 
        port map (
            clk     => clk,
            rst     => rst,
            lap_in  => lap_in,
            lap_sv  => lap_sv,
            lap_sr  => lap_sr,
            lap_out => lap_out
        );

    -- Generování hodin
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulační proces
    stim_proc: process
    begin		
        -- Reset paměti na začátku
        rst <= '1';
        wait for 20 ns;	
        rst <= '0';
        wait for 20 ns;

        -- 1. ULOŽENÍ PRVNÍHO ČASU (např. hodnota 50 dekadicky)
        lap_in <= "0000000000000110010"; 
        wait for 10 ns;
        lap_sv <= '1';   -- Pulz pro uložení (Save)
        wait for 10 ns;
        lap_sv <= '0';
        wait for 40 ns;

        -- 2. ULOŽENÍ DRUHÉHO ČASU (např. hodnota 150)
        lap_in <= "0000000000010010110"; 
        wait for 10 ns;
        lap_sv <= '1';   -- Pulz pro uložení (Save)
        wait for 10 ns;
        lap_sv <= '0';
        wait for 40 ns;
        
        -- 3. ULOŽENÍ TŘETÍHO ČASU (např. hodnota 300)
        lap_in <= "0000000000100101100"; 
        wait for 10 ns;
        lap_sv <= '1';   -- Pulz pro uložení (Save)
        wait for 10 ns;
        lap_sv <= '0';
        wait for 40 ns;

        -- Změníme vstup na něco jiného, ať vidíme, že paměť si drží své uložené hodnoty
        lap_in <= "1111111111111111111"; 
        wait for 40 ns;

        -- 4. ČTENÍ / LISTOVÁNÍ V PAMĚTI
        
        -- První stisk listování
        lap_sr <= '1';
        wait for 10 ns;
        lap_sr <= '0';
        wait for 40 ns;

        -- Druhý stisk listování
        lap_sr <= '1';
        wait for 10 ns;
        lap_sr <= '0';
        wait for 40 ns;

        -- Třetí stisk listování
        lap_sr <= '1';
        wait for 10 ns;
        lap_sr <= '0';
        wait for 40 ns;
        
        -- Čtvrtý stisk (ověření rotace - pokud máš paměť jen na např. 3 místa, mělo by se to vrátit na začátek)
        lap_sr <= '1';
        wait for 10 ns;
        lap_sr <= '0';
        wait for 40 ns;

        std.env.stop;
    end process;

end Behavioral;