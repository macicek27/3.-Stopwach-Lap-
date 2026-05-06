library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_time_dec is
-- Testbench nemá porty
end tb_time_dec;

architecture Behavioral of tb_time_dec is

    -- Deklarace testované komponenty
    component time_dec is
        port (
            time_in  : in  std_logic_vector(18 downto 0);
            time_out : out std_logic_vector(23 downto 0)
        );
    end component;

    -- Vnitřní signály
    signal time_in  : std_logic_vector(18 downto 0) := (others => '0');
    signal time_out : std_logic_vector(23 downto 0);

begin

    -- Propojení
    uut: time_dec
        port map (
            time_in  => time_in,
            time_out => time_out
        );

    -- Hlavní stimulační proces (zkoušení hodnot)
    stim_proc: process
    begin
        -- Test 1: Čas nula (00:00.00)
        time_in <= std_logic_vector(to_unsigned(0, 19));
        wait for 20 ns;

        -- Test 2: Těsně před vteřinou - 99 setin (00:00.99)
        time_in <= std_logic_vector(to_unsigned(99, 19));
        wait for 20 ns;

        -- Test 3: Přesně 1 vteřina - 100 setin (00:01.00)
        time_in <= std_logic_vector(to_unsigned(100, 19));
        wait for 20 ns;

        -- Test 4: Těsně před minutou - 59.99 vteřin (00:59.99)
        time_in <= std_logic_vector(to_unsigned(5999, 19));
        wait for 20 ns;

        -- Test 5: Přesně 1 minuta - 6000 setin (01:00.00)
        time_in <= std_logic_vector(to_unsigned(6000, 19));
        wait for 20 ns;

        -- Test 6: Náhodný čas -> 12 minut, 34 sekund, 56 setin
        -- Výpočet: 12*6000 + 34*100 + 56 = 75456
        time_in <= std_logic_vector(to_unsigned(75456, 19));
        wait for 20 ns;

        -- Test 7: Maximální čas pro 6 displejů -> 59 minut, 59 sekund, 99 setin
        -- Výpočet: 59*6000 + 59*100 + 99 = 359999
        time_in <= std_logic_vector(to_unsigned(359999, 19));
        wait for 20 ns;

        std.env.stop;
    end process;

end Behavioral;